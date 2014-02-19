//
//  Element.h
//  Created by Bass, Michael on 8/21/12.
//
//

/*
 
 Elements are the basic building blocks of the application's object model.
 They represent portions of an item (see Item.h), which is the model for the UI.
 An ordered collections of elements make up an item.  Elements can perform one of two functions.
 1.) Act as a stimulus for the user.  This is done by either display text on a screen, play sound, video, etc.
 2.) Act as a response object for the user to select or endorse.  (e.g. Yes/No, likert scale, free response)
 
 The collection of mappings is the container that holds specialized elements called map (see Map.h).  
 This collection performs function 2.) above.
 Elements that have no objects in there mappings perform function 1.) above.
 
 The collection of resources represent UI compenents that make-up the element.
 
 */

#import <Foundation/Foundation.h>

@interface Element : NSObject

@property (nonatomic, retain) NSString* ElementOID;
@property (nonatomic, retain) NSString* Description;
@property (nonatomic, retain) NSString* ElementOrder;
@property (nonatomic, retain) NSString* ElementType;
@property (nonatomic, retain) NSMutableArray* resources;
@property (nonatomic, retain) NSMutableArray* mappings;

- (NSInteger) getNumResources;
- (NSInteger) getNumMappings;

@end
