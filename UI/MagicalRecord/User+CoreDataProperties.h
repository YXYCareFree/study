//
//  User+CoreDataProperties.h
//  MagicalRecord
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSSet<Msg *> *msg;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMsgObject:(Msg *)value;
- (void)removeMsgObject:(Msg *)value;
- (void)addMsg:(NSSet<Msg *> *)values;
- (void)removeMsg:(NSSet<Msg *> *)values;

@end

NS_ASSUME_NONNULL_END
