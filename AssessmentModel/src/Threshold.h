//
//  Threshold.h
//  NCS
//
//  Created by Alexander Holden on 3/18/13.
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Threshold : NSObject

@property (nonatomic, retain) NSString* ID;
@property (nonatomic, retain) NSString* Description;
@property int Value;
@property int UserValue;
@property int Section;
@end
