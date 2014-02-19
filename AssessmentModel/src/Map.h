//
//  Map.h
//
//  Copyright (c) 2013 NCS. All rights reserved.
//

/*
 
 Maps are the meta data that represent user input options.
 
 */

#import <Foundation/Foundation.h>

@interface Map : NSObject

@property (nonatomic, retain) NSString* ElementOID;
@property (nonatomic, retain) NSString* Description;
@property (nonatomic, retain) NSString* ItemResponseOID;
@property (nonatomic, retain) NSString* FormItemOID;
@property (nonatomic, retain) NSString* DataType;
@property (nonatomic, retain) NSString* Position;
@property (nonatomic, retain) NSString* Value;
@property (nonatomic, retain) NSMutableArray* resources;

@end
