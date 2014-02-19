//
//  ProgressiveSectionalEngine.m
//  NIHToolboxCognition
//
//  Created by Bass, Michael on 8/29/12.
//
//

#import "ProgressiveSectionalEngine.h"
#import <AssessmentModel/ItemData.h>
#import <AssessmentModel/Element.h>
#import <AssessmentModel/Map.h>
#import <AssessmentModel/Result.h>
#import <AssessmentModel/Threshold.h>
#import <AssessmentModel/Criteria.h>
#import <AssessmentModel/Range.h>
#import <AssessmentModel/UUID.h>

@interface ProgressiveSectionalEngine()

@property int position;
@property int section;
@property int age;
@property int score;

@property (nonatomic, strong) NSMutableDictionary *sectionItems;
@property (nonatomic, strong) NSMutableDictionary *sectionThresholds;
@property (nonatomic, strong) NSMutableDictionary *itemThresholds;
@property (nonatomic, strong) NSMutableDictionary *sectionCriteria;
@property (nonatomic, strong) NSMutableDictionary *ranges;
@property (nonatomic, strong) Range* range;
@property (nonatomic, strong) NSMutableArray *ItemRangeList;
@property (nonatomic, strong) NSMutableArray *ItemResponseList;



-(void)calculateItemScore:(ItemData*) item response:(int) response;
-(void)calculateSectionScore:(ItemData*) item response:(int) response;
-(void)loadSectionalDictionary;
-(void)loadSectionalThresholds: (NSMutableArray*) thresholds;
-(void)loadItemThresholds: (NSMutableArray*) thresholds;
-(void)loadSectionalCriteria: (Criteria*) criteria;
-(void)loadRanges: (NSMutableArray*) ranges;
//-(void)setSectionItem:(int) section;
-(void)evaluateCriteria;
-(void)evaluateItemCriteria;
-(void)shuffle: (NSMutableArray*) sectionalItems;

@end

@implementation ProgressiveSectionalEngine

-(NSArray *) getNextSection{ return nil; }

#pragma mark - private primative properties -
@synthesize position = _position;
@synthesize section = _section;
@synthesize age = _age;
@synthesize score = _score;

#pragma mark - private object properties -
@synthesize sectionItems = _sectionItems;
@synthesize sectionThresholds = _sectionThresholds;
@synthesize itemThresholds = _itemThresholds;
@synthesize sectionCriteria = _sectionCriteria;
@synthesize ranges = _ranges;
@synthesize range = _range;
@synthesize ItemRangeList = _ItemRangeList;
@synthesize ItemResponseList = _ItemResponseList;

#pragma mark - private getters -

-(NSMutableArray*)ItemResponseList{
    
    if(!_ItemResponseList){
        
        NSMutableArray *myitemResponseList = [[NSMutableArray alloc] init];
        _ItemResponseList = myitemResponseList;
    }
    return _ItemResponseList;
}

-(NSMutableArray*)ItemRangeList{
    
    if(!_ItemRangeList){
        
        NSMutableArray *myitemRangeList = [[NSMutableArray alloc] init];
        _ItemRangeList = myitemRangeList;
    }
    return _ItemRangeList;
}
-(NSDictionary*)sectionCriteria{
    
    if(!_sectionCriteria){
        NSMutableDictionary *mysectionCriteria = [[NSMutableDictionary alloc] init];
        _sectionCriteria = mysectionCriteria;
     }
    return _sectionCriteria;
}
-(NSDictionary*)ranges{
    
    if(!_ranges){
        NSMutableDictionary *myranges = [[NSMutableDictionary alloc] init];
        _ranges = myranges;
    }
    return _ranges;
}
-(NSDictionary*)sectionThresholds{
    
    if(!_sectionThresholds){
        NSMutableDictionary *mysectionThresolds = [[NSMutableDictionary alloc] init];
        _sectionThresholds = mysectionThresolds;
    }
    return _sectionThresholds;
}

-(NSDictionary*)itemThresholds{
    
    if(!_itemThresholds){
        NSMutableDictionary *myitemThresolds = [[NSMutableDictionary alloc] init];
        _itemThresholds = myitemThresolds;
    }
    return _itemThresholds;
}
-(NSDictionary*)sectionItems{
    
    if(!_sectionItems){
        NSMutableDictionary *mysectionItems = [[NSMutableDictionary alloc] init];
        _sectionItems = mysectionItems;
     }
    return _sectionItems;
}
#pragma mark - private setter -
/*
-(void) setSectionItem:(int) section{
    
    for(int i = 0; i < self.ItemList.count; i++){
        NCSItem* item = [self.ItemList objectAtIndex:i];
        
        if(section == [item.Order intValue]){
            self.position =i;
            break;
        }
    }
}
*/

