//
//  Item.h
//
//  Created by Mike Rose on 11/7/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Object.h"

@class Instrument;

@interface Item : Object

@property (nonatomic, retain) NSString * formItemOID;
@property (nonatomic, retain) NSString * itemDataOID;
@property (nonatomic, retain) NSString * itemResponseOID;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * response;
@property (nonatomic, retain) NSNumber * responseTime;
@property (nonatomic, retain) Instrument *instrument;

@end
