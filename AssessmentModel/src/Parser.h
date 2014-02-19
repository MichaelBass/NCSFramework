//
//  Parser.h
//  Model
//
//  Created by Bass, Michael on 2/11/14.
//  Copyright (c) 2014 MSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Parser <NSObject>
@required

@property (nonatomic, copy)NSMutableArray* itemList;
@property (nonatomic, copy) NSMutableDictionary* parameterDictionary;

- (void) loadData: (NSMutableArray*) itemList params: (NSMutableDictionary*) dict;
- (NSMutableArray*) parseFormFile;

@end