#pragma mark - public properties -
@synthesize ItemList = _ItemList;
@synthesize ParameterDictionary = _ParameterDictionary;
@synthesize ResultSetList = _ResultSetList;
@synthesize itemID = _itemID;
@synthesize finished = _finished;
@synthesize trace = _trace;

#pragma mark - private methods -

-(void)calculateItemScore:(ItemData*) item response:(int) response{
    
    
    Threshold* threshold_congruent = [self.itemThresholds objectForKey:@"1"];
    if(threshold_congruent != nil)
    {
        NSRange match = [item.ID rangeOfString: threshold_congruent.Description];
        if(match.location != INT32_MAX && response == 1){
             threshold_congruent.UserValue +=1;
        }
    }
    
    Threshold* threshold_incongruent = [self.itemThresholds objectForKey:@"2"];
    if(threshold_incongruent != nil)
    {
        NSRange match = [item.ID rangeOfString: threshold_incongruent.Description];
        if(match.location != INT32_MAX && response == 1 ){
            threshold_incongruent.UserValue +=1;
        };
    }
}


-(void)calculateSectionScore:(ItemData*) item response:(int) response{
    
    if (response != 1){
        return;
    }
    
    self.score +=1;
    
    Criteria* criteria = [self.sectionCriteria objectForKey:[[NSNumber numberWithInt:item.Section] stringValue]];
    
    if(criteria.IsItem ==YES){
        [self calculateItemScore: item response:response];
    }
    
    if(criteria != nil) {
        Threshold* threshold = [self.sectionThresholds objectForKey:criteria.Threshold];
        if(threshold != nil)
        {
            if(threshold.UserValue > 0 && threshold.Section != item.Section){
                //Reset count to this section
                threshold.UserValue = 0;
            }

            // Start counting correct answers and marking section
            if(threshold.UserValue == 0){
                threshold.Section = item.Section;
            }
            
            threshold.UserValue += 1;
            
        }
        
    }
    
}

-(void)loadItemThresholds :(NSMutableArray*) thresholds{
    for(Threshold* threshold in thresholds)
    {
        if([self.itemThresholds objectForKey:threshold.ID] == nil)
        {
            [self.itemThresholds setValue:threshold forKey: threshold.ID];
        }
        else
        {
            [self.itemThresholds setValue:threshold forKey: threshold.ID];
        }
        
    }

}


-(void)loadSectionalThresholds :(NSMutableArray*) thresholds{
    for(Threshold* threshold in thresholds)
    {
        if([self.sectionThresholds objectForKey:threshold.ID] == nil)
        {
            [self.sectionThresholds setValue:threshold forKey: threshold.ID];
        }
        else
        {
            [self.sectionThresholds setValue:threshold forKey: threshold.ID];
        }
        
    }
}
-(void)loadSectionalCriteria: (Criteria*) criteria;{
    
    if([self.sectionCriteria objectForKey:[[NSNumber numberWithInt:criteria.Section] stringValue]] == nil)
    {
        [self.sectionCriteria setValue:criteria forKey: [[NSNumber numberWithInt:criteria.Section] stringValue] ];
    }
    else
    {
        [self.sectionCriteria setValue:criteria forKey: [[NSNumber numberWithInt:criteria.Section] stringValue] ];
    }
    
    
}
-(void)loadRanges :(NSMutableArray*) ranges{
    
    for(Range* range in ranges)
    {
        
        int _Max = range.Max ;
        int _Min = range.Min ;
        
        if(self.age >= _Min && self.age <= _Max){
            
            
            if([self.ranges objectForKey:range.ID] == nil)
            {
                [self.ranges setValue:range forKey: range.ID];
            }
            else
            {
                [self.ranges setValue:range forKey: range.ID];
            }
            
            for(Criteria* criteria in range.criterias){
                [self loadSectionalCriteria: criteria];
            }
            self.range = range;
        }
        
    }
}


-(void)evaluateItemCriteria{
    
    Threshold* threshold_congruent = [self.itemThresholds objectForKey:@"1"];
    Threshold* threshold_incongruent = [self.itemThresholds objectForKey:@"2"];

     if(threshold_congruent.UserValue < threshold_congruent.Value || threshold_incongruent.UserValue < threshold_incongruent.Value){
         self.position = -1;
     }
    
}

