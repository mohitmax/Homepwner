//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Mohit Sadhu on 8/14/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()
<UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *removePictureButton;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end

@implementation BNRDetailViewController
{
    
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imagePicker = [[UIImagePickerController alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:self.item.itemName];
    
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    if (!imageToDisplay)
    {
        self.removePictureButton.enabled = false;
    }
    else
    {
        self.imageView.image = imageToDisplay;
        self.removePictureButton.enabled = true;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //This will clear first responder. Keyboard will go away.
    [self.view endEditing:YES];
    
    //Save the data.
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = self.valueField.text.intValue;
}

#pragma mark - Action methods

- (IBAction)takePicture:(id)sender
{
    BOOL cameraAvailableFlag = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (cameraAvailableFlag)
        [self performSelector:@selector(showCameraController) withObject:nil afterDelay:0.3];
    else
        [self performSelector:@selector(showCameraRoll) withObject:nil afterDelay:0.3];
}

- (void)showCameraController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    _imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    _imagePicker.delegate = self;
    [_imagePicker setAllowsEditing:YES];
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)selectPicture:(id)sender
{
    [self showCameraRoll];
}

- (void)showCameraRoll
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    imgPicker.delegate = self;
    [imgPicker setAllowsEditing:YES];
    
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)removePicture:(id)sender
{
    if (self.imageView.image)
    {
        [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemKey];
        self.imageView.image = nil;
        self.removePictureButton.enabled = false;
    }
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get image from the info dictionary
    UIImage *image = [[UIImage alloc] init];
//    image = info[UIImagePickerControllerOriginalImage];
    image = info[UIImagePickerControllerEditedImage];
    
//    Store the image in the BNRImageStore for this key.
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    //Dismiss the image picker 
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Touch Events
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

@end
