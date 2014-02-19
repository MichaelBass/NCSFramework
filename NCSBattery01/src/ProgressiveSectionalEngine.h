//
//  ProgressiveSectionalEngine.h
//  NIHToolboxCognition
//
//  Created by Bass, Michael on 8/29/12.
//
//

#import <Foundation/Foundation.h>
#import <AssessmentModel/Engine.h>


@interface ProgressiveSectionalEngine : NSObject <Engine>

@property (nonatomic, copy) NSArray *ItemList;

@property (nonatomic, copy) NSMutableDictionary *ParameterDictionary;
@property (nonatomic, copy) NSArray *ResultSetList;


@property (nonatomic, strong) NSString *itemID;
@property (nonatomic) Boolean finished;
@property (nonatomic, strong) NSString *trace;

-(void)setStartItem:(NSString*)firstItemID;
-(void)setUser:(User*)user;
-(float) getScore;
-(float) getError;

-(ItemData *) getItem :(NSString *) ID;
-(NSString *) getNextItem;
-(NSArray *) getNextSection;
-(void) getResults; //
-(id)initwithParameterDictionary:(NSMutableDictionary *)paramdictionary;
-(void)setItemList: (NSArray *) value ;
@end