-(void)evaluateCriteria{
    
    bool f = false;
    
    while(!f){
        
        ItemData *myItem = [self.ItemRangeList objectAtIndex:self.position];
                
        Criteria* criteria = [self.sectionCriteria objectForKey:[[NSNumber numberWithInt:myItem.Section] stringValue]];
        
        if(![criteria.ItemGate isEqual: @""]){
            [self evaluateItemCriteria];
        }
        
        
        if(criteria == nil){
            f= true;
        }
        else
        {
            Threshold* threshold = [self.sectionThresholds objectForKey:criteria.Threshold];
            if(threshold == nil){
                
                
                // check for gated criteria - end of test condition
                if(![criteria.Gate isEqual: @""]){
                    Threshold* thresholdGate = [self.sectionThresholds objectForKey:criteria.Gate];
                    if(thresholdGate){
                        if(thresholdGate.UserValue < thresholdGate.Value ){
                            self.position = -1;
                            f=true;
                            break;
                        }
                    }
                   
                }
                
                f= true;
            }
            else
            {
            
                if(threshold.UserValue >= threshold.Value ){
  
                    // finish the current section before skipping over other sections
                    if( myItem.Section == threshold.Section){
                         f = true;
                        break;
                    }
                    
                    self.position += 1;
                    
                    //end of form
                    if(self.position == self.ItemRangeList.count){
                        self.position = -1;
                        f=true;
                    }
                    
                }else{
                    f= true;
                }
            }
            
        }
    }
    
}
#pragma mark - public methods -
-(void)setStartItem:(NSString*)firstItemID{
    self.position = [firstItemID intValue];
    int iPos = 0;
    
    // Locate item in the list with this ID
    for(ItemData* i in self.ItemRangeList)
    {
        if([i.FormItemOID isEqualToString:firstItemID])
        {
            self.position = iPos;
            break;
        }
        
        ++iPos;
    }
}
-(void)setUser:(User*)user{
    
    self.age = user.age.intValue;

    NSMutableArray *myRanges = [_ParameterDictionary  objectForKey:@"Ranges"];
    [self loadRanges : myRanges ];

}

-(float) getScore{
    
    return (float)self.score;

}
-(float) getError{ return 0.0;}

-(ItemData *) getItem :(NSString*) ID{
    ItemData* item = nil;
    
    if([ID isEqual: @""]){
        return nil;
    }
    
    for(int i = 0; i < _ItemRangeList.count; i++){
        
        if(ID == ((ItemData*)[_ItemRangeList objectAtIndex:i]).FormItemOID){
            item = (ItemData*)[_ItemRangeList objectAtIndex:i];
        }
    }
    
    return item;
}
-(NSString *) getNextItem{
    
    if(self.position == self.ItemRangeList.count){
        self.position = -1;
        return @"";
    }
    
    [self evaluateCriteria];
    
    if (self.position == -1) {
        return @"";
    }
    
    ItemData *myItem = [self.ItemRangeList objectAtIndex:self.position];
    
    self.itemID = myItem.FormItemOID;
    self.position += 1;

    return self.itemID;
}

-(NSArray *) processResponses: (NSArray *) responses responsetime:(double) responsetime{
    
    NSNumber* myNumber = (NSNumber *)[responses objectAtIndex:0];
    ItemData* myItemData = [self processResponse:[myNumber intValue] responsetime:responsetime];
    return [NSArray arrayWithObject:myItemData];
    
}

