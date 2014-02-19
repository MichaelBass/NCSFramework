//
//  BaseParser.m
//
//  Created by Bass, Michael on 10/4/13.
//  Copyright (c) 2013 MSS. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser

-(void) loadData: (NSMutableArray*) itemList params: (NSMutableDictionary*) dict{

}

- (ItemData*) parseItem:(NSDictionary*) itemDict
{
    ItemData* newItem = [[ItemData alloc] init];
    
    newItem.ID = [NSString stringWithString:[itemDict objectForKey:@"ID"]];
    newItem.ItemDataOID = [NSString stringWithString:[itemDict objectForKey:@"ItemDataOID"]];
    newItem.FormItemOID = [NSString stringWithString:[itemDict objectForKey:@"FormItemOID"]];
    newItem.ItemResponseOID = [NSString stringWithString:[itemDict objectForKey:@"ItemResponseOID"]];
    newItem.Response = [NSString stringWithString:[itemDict objectForKey:@"Response"]];
    newItem.ResponseTime = [NSString stringWithString:[itemDict objectForKey:@"ResponseTime"]];
    newItem.ResponseDescription = [NSString stringWithString:[itemDict objectForKey:@"ResponseDescription"]];
    newItem.Position = [NSString stringWithString:[itemDict objectForKey:@"Position"]];
    newItem.Section = [[NSString stringWithString:[itemDict objectForKey:@"Section"]] intValue];
    newItem.Order = [[NSString stringWithString:[itemDict objectForKey:@"Order"]] intValue];
    newItem.StyleSheet = [NSString stringWithString:[itemDict objectForKey:@"StyleSheet"]];
    
    return newItem;
}

- (Element*) parseElement: (NSDictionary*) elementDict
{
    Element* newElement = [[Element alloc] init];
    
    newElement.ElementOID = [elementDict objectForKey:@"ElementOID"];
    newElement.Description = [elementDict objectForKey:@"Description"];
    newElement.ElementOrder = [elementDict objectForKey:@"ElementOrder"];
    newElement.ElementType = [elementDict objectForKey:@"ElementType"];
    
    return newElement;
}

- (Map*) parseMap:(NSDictionary*) mapDict
{
    Map* newMap = [[Map alloc] init];
    
    newMap.ElementOID = [mapDict objectForKey:@"ElementOID"];
    newMap.Description = [mapDict objectForKey:@"Description"];
    newMap.ItemResponseOID = [mapDict objectForKey:@"ItemResponseOID"];
    newMap.FormItemOID = [mapDict objectForKey:@"FormItemOID"];
    newMap.DataType = [mapDict objectForKey:@"DataType"];
    newMap.Position = [mapDict objectForKey:@"Position"];
    newMap.Value = [mapDict objectForKey:@"Value"];
    
    return newMap;
}

- (Resource*) parseResource: (NSDictionary*) resourceDict
{
    Resource* newResource = [[Resource alloc] init];
    
    newResource.Description = [NSString stringWithString:[resourceDict objectForKey:@"Description"]];
    
    // remove html tags if any
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"lt;" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"&" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"br/" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"gt;" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"lt;" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"lt;" withString:@""];
    newResource.Description = [newResource.Description stringByReplacingOccurrencesOfString:@"img src='star.jpg'/" withString:@""];
    newResource.ResourceOID = [NSString stringWithString:[resourceDict objectForKey:@"ResourceOID"]];
    newResource.Type = [NSString stringWithString:[resourceDict objectForKey:@"Type"]];
    
    return newResource;
}

- (void) parseResourcesNode: (NSDictionary*) dict addToArray: (NSMutableArray*) arr
{
    NSDictionary* resourcesDict = [dict objectForKey:@"Resources"];
    
    if(resourcesDict && resourcesDict.count)
    {
        NSArray* resourcesArr = [resourcesDict objectForKey:@"Resource"];
        
        if(resourcesArr && resourcesArr.count)
        {
            // Thre returned object can be either a Dictionary or Array
            if([resourcesArr isKindOfClass:[NSArray class]])
            {
                for(NSDictionary* resource in resourcesArr)
                {
                    Resource* newResource = [self parseResource:resource];
                    [arr addObject:newResource];
                }
            }
            else
            {
                Resource* newResource = [self parseResource:(NSDictionary*)resourcesArr];
                [arr addObject:newResource];
            }
        }
    }
}

- (void) parseElementNode: (NSDictionary*) elementDict item:(ItemData*) newItem
{
    Element* newElement = [self parseElement:elementDict];
    
    // Parse Resources node under elements
    [self parseResourcesNode:elementDict addToArray:newElement.resources];
    
    // Parse Mappings node
    NSDictionary* mappingsDict = [elementDict objectForKey:@"Mappings"];
    
    if(mappingsDict && mappingsDict.count)
    {
        NSArray* mappingArr = [mappingsDict objectForKey:@"Map"];
        
        if(mappingArr)
        {
            for(NSDictionary* map in mappingArr)
            {
                
                Map* newMap = [self parseMap:map];
                
                // Parse Resources node under Mappings
                [self parseResourcesNode:map addToArray:newMap.resources];
                [newElement.mappings addObject:newMap];
            }
        }
    }
    
    [newItem.elements addObject:newElement];
}

@end
