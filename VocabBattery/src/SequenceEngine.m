//
//  SequenceEngine.m
//  SequenceEngine
//
//  Created by Bass, Michael on 8/7/12.
//  Copyright (c) 2012 Bass, Michael. All rights reserved.
//



#import "SequenceEngine.h"
#import <AssessmentModel/ItemCalibration.h>
#import <AssessmentModel/Result.h>
#import <AssessmentModel/ItemData.h>
#import <AssessmentModel/Element.h>
#import <AssessmentModel/Map.h>
#import <AssessmentModel/Result.h>
#import <AssessmentModel/UUID.h>

@interface SequenceEngine()

@property (nonatomic, strong) NSMutableArray *ItemResponseList;
@property int position;
@property int age;
@end



@implementation SequenceEngine
/*
 @property (nonatomic, copy) NSArray *ItemList;
 @property (nonatomic, copy) NSMutableDictionary *ParameterDictionary;
 @property (nonatomic, copy) NSArray *ResultSetList;
 @property (nonatomic) double Ability;
 @property (nonatomic) double SE;
 @property (nonatomic, strong) NSString *itemID;
 @property (nonatomic) Boolean finished;
 @property (nonatomic, strong) NSString *trace;
 
 */
@synthesize position = _position;
@synthesize age = _age;
@synthesize ItemResponseList = _ItemResponseList;
@synthesize ResultSetList = _ResultSetList;
@synthesize itemID = _itemID;
@synthesize trace = _trace;
@synthesize ItemList = _ItemList;

@synthesize finished = _finished;
//@synthesize Ability = _Ability;
//@synthesize SE = _SE;


-(NSArray *) getNextSection{ return nil; }

-(NSMutableArray*)ItemResponseList{
    
    if(!_ItemResponseList){
        
        NSMutableArray *myitemResponseList = [[NSMutableArray alloc] init];
        _ItemResponseList = myitemResponseList;
    }
    return _ItemResponseList;
}


-(float) getScore{
    
  /*  int pos = [self.ItemResponseList count];
    
    if(pos > 0)
        --pos;
    
    if(self.ItemResponseList.count)
        return ((Result*)[self.ItemResponseList objectAtIndex: pos]).Score;
   */ 
    return 0.0;
}

-(float) getError{
   /*
    int pos = [self.ItemResponseList count];
    
    if(pos > 0)
        --pos;
    
    if(self.ItemResponseList.count)
        return ((Result*)[self.ItemResponseList objectAtIndex: pos]).SE = self.SE;
    else
        return  0;
    */
    return  0.0;
}
 
-(void)setStartItem:(NSString*)firstItemID{

    self.position = [firstItemID intValue];
    int iPos = 0;
    
    // Locate item in the list with this ID
    for(ItemData* i in _ItemList)
    {
        if([i.FormItemOID isEqualToString:firstItemID])
        {
            self.position = iPos;
            break;
        }
        
        ++iPos;
    }

}
-(void)setUserAge:(int)age{
 
    self.age = age;      
}

-(void)setUser:(User *)user {
    self.age = user.age.intValue;
}

-(void)setItemList:(NSArray*) value{

    if (self) {
        _ItemList = value;
       [self checkForAdministeredItems];
    }
}


-(void)checkForAdministeredItems{

    for(int i = 0; i < _ItemList.count; i++){
        
        ItemData *testItem = (ItemData*)[_ItemList objectAtIndex:i];

        if(![@""  isEqual: testItem.ItemDataOID]){
            
            // increment position, so the next item will be next (0-based array)
            self.position = [testItem.Position intValue] + 1;
         }
    }
    
}




-(id)initwithParameterDictionary :(NSMutableDictionary *) paramdictionary 
{
    if (self) {
        return self;
    }
 
    return nil;
}


-(ItemData*) getItem :(NSString*) ID
{
    
    if([ID isEqual:@""]) {
        return nil;
    }
    
    if([self.ItemResponseList count] >= self.ItemList.count){
        return nil;
    }
    
    return (ItemData*)[self.ItemList objectAtIndex: self.position ];

    
}

-(NSString *)getNextItem
{
    
    if(self.position >= self.ItemList.count){
        self.position = -1;
        return @"";
    }

   
    if(self.position == -1){
        return @"";
    }
    
    ItemData *myItem = [self.ItemList objectAtIndex:self.position];
    
    self.itemID = myItem.ID;

     
    return self.itemID;
      
}


- (int) getCorrectAnswers
{
    
    int _rtn = 0;
    
    for (Result *myResult in self.ItemResponseList) {
        if( myResult.Answer == 1){
            _rtn += 1;
        }
    }

    
    return _rtn;
    
}


-(NSArray *) processResponses: (NSArray *) responses responsetime:(double) responsetime{
    
    NSNumber* myNumber = (NSNumber *)[responses objectAtIndex:0];
    ItemData* myItemData = [self processResponse:[myNumber intValue] responsetime:responsetime];
    return [NSArray arrayWithObject:myItemData];
    
}

- (ItemData*) processResponse:(int)response
{
    
    ItemData *myItem = [self getItem:self.itemID];
    myItem.ItemDataOID = [UUID generate];
    
   
    for(Element* e in myItem.elements)
    {
        for(Map* m in e.mappings)
        {
            if( [ m.Description isEqualToString:[[NSNumber numberWithInt:response] stringValue]] ){
                myItem.ItemResponseOID = m.ItemResponseOID;
                myItem.Response = m.Value;
                myItem.ResponseDescription = m.Description;
                break;
            }
        }
    }
  
    myItem.Position = [[NSNumber numberWithInt:self.position] stringValue];
    self.position += 1;

    return myItem;
    
}
- (ItemData*) processResponse:(int)response responsetime:(double)responsetime
{
    ItemData *myItem = [self getItem:self.itemID];
    myItem.ItemDataOID = [UUID generate];
    
    
    for(Element* e in myItem.elements)
    {
        for(Map* m in e.mappings)
        {
            if( [ m.Value isEqualToString:[[NSNumber numberWithInt:response] stringValue]] ){
                myItem.ItemResponseOID = m.ItemResponseOID;
                myItem.Response =  m.Description;
                myItem.ResponseDescription = m.Description;
                break;
            }
        }
    }
    
    myItem.Position = [[NSNumber numberWithInt:self.position] stringValue];
    self.position += 1;
    
    return myItem;
}

-(void) getResults
{
    for (Result *myResult in self.ItemResponseList) {
        NSLog(@"%@  : %i : %f  : %f : %f",  myResult.ItemID, myResult.Answer,myResult.Score, myResult.SE, myResult.ResponseTime );
    } 
    
}

-(NSArray *)ResultSetList{

    return [self.ItemResponseList copy];
}
@end

