//
//  User.h
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Object.h"

@class Assessment;

@interface User : Object

@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, retain) NSDate *dob;
@property (nonatomic, readonly) NSString *dobString;
@property (nonatomic, retain) NSString *education;
@property (nonatomic, retain) NSString *language;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSSet *assessments;

+ (NSArray *)educationOptions;
+ (NSArray *)languageOptions;
+ (NSDateFormatter *)dateFormatter;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAssessmentsObject:(Assessment *)value;
- (void)removeAssessmentsObject:(Assessment *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

@end
