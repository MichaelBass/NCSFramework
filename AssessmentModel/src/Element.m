//
//  Element.m
//  Created by Bass, Michael on 8/21/12.
//
//

#import "Element.h"

@interface Element()

@end

@implementation Element

@synthesize ElementOID;
@synthesize Description;
@synthesize ElementOrder;
@synthesize ElementType;
@synthesize resources;
@synthesize mappings;

- (id)init
{
    if (self = [super init])
    {
        self.resources = [[NSMutableArray alloc] initWithCapacity: 1];
        self.mappings = [[NSMutableArray alloc] initWithCapacity: 1];
        self.ElementOID = @"";
        self.Description = @"";
        self.ElementOrder = @"";
        self.ElementType = @"";
    }
    return self;
}

- (NSInteger) getNumResources
{
    return self.resources.count;
}

- (NSInteger) getNumMappings
{
    return self.mappings.count;
}

@end
