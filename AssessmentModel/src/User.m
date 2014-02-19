//
//  User.m
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "User.h"
#import "Assessment.h"


@implementation User
/*
@dynamic dob;
@dynamic education;
@dynamic language;
@dynamic title;
@dynamic age;
@dynamic dobString;
@dynamic assessments;
*/
+ (NSArray *)educationOptions
{
    return @[
        @"None",
        @"Preschool",
        @"Kindergarten",
        @"1st grade",
        @"2nd grade",
        @"3rd grade",
        @"4th grade",
        @"5th grade",
        @"6th grade",
        @"7th grade",
        @"8th grade",
        @"9th grade",
        @"10th grade",
        @"11th grade",
        @"12th grade (no diploma)",
        @"High school graduate",
        @"GED",
        @"Some college credit but less than 1 year",
        @"One or more years of college, no degree",
        @"Associates degree (AA, AS)",
        @"Bachelor's degree (BA, AB, BS)",
        @"Masters degree (MA, MS, MEng, MEd, MSW, MBA)",
        @"Professional degree (e.g. MD, DDS, DVM, LLB, JD)",
        @"Doctorate degree (PhD, EdD)"
    ];
}

+ (NSArray *)languageOptions
{
    return @[
        @"English",
        @"Spanish"
    ];
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    return dateFormatter;
}
/*
- (void)setDob:(NSDate *)dob
{
    [self willChangeValueForKey:@"dob"];
    [self willChangeValueForKey:@"dobString"];
    [self willChangeValueForKey:@"age"];
    
    [self setPrimitiveValue:dob forKey:@"dob"];
    
    [self didChangeValueForKey:@"dob"];
    [self didChangeValueForKey:@"dobString"];
    [self didChangeValueForKey:@"age"];
}

- (NSNumber *)age
{
    [self willAccessValueForKey:@"age"];
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.dob toDate:now options:0];
    [self didAccessValueForKey:@"age"];
    
    return [NSNumber numberWithInteger:ageComponents.year];
}

- (NSString *)dobString
{
    [self willAccessValueForKey:@"dobString"];
    [self didAccessValueForKey:@"dobString"];
    return [[User dateFormatter] stringFromDate:self.dob];
}
*/

@end
