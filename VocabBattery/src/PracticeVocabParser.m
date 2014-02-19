//
//  DCCSDataParser.m
//  NCS
//
//  Copyright (c) 2013 NCS. All rights reserved.
//

#import "PracticeVocabParser.h"
#import <AssessmentModel/ItemData.h>
#import <AssessmentModel/Element.h>
#import <AssessmentModel/Resource.h>
#import <AssessmentModel/Map.h>
#import <AssessmentModel/XMLReader.h>
#import <AssessmentModel/ItemCalibration.h>

@interface PracticeVocabParser ()
{
    
}
@end

@implementation PracticeVocabParser

+ (NSString *) getXMLContent : (NSString *) fileName {
    
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Vocab" ofType:@"bundle"]];
    
    NSError* error;
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: fileName ];
    NSString *fileStr = [NSString stringWithContentsOfFile: fileStr2 encoding: NSUTF8StringEncoding error: &error];
    
    return fileStr;
    
}
- (void) loadData: (NSMutableArray*) itemList params: (NSMutableDictionary*) dict
{
    _itemList = itemList;
    _parameterDictionary = dict;
    
    [self parseFormFile];
    
}

+ (NSMutableArray*) parseFormFile{

    NSMutableArray* rtn = [[NSMutableArray alloc] initWithCapacity:1];
    BaseParser * parser = [[BaseParser alloc] init];

    NSError* error;
    NSString *fileStr = [PracticeVocabParser getXMLContent:@"Picture Vocabulary PracticeForm.xml"];
    

    /*
    NSString* formFileName =@"Picture Vocabulary PracticeForm";
    
    NSError* error;
    NSString *path = [[NSBundle mainBundle] pathForResource:formFileName ofType: @"xml"];
    NSString *fileStr = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: &error];
    */
    
    
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


- (void) parseFormFile
{
    
    NSError* error;
    NSString *fileStr = [PracticeVocabParser getXMLContent:@"Picture Vocabulary PracticeForm.xml"];

    /*
    NSString* formFileName =@"Picture Vocabulary PracticeForm";

    NSError* error;
    NSString *path = [[NSBundle mainBundle] pathForResource:formFileName ofType: @"xml"];
    NSString *fileStr = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: &error];
    */
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
