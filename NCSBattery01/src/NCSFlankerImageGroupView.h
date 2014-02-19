//
//  NCSFlankerImageGroupView.h
//  NCS Admin
//
//  Created by Mike Rose on 10/28/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCSFlankerImageGroupView : UIView

- (id)initWithImageViewCount:(NSInteger)count;

- (void)clearImages;

@property (strong, nonatomic) NSArray *images;

@end