-(ItemData *) processResponse:(int)response{
    
    ItemData* item =[self getItem:self.itemID];
    
    [self calculateSectionScore: item response:response];
 
    item.Response = [NSString stringWithFormat:@"%i", response];
    item.ItemDataOID = [UUID generate];
    
    for(Element* e in item.elements)
    {
        for(Map* m in e.mappings)
        {
            if( [ m.Description isEqualToString:[[NSNumber numberWithInt:response] stringValue]] ){
                item.ItemResponseOID = m.ItemResponseOID;
                item.Response = m.Value;
                item.ResponseDescription = m.Description;
                break;
            }
        }
    }

    [self.ItemResponseList addObject:item];
    item.Position = [[NSNumber numberWithInt:self.ItemResponseList.count] stringValue];

    return item;
    
}
-(ItemData *) processResponse:(int)response responsetime:(double)responsetime{
    
    ItemData* item =[self getItem:self.itemID];
    
    [self calculateSectionScore: item response:response];
    
    item.ResponseTime = [NSString stringWithFormat:@"%f", responsetime];
    
    item.Response = [NSString stringWithFormat:@"%i", response];
    item.ItemDataOID = [UUID generate];
    
    for(Element* e in item.elements)
    {
        for(Map* m in e.mappings)
        {
            if( [ m.Description isEqualToString:[[NSNumber numberWithInt:response] stringValue]] ){
                item.ItemResponseOID = m.ItemResponseOID;
                item.Response = m.Value;
                item.ResponseDescription = m.Description;
                break;
            }
        }
    }

    [self.ItemResponseList addObject:item];
    item.Position = [[NSNumber numberWithInt:self.ItemResponseList.count] stringValue];
    
    return item;
    
}
-(void) getResults{

}


-(id)initwithParameterDictionary:(NSMutableDictionary *)paramdictionary{
    
    if(self){
        _ParameterDictionary  = paramdictionary;
        NSMutableArray *myThreholds = [_ParameterDictionary  objectForKey:@"Thresholds"];
        [self loadSectionalThresholds : myThreholds ];
        
        NSMutableArray *myItemThreholds = [_ParameterDictionary  objectForKey:@"Item_Thresholds"];
        [self loadItemThresholds : myItemThreholds];
        return self;
    }
    
    return nil;
}

-(void)setItemList:(NSArray *) value{
    if (self) {
        _ItemList = value;
        [self loadSectionalDictionary];
    }
}
- (void)shuffle: (NSMutableArray*) sectionalItems{
    NSUInteger count = [sectionalItems count];
   
    for (uint i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = (int)count - i;
        int n = arc4random_uniform(nElements) + i;
        [sectionalItems exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}
-(void)loadSectionalDictionary{

 // Load all items into sectional Array
 for(int i = 0; i < self.ItemList.count; i++){
 
     ItemData* item = [self.ItemList objectAtIndex:i];
     NSString* key =  [[NSNumber numberWithInt:item.Section] stringValue];
 
     if([self.sectionCriteria  objectForKey: [[NSNumber numberWithInt:item.Section] stringValue] ] == nil){
         //Only load sections that have criterias
         continue;
     };
     
     if([self.sectionItems objectForKey:key] == nil) {// First item in section
         NSMutableArray *myArray = [[NSMutableArray alloc] init];
         [myArray addObject:item];
 
         [self.sectionItems setValue:myArray forKey: key];
 
     }else{
 
         NSMutableArray *myArray = [self.sectionItems  objectForKey:key];
         [myArray addObject:item];
         [self.sectionItems setValue:myArray forKey: key];
 
     }
     
 }

    // Determine if section should be randomized
    for (NSString* key in self.sectionItems ) {
        Criteria* criteria = [self.sectionCriteria objectForKey: key ];
        if(criteria != nil ){
            if(criteria.IsItem != NO){
                // randomize section
                [self shuffle: [self.sectionItems objectForKey:key]];
            }
        }

    }
    
    
    // Get an ordered list of Sections
    NSArray *keys = [self.sectionItems allKeys];
    
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 integerValue] - [obj2 integerValue];
    }];
    
    
 // Load the final order Item List
for(int i = 0; i < sortedKeys.count; i++){
    
    NSMutableArray *myFinalArray = [self.sectionItems objectForKey: [sortedKeys objectAtIndex:i] ];
    for(int i = 0; i < [myFinalArray count] ; i++){
        
        ItemData* item = [myFinalArray objectAtIndex:i];
        
        [self.ItemRangeList addObject:item];

    }
    
}
  // set the position
    for(int i = 0; i < self.ItemRangeList.count; i++){
        
        ItemData* item = [self.ItemRangeList objectAtIndex:i];

        if(![item.ItemResponseOID isEqual: @""]){
            
            
            // Check for valid response
            for(Element* e in item.elements)
            {
                for(Map* m in e.mappings)
                {
                    if( [ m.ItemResponseOID isEqualToString:item.ItemResponseOID] ){
                        [ self calculateSectionScore:item response:[ m.Description intValue]];
                        self.position = (i + 1);
                        break;
                    }
                }
            }
  
            
        }
    }

 }


-(id)init{
    self = [super init];
    if (self) {
        
        self.position = 0;
        self.score = 0;
        
        return self;
    }
    return nil;
}
@end
