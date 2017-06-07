//
//  Msg+CoreDataProperties.h
//  MagicalRecord
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Msg.h"

NS_ASSUME_NONNULL_BEGIN

@interface Msg (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSNumber *isComing;
@property (nullable, nonatomic, retain) NSNumber *isSending;

@end

NS_ASSUME_NONNULL_END
