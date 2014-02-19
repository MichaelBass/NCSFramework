//
//  FlankerDataParser.m
//  NCS
//

#import "FlankerDataParser.h"
#import <AssessmentModel/ItemData.h>
#import <AssessmentModel/Element.h>
#import <AssessmentModel/Resource.h>
#import <AssessmentModel/Map.h>
#import <AssessmentModel/XMLReader.h>
#import <AssessmentModel/Range.h>
#import <AssessmentModel/Threshold.h>
#import <AssessmentModel/Criteria.h>


@interface FlankerDataParser ()
{
    
}

@end

@implementation FlankerDataParser

+ (NSMutableArray*) parseFormFile{
    
    NSMutableArray* rtn = [[NSMutableArray alloc] initWithCapacity:1];
    BaseParser * parser = [[BaseParser alloc] init];
 
    NSError* error;
    NSString *fileStr = [FlankerDataParser getXMLContent:@"FlankerForm.xml"];
 
    NSDictionary *xmlDict = [XMLReader dictionaryForXMLString:fileStr error:&error];
    
    NSDictionary* formDict = [xmlDict objectForKey:@"Form"];
    NSDictionary* itemsDict = [formDict objectForKey:@"Items"];
    NSArray* itemsArr = [itemsDict objectForKey:@"Item"];
    
    for(NSDictionary* itemDict in itemsArr)
    {
        // Parse item
        ItemData* newItem = [parser parseItem:itemDict];
        
        // Parse item elements
        NSDictionary* elementsDict = [itemDict objectForKey:@"Elements"];
        NSArray* elementsArr = [elementsDict objectForKey:@"Element"];
        
        // Thre returned object can be either a Dictionary or Array
        if([elementsArr isKindOfClass:[NSArray class]])
        {
            for(NSDictionary* element in elementsArr)
            {
                [parser parseElementNode:element item:newItem];
            }
        }
        else
        {
            [parser parseElementNode:(NSDictionary*)elementsArr item:newItem];
        }
        
        [rtn addObject:newItem];
    }
    
    return rtn;
    
}


- (void) loadData: (NSMutableArray*) itemList params: (NSMutableDictionary*) dict
{
    _itemList = itemList;
    _parameterDictionary = dict;
    
    [self parseFormFile];
    [self parseParamFile];
 }

