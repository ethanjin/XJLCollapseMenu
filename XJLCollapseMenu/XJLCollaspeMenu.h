//
//  XJLCollaspeMenu.h
//  XJLCollaspeMenu
//
//  Created by dog_47 on 12/10/15.
//  Copyright © 2015 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol XJLCollaspeMenuDelegate <NSObject>
-(void)menuSelected:(NSInteger)_index inRow:(NSInteger)_row;
-(void)menuOpenAtIndex:(NSInteger)_index;
@end




@interface XJLCollaspeMenu : UIView
@property (assign,nonatomic) id<XJLCollaspeMenuDelegate> delegate;

-(id)initWithFrame:(CGRect)frame andArray:(NSArray *)array;
-(UIView *)getOpenViewAtIndex:(NSInteger)_index;


@end
