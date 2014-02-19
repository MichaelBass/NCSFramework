//
//  Engine.h
//
//  Created by Bass, Michael on 8/12/12.
//
//

#import <Foundation/Foundation.h>
#import "ItemData.h"
#import "User.h"

@protocol Engine <NSObject>
@required
@property (nonatomic, strong) NSString *itemID;
@property (nonatomic) Boolean finished;
@property (nonatomic, strong) NSString *trace;
@property (nonatomic, copy) NSArray *ItemList;

@property (nonatomic, copy) NSArray *ResultSetList;

-(void)setStartItem:(NSString*)firstItemID;
-(ItemData *) getItem :(NSString *) ID;
-(ItemData *) processResponse: (int) response;

-(NSArray *)  processResponses: (NSArray *) responses responsetime:(double) responsetime;

-(float) getScore;
-(float) getError;

-(NSString *) getNextItem;
-(NSArray *) getNextSection;
-(void) getResults;
-(void)setItemList: (NSArray *) value ;
-(id)initwithParameterDictionary:(NSMutableDictionary *)paramdictionary;

@optional
-(NSString *) getPreviousItem;
-(void)setUser:(User *)user;
@property (nonatomic) BOOL sectional;
@end


