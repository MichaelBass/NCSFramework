//
//  Object.m
//
//  Created by Mike Rose on 11/7/13.0-
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Object.h"


@implementation Object
/*
@dynamic dateCreated;
@dynamic dateModified;
@dynamic uuid;
 */

/*
- (void)setUuid:(NSString *)uuid
{
    if (!self.uuid) {
        [self willChangeValueForKey:@"uuid"];
        [self setPrimitiveValue:uuid forKey:@"uuid"];
        [self didChangeValueForKey:@"uuid"];
    }
}

- (void)setDateCreated:(NSDate *)dateCreated
{
    if (!self.dateCreated) {
        [self willChangeValueForKey:@"dateCreated"];
        [self setPrimitiveValue:dateCreated forKey:@"dateCreated"];
        [self didChangeValueForKey:@"dateCreated"];
    }
}
*/
- (void)willSave
{
    NSDate *now = [NSDate date];
    if (!self.dateModified || [now timeIntervalSinceDate:self.dateModified] > 1.0) {
        self.dateModified = now;
    }
}

@end
