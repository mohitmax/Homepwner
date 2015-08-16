//
//  ChangeDateViewController.m
//  Homepwner
//
//  Created by Mohit Sadhu on 8/15/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import "ChangeDateViewController.h"
#import "BNRItem.h"

@interface ChangeDateViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation ChangeDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datePicker.date = self.item.dateCreated;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.item.dateCreated = self.datePicker.date;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