- (void) parseParamFile
{
    
    NSError* error;
    NSString *fileStr = [FlankerDataParser getXMLContent:@"FlankerParameter.xml"];
    NSDictionary *xmlDict = [XMLReader dictionaryForXMLString:fileStr error:&error];
    NSDictionary* paramDict = [xmlDict objectForKey:@"Criterias"];
    NSDictionary* thresholdsDict = [paramDict objectForKey:@"Thresholds"];

    NSDictionary* item_thresholdsDict = [paramDict objectForKey:@"Item_Thresholds"];
 
    NSDictionary* item_thresholdDict = [item_thresholdsDict objectForKey:@"Item_Threshold"];

    
    
    id item_thresholdArr = [item_thresholdDict objectForKey:@"Item_Criteria"];
    

    NSMutableArray *myItem_Thresholds = [[NSMutableArray alloc] init];
        
    if([item_thresholdArr isKindOfClass:[NSArray class]])
    {
        // Parse out item thresholds
        for(NSDictionary* threshold in item_thresholdArr)
        {
            Threshold* newThreshold = [[Threshold alloc] init];
            
            newThreshold.ID = [NSString stringWithString:[threshold objectForKey:@"ID"]];
            newThreshold.Description = [NSString stringWithString:[threshold objectForKey:@"Pattern"]];
            newThreshold.Value = [[NSString stringWithString:[threshold objectForKey:@"Value"]] intValue];
            
            [myItem_Thresholds addObject:newThreshold];
            //[_param.thresholds addObject:newThreshold];//_parameterDictionary
            
        }
        
    }
    else
    {
        Threshold* newThreshold = [[Threshold alloc] init];
        
        newThreshold.ID = [NSString stringWithString:[item_thresholdArr objectForKey:@"ID"]];
        newThreshold.Description = [NSString stringWithString:[item_thresholdArr objectForKey:@"Pattern"]];
        newThreshold.Value = [[NSString stringWithString:[item_thresholdArr objectForKey:@"Value"]] intValue];
        
        [myItem_Thresholds addObject:newThreshold];
    }
    
    
    
    
    id thresholdArr = [thresholdsDict objectForKey:@"Threshold"];
    NSMutableArray *myThresholds = [[NSMutableArray alloc] init];

    
    if([thresholdArr isKindOfClass:[NSArray class]])
    {
        // Parse out thresholds
        for(NSDictionary* threshold in thresholdArr)
        {
            Threshold* newThreshold = [[Threshold alloc] init];
            
            newThreshold.ID = [NSString stringWithString:[threshold objectForKey:@"ID"]];
            newThreshold.Description = [NSString stringWithString:[threshold objectForKey:@"Description"]];
            newThreshold.Value = [[NSString stringWithString:[threshold objectForKey:@"Value"]] intValue];
            
            [myThresholds addObject:newThreshold];
            //[_param.thresholds addObject:newThreshold];//_parameterDictionary

        }
        
    }
    else
    {
        Threshold* newThreshold = [[Threshold alloc] init];
        
        newThreshold.ID = [NSString stringWithString:[thresholdArr objectForKey:@"ID"]];
        newThreshold.Description = [NSString stringWithString:[thresholdArr objectForKey:@"Description"]];
        newThreshold.Value = [[NSString stringWithString:[thresholdArr objectForKey:@"Value"]] intValue];
        
        [myThresholds addObject:newThreshold];
    }

    NSMutableArray *myRanges = [[NSMutableArray alloc] init];

    
    // Parse out ranges with criteria
    NSArray* rangeArr = [paramDict objectForKey:@"Range"];
    
    for(NSDictionary* range in rangeArr)
    {
        Range* newRange = [[Range alloc] init];
        
        newRange.ID = [NSString stringWithString:[range objectForKey:@"ID"]];
        newRange.Max = [[NSString stringWithString:[range objectForKey:@"Max"]] intValue];
        newRange.Min = [[NSString stringWithString:[range objectForKey:@"Min"]] intValue];
        
        NSArray* criteriaArr = [range objectForKey:@"Criteria"];
        
        for(NSDictionary* criteria in criteriaArr)
        {
            Criteria* newCriteria = [[Criteria alloc] init];
            
            if([criteria objectForKey:@"Section"])
                newCriteria.Section = [[NSString stringWithString:[criteria objectForKey:@"Section"]] intValue];
            
            if([criteria objectForKey:@"Threshold"])
                newCriteria.Threshold = [NSString stringWithString:[criteria objectForKey:@"Threshold"]];
            
            if([criteria objectForKey:@"Gate"])
                newCriteria.Gate = [NSString stringWithString:[criteria objectForKey:@"Gate"]];
 
            if([criteria objectForKey:@"Item_Gate"])
                newCriteria.ItemGate = [NSString stringWithString:[criteria objectForKey:@"Item_Gate"]];
            
            if([criteria objectForKey:@"Item_Threshold"]){
                newCriteria.IsItem = YES;
            }
            
            
            
            if([criteria objectForKey:@"IsItem"])
            {
                NSNumber* num = [criteria objectForKey:@"IsItem"];
                
                if(num)
                    newCriteria.IsItem = [num boolValue];
            }
            
            [newRange.criterias addObject:newCriteria];
        }
        
        [myRanges addObject:newRange];
        
        NSLog(@"");
    }

    [_parameterDictionary setValue:myItem_Thresholds forKey: @"Item_Thresholds"];
    [_parameterDictionary setValue:myRanges forKey: @"Ranges"];
    [_parameterDictionary setValue:myThresholds forKey: @"Thresholds"];

}


+ (NSString *) getXMLContent : (NSString *) fileName {

    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Flanker" ofType:@"bundle"]];
    
    NSError* error;
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: fileName ];
    NSString *fileStr = [NSString stringWithContentsOfFile: fileStr2 encoding: NSUTF8StringEncoding error: &error];
    
    return fileStr;
    
}

- (void) parseFormFile
{    
    NSError* error;
    NSString *fileStr = [FlankerDataParser getXMLContent:@"FlankerForm.xml"];
    
    NSDictionary *xmlDict = [XMLReader dictionaryForXMLString:fileStr error:&error];
    
    NSDictionary* formDict = [xmlDict objectForKey:@"Form"];
    NSDictionary* itemsDict = [formDict objectForKey:@"Items"];
    NSArray* itemsArr = [itemsDict objectForKey:@"Item"];
    
    for(NSDictionary* itemDict in itemsArr)
    {
        // Parse item
        ItemData* newItem = [self parseItem:itemDict];
        
        // Parse item elements
        NSDictionary* elementsDict = [itemDict objectForKey:@"Elements"];
        NSArray* elementsArr = [elementsDict objectForKey:@"Element"];
        
        // Thre returned object can be either a Dictionary or Array
        if([elementsArr isKindOfClass:[NSArray class]])
        {
            for(NSDictionary* element in elementsArr)
            {
                [self parseElementNode:element item:newItem];
            }
        }
        else
        {
            [self parseElementNode:(NSDictionary*)elementsArr item:newItem];
        }
        
        [_itemList addObject:newItem];
    }
    
}

@end
