//
//  Object.h
//
//  Created by Mike Rose on 11/7/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Object : NSObject //NSManagedObject

@property (nonatomic, retain) NSDate *dateCreated;
@property (nonatomic, retain) NSDate *dateModified;
@property (nonatomic, retain) NSString *uuid;

@end
