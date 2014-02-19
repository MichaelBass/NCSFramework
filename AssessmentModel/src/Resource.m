//
//  Resource.m
//
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import "Resource.h"

@implementation Resource

@synthesize ResourceOID;
@synthesize Description;
@synthesize Type;

- (id)init
{
    if (self = [super init])
    {
        self.ResourceOID = @"";
        self.Description = @"";
        self.Type = @"";
    }
    return self;
}

@end
