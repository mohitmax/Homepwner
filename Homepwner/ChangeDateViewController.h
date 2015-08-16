//
//  ChangeDateViewController.h
//  Homepwner
//
//  Created by Mohit Sadhu on 8/15/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface ChangeDateViewController : UIViewController

@property (nonatomic, strong) NSDate *itemDate;
@property (nonatomic, strong) BNRItem *item;

@end
