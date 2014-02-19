//
//  DichotomousEngine.h
//  DichotomousEngine
//
//  Created by Bass, Michael on 8/7/12.
//  Copyright (c) 2012 Bass, Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssessmentModel/Engine.h>

@interface DichotomousEngine : NSObject <Engine>

@property (nonatomic, copy) NSArray *ItemList;
@property (nonatomic, copy) NSMutableDictionary *ParameterDictionary;
@property (nonatomic, copy) NSArray *ResultSetList;
@property (nonatomic) double Ability;
@property (nonatomic) double SE;
@property (nonatomic, strong) NSString *itemID;
@property (nonatomic) Boolean finished;
@property (nonatomic, strong) NSString *trace;


-(id)initwithParameterDictionary:(NSMutableDictionary *)paramdictionary;
-(void)setItemList: (NSArray *) value ;

-(NSString *) getNextItem;
-(NSString *) getPreviousItem;
-(NSArray *) getNextSection;
-(ItemData *) getItem :(NSString *) ID;
-(void) getResults;


-(void)setStartItem:(NSString*)firstItemID;
-(void)setUser:(User*)user;
-(float) getScore;
-(float) getError;


@end




