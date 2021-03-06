//
//  Criteria.h
//  NCS
//
//  Created by Alexander Holden on 3/18/13.
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Criteria : NSObject

@property int Section;
@property (nonatomic, retain) NSString* Threshold;
@property BOOL IsItem;
@property (nonatomic, retain) NSString* Gate;
@property (nonatomic, retain) NSString* ItemGate;
@property int Type;
@end
