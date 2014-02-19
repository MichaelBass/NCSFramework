//
//  Instrument.m
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument

/*
@dynamic dateFinishedString;
@dynamic dateStartedString;
@dynamic dateFinished;
@dynamic dateStarted;
@dynamic dateUploaded;
@dynamic index;
@dynamic score;
//@dynamic title;
//@dynamic type;
@dynamic uploadOID;
@dynamic items;
*/

/*
+ (NSArray *)instrumentTypes
{    
    return @[ [NSNumber numberWithInteger:NCSInstrumentTypeDCCS], [NSNumber numberWithInteger:NCSInstrumentTypeFlanker], [NSNumber numberWithInteger:NCSInstrumentTypePSM], [NSNumber numberWithInteger:NCSInstrumentTypePictureVocab], [NSNumber numberWithInteger:NCSInstrumentTypePictureVocabPractice] ];
}


+ (NSString *)instrumentTitleForInstrumentType:(NSNumber *)type
{
    switch (type.integerValue) {
        case NCSInstrumentTypeDCCS:
            return @"DCCS";
        case NCSInstrumentTypeFlanker:
            return @"Flanker";
        case NCSInstrumentTypePSM:
            return @"Picture Sequence Memory";
        case NCSInstrumentTypePictureVocab:
            return @"Picture Vocabulary";
        case NCSInstrumentTypePictureVocabPractice:
            return @"Picture Vocabulary Practice";
        default:
            return nil;
    }
}
 */

+ (NSString *)statusStringForStatus:(NSNumber *)status
{
    switch (status.integerValue) {
        case NCSInstrumentStatusScheduled:
            return @"Scheduled";
        case NCSInstrumentStatusInProgress:
            return @"In Progress";
        case NCSInstrumentStatusCompleted:
            return @"Completed";
        case NCSInstrumentStatusUploaded:
            return @"Uploaded";
        default:
            return nil;
    }
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy hh:mm:ss"];
    return dateFormatter;
}

/*
- (NSString *)title
{
    [self willAccessValueForKey:@"title"];
    [self didAccessValueForKey:@"title"];
    
    return [Instrument instrumentTitleForInstrumentType:self.type];
}

- (void)setType:(NSNumber *)type
{
    [self willChangeValueForKey:@"type"];
    [self willChangeValueForKey:@"title"];
    
    [self setPrimitiveValue:type forKey:@"type"];
    
    [self didChangeValueForKey:@"type"];
    [self didChangeValueForKey:@"title"];
}

- (void)setDateFinished:(NSDate *)dateFinished
{
    [self willChangeValueForKey:@"dateFinished"];
    [self willChangeValueForKey:@"dateFinishedString"];
    
    [self setPrimitiveValue:dateFinished forKey:@"dateFinished"];
    
    [self didChangeValueForKey:@"dateFinished"];
    [self didChangeValueForKey:@"dateFinishedString"];
}

- (NSString *)dateFinishedString
{
    [self willAccessValueForKey:@"dateFinishedString"];
    [self didAccessValueForKey:@"dateFinishedString"];
    if (self.dateFinished) {
        return [[Instrument dateFormatter] stringFromDate:self.dateFinished];
    } else {
        return @"";
    }
}

- (NSString *)dateStartedString
{
    [self willAccessValueForKey:@"dateStartedString"];
    [self didAccessValueForKey:@"dateStartedString"];
    if (self.dateStarted) {
        return [[Instrument dateFormatter] stringFromDate:self.dateStarted];
    } else {
        return @"";
    }
}
- (void)setDateStarted:(NSDate *)dateStarted
{
    [self willChangeValueForKey:@"dateStarted"];
    [self willChangeValueForKey:@"dateStartedString"];
    
    [self setPrimitiveValue:dateStarted forKey:@"dateStarted"];
    
    [self didChangeValueForKey:@"dateStarted"];
    [self didChangeValueForKey:@"dateStartedString"];
}

- (void)setStatus:(NSNumber *)status
{
    [self willChangeValueForKey:@"status"];
    [self willChangeValueForKey:@"statusString"];
    
    [self setPrimitiveValue:status forKey:@"status"];
    
    [self didChangeValueForKey:@"status"];
    [self didChangeValueForKey:@"statusString"];
}

- (NSNumber *)status
{
    [self willAccessValueForKey:@"status"];
    [self didAccessValueForKey:@"status"];
    if (self.dateStarted && self.dateFinished && self.uploadOID) {
        return [NSNumber numberWithInteger:NCSInstrumentStatusUploaded];
    } else if (self.dateStarted && self.dateFinished) {
        return [NSNumber numberWithInteger:NCSInstrumentStatusCompleted];
    } else if (self.dateStarted) {
        return [NSNumber numberWithInteger:NCSInstrumentStatusInProgress];
    } else {
        return [NSNumber numberWithInteger:NCSInstrumentStatusScheduled];
    }
}

- (NSString *)statusString
{
    [self willAccessValueForKey:@"statusString"];
    [self didAccessValueForKey:@"statusString"];
    return [Instrument statusStringForStatus:self.status];
}
*/
@end
