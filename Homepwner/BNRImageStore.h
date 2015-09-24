//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Mohit Sadhu on 9/22/15.
//  Copyright © 2015 Mohit Sadhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage: (UIImage *)image forKey: (NSString *)key;
- (UIImage *)imageForKey: (NSString *)key;
- (void)deleteImageForKey: (NSString *)key;

@end
