//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Mohit Sadhu on 8/9/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;

//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        sharedStore = [[BNRItemStore alloc] init];
//    });
    
    if (!sharedStore)
    {
        sharedStore = [[BNRItemStore alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [BNRItemStore sharedStore]"
                                 userInfo:nil];
    
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if (self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return  [self.privateItems copy];
}

#pragma mark - public methods
- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    
    return item;
}

- (BNRItem *)createNoMoreItem
{
    BNRItem *item = [[BNRItem alloc] initWithItemName:@"No More Items"];
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex)
        return;
    
    //Get pointer to object that is being moved.
    BNRItem *item = self.privateItems[fromIndex];
    
    //Remove the item from the array.
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert the same item to array
    [self.privateItems insertObject:item atIndex:toIndex];
    
}

@end
