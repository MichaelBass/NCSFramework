//
//  Assessment.m
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Assessment.h"
#import "Instrument.h"
#import "User.h"

@implementation Assessment

/*
@dynamic admin;
@dynamic status;
@dynamic statusString;
@dynamic title;
@dynamic type;
@dynamic instruments;
@dynamic user;
*/

+ (NSArray *)batteryTypes
{
    return @[ [NSNumber numberWithInteger:NCSBatteryType36Month], [NSNumber numberWithInteger:NCSBatteryTypeShortcut] ];
}

+ (NSString *)batteryTitleForBatteryType:(NSNumber *)type
{
    switch (type.integerValue) {
        case NCSBatteryType36Month:
            return @"36 Month Visit";
        case NCSBatteryTypeShortcut:
            return @"Shortcut";
        default:
            return nil;
    }
    
}
/*
+ (NSArray *)instrumentTypesForBatteryType:(NSNumber *)type
{
    switch (type.integerValue) {
        case NCSBatteryType36Month:
            return @[ [NSNumber numberWithInteger:NCSInstrumentTypePictureVocabPractice], [NSNumber numberWithInteger:NCSInstrumentTypePictureVocab], [NSNumber numberWithInteger:NCSInstrumentTypeDCCS], [NSNumber numberWithInteger:NCSInstrumentTypeFlanker], [NSNumber numberWithInteger:NCSInstrumentTypePSM] ];
        case NCSBatteryTypeShortcut:
            return @[ [NSNumber numberWithInteger:NCSInstrumentTypeFlanker] ];
        default:
            return nil;
    }
}
 */

+ (NSString *)statusStringForStatus:(NSNumber *)status
{
    switch (status.integerValue) {
        case NCSAssessmentStatusScheduled:
            return @"Scheduled";
        case NCSAssessmentStatusInProgress:
            return @"In Progress";
        case NCSAssessmentStatusCompleted:
            return @"Completed";
        case NCSAssessmentStatusUploaded:
            return @"Uploaded";
        default:
            return nil;
    }
}

+ (NSArray *)statuses
{
  return @[ [NSNumber numberWithInteger:NCSAssessmentStatusScheduled], [NSNumber numberWithInteger:NCSAssessmentStatusInProgress], [NSNumber numberWithInteger:NCSAssessmentStatusCompleted], [NSNumber numberWithInteger:NCSAssessmentStatusUploaded] ];
}

+ (NSArray *)statusTitles
{
    return @[ @"Scheduled", @"In Progress", @"Completed", @"Uploaded" ];
}

/*
- (void)setStatus:(NSNumber *)status
{
    [self willChangeValueForKey:@"status"];
    [self willChangeValueForKey:@"statusString"];
    
    [self setPrimitiveValue:status forKey:@"status"];
    
    [self didChangeValueForKey:@"status"];
    [self didChangeValueForKey:@"statusString"];
}

- (NSString *)statusString
{
    [self willAccessValueForKey:@"statusString"];
    [self didAccessValueForKey:@"statusString"];
    return [Assessment statusStringForStatus:self.status];
}
*/

@end
