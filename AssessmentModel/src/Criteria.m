//
//  Criteria.m
//  NCS
//
//  Created by Alexander Holden on 3/18/13.
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import "Criteria.h"

@interface Criteria()

@end

@implementation Criteria

@synthesize Section;
@synthesize Threshold;
@synthesize Gate;
@synthesize IsItem;


- (id)init
{
    if (self = [super init])
    {
        self.Section = 0;
        self.Threshold = @"";
        self.Gate = @"";
        self.ItemGate = @"";
        self.IsItem = NO;
        self.Type = 0;

    }
    return self;
}

@end
