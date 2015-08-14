//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Mohit Sadhu on 8/9/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;

@end
