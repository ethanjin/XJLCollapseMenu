//
//  XJLCollaspeMenu.h
//  XJLCollaspeMenu
//
//  Created by dog_47 on 12/10/15.
//  Copyright © 2015 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSInteger , MENU_TYPE){
    MENU_CONTAINER_VIEW,
    MENU_CONTAINER_TABLEVIEW
};


@protocol XJLCollaspeMenuDelegate <NSObject>
-(void)menuSelected:(NSInteger)_index inRow:(NSInteger)_row;
-(void)menuOpenAtIndex:(NSInteger)_index;
@end




@interface XJLCollaspeMenu : UIView
@property (assign,nonatomic) id<XJLCollaspeMenuDelegate> delegate;

-(id)initWithFrame:(CGRect)frame andArray:(NSArray *)array Container:(MENU_TYPE)_containerType;
-(UIView *)getOpenViewAtIndex:(NSInteger)_index;


@end
