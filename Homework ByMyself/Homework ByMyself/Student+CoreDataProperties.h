//
//  Student+CoreDataProperties.h
//  Homework ByMyself
//
//  Created by Qianfeng on 16/1/27.
//  Copyright © 2016年 ZZ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *information;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSData *headImageData;

@end

NS_ASSUME_NONNULL_END
