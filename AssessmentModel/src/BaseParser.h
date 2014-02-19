//
//  BaseParser.h
//
//  Created by Bass, Michael on 10/4/13.
//  Copyright (c) 2013 MSS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemData.h"
#import "Element.h"
#import "Resource.h"
#import "Map.h"

@interface BaseParser : NSObject

- (void) parseElementNode: (NSDictionary*) elementDict item:(ItemData*) newItem;
- (void) parseResourcesNode: (NSDictionary*) dict addToArray: (NSMutableArray*) arr;
- (Resource*) parseResource: (NSDictionary*) resourceDict;
- (Map*) parseMap:(NSDictionary*) mapDict;
- (Element*) parseElement: (NSDictionary*) elementDict;
- (ItemData*) parseItem:(NSDictionary*) itemDict;

- (void) loadData: (NSMutableArray*) itemList params: (NSMutableDictionary*) dict;

@end
