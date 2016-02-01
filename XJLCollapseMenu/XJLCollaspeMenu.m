//
//  XJLCollaspeMenu.m
//  XJLCollaspeMenu
//
//  Created by dog_47 on 12/10/15.
//  Copyright © 2015 dog-47.com. All rights reserved.
//

#import "XJLCollaspeMenu.h"
#import <POP.h>


#define _tableViewCell_height 44

@interface XJLCollaspeMenu ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XJLCollaspeMenu{
    CGRect _frame;
    CGRect _contentframe;
    NSArray *_initArray;
    NSNumber *_currrentIndex;
    BOOL isOpen;
    UITableView *_tableView;
    UIView *_cleanView;
    NSMutableArray *_labelsArray;
    NSMutableDictionary *_blankViews;
}


-(id)initWithFrame:(CGRect)frame andArray:(NSArray *)array{
    if (self=[super initWithFrame:frame]) {
        _labelsArray=[NSMutableArray array];
        self.clipsToBounds=YES;
        _frame=frame;
        _contentframe=CGRectMake(0, _frame.size.height, _frame.size.width,[UIScreen mainScreen].bounds.size.height-_frame.origin.y-_frame.size.height);
        _initArray=array;
        isOpen=NO;
        self.backgroundColor=[UIColor clearColor];
        [self initLabel];
        [self initBlankView];
        [self initTableView];
    }
    return self;
}



#pragma mark BlankView
-(void)initBlankView{
    _blankViews=[NSMutableDictionary new];
    for (NSArray *tmp in _initArray) {
        if (tmp.count==1) {

            UIView *view=[[UIView alloc]initWithFrame:_contentframe];
            view.backgroundColor=[UIColor whiteColor];
            view.hidden=YES;
            [self addSubview:view];
            [_blankViews setObject:view forKey:[NSString stringWithFormat:@"index%ld",[_initArray indexOfObject:tmp]]];
        }
    }
}

-(void)setBlankViewShow:(BOOL)_value{
    UIView *view=[_blankViews objectForKey:[NSString stringWithFormat:@"index%ld",_currrentIndex.integerValue]];
    view.hidden=!_value;
}

-(UIView *)getBlankView{
    UIView *view=[_blankViews objectForKey:[NSString stringWithFormat:@"index%ld",_currrentIndex.integerValue]];
    return view;
}

-(UIView *)getOpenViewAtIndex:(NSInteger)_index{
    for (NSArray *tmp in _initArray) {
        if ([_initArray indexOfObject:tmp]==_index) {
            if (tmp.count !=1) {
                NSString *alertString=[NSString stringWithFormat:@"index:%ld 无空白View",_index];
                NSLog(@"%@",alertString);
                return nil;
            }
        }
    }
    UIView *view=[_blankViews objectForKey:[NSString stringWithFormat:@"index%ld",_index]];
    return view;
}

#pragma mark tableView
-(void)initTableView{
    _tableView=[[UITableView alloc]initWithFrame:_contentframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=_initArray[_currrentIndex.integerValue];
    return array.count-1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableViewCell_height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID=@"11";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    NSArray *array=_initArray[_currrentIndex.integerValue];
    NSString *str=array[indexPath.row+1];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=str;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setMenuClose];
    if ([_delegate respondsToSelector:@selector(menuSelected:inRow:)]) {
        [_delegate menuSelected:_currrentIndex.integerValue inRow:indexPath.row];
    }
}

#pragma mark initLabel
-(void)initLabel{
    UIView *labelContainerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _frame.size.height)];
    labelContainerView.backgroundColor=[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
    [self addSubview:labelContainerView];
    for (NSInteger i=0; i<_initArray.count; i++) {

        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width/_initArray.count, _frame.size.height)];
        label.center=CGPointMake(_frame.size.width/(_initArray.count*2)+_frame.size.width/_initArray.count*i , label.center.y);
        NSArray *tmp=_initArray[i];
        label.text=tmp[0];
        label.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
        label.textAlignment=NSTextAlignmentCenter;
        label.userInteractionEnabled=YES;
        [label setTextColor:[UIColor lightGrayColor]];
        label.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapEvent:)];
        [label addGestureRecognizer:tap];
        [labelContainerView addSubview:label];
        [_labelsArray addObject:label];
    }
    _cleanView=[[UIView alloc]initWithFrame:_contentframe];
    _cleanView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:_cleanView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setMenuClose)];
    [_cleanView addGestureRecognizer:tap];

    
}





#pragma mark TapEvent
-(void)labelTapEvent:(id)sender{
    UIGestureRecognizer *gesture=sender;
    UILabel *label=(UILabel *)gesture.view;
    
    [self setLabelsUserInteractionEnabled:NO];
    
    if (_currrentIndex==nil) {
        _currrentIndex=@(label.tag);
        [_tableView reloadData];
        [self setMenuOpen];
    }else{
        if ([_currrentIndex integerValue]==label.tag) {
            _currrentIndex=@(label.tag);
            [_tableView reloadData];
            if (isOpen==NO) {
                [self setMenuOpen];
            }else{
                [self setMenuClose];
            }
        }
        else
        {
            if (isOpen==NO) {
                _currrentIndex=@(label.tag);
                [_tableView reloadData];
                [self setMenuOpen];
            }else{
                POPSpringAnimation *collapseAnimation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
                collapseAnimation.completionBlock=^(POPAnimation *anim, BOOL finished){
                    if (finished) {
                        isOpen=NO;
                        [self setBlankViewShow:NO];
                        //切换index
                        
                        _currrentIndex=@(label.tag);
                        [_tableView reloadData];
                        [self setMenuOpen];
                    }
                };
                collapseAnimation.toValue=[NSValue valueWithCGRect:_frame];
                [self pop_removeAllAnimations];
                [self pop_addAnimation:collapseAnimation forKey:nil];
            }
        }
    }
}


#pragma mark setLabel
-(void)setLabelsUserInteractionEnabled:(BOOL)_bool{
    for (UILabel *tmp in _labelsArray) {
        tmp.userInteractionEnabled=_bool;
    }
}



//#pragma mark mark UIViewAnimation
//-(void)setMenuOpen{
//    NSArray *array=_initArray[_currrentIndex.integerValue];
//    _tableView.frame=CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableViewCell_height*(array.count-1));
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        self.frame=CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, _frame.size.height+[UIScreen mainScreen].bounds.size.height-_frame.origin.y-_frame.size.height);
//    } completion:^(BOOL finished){
//        if (finished) {
//            isOpen=YES;
//            [self setLabelsUserInteractionEnabled:YES];
//        }
//    }];
//}
//
//-(void)setMenuClose{
//    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:2.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.frame=_frame;
//    } completion:^(BOOL finished){
//        isOpen=NO;
//        [self setLabelsUserInteractionEnabled:YES];
//    }];
//}

#pragma mark POPAnimation
-(void)setMenuOpen{
    [self setBlankViewShow:YES];
    if ([_delegate respondsToSelector:@selector(menuOpenAtIndex:)]) {
        [_delegate menuOpenAtIndex:_currrentIndex.integerValue];
    }
    NSArray *array=_initArray[_currrentIndex.integerValue];
    _tableView.frame=CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableViewCell_height*(array.count-1));
    
    POPSpringAnimation *openAnimation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    openAnimation.completionBlock=^(POPAnimation *anim, BOOL finished){
        if (finished) {
            isOpen=YES;
            [self setLabelsUserInteractionEnabled:YES];
        }
    };
    openAnimation.toValue=[NSValue valueWithCGRect:CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, _frame.size.height+[UIScreen mainScreen].bounds.size.height-_frame.origin.y-_frame.size.height)];
    [self pop_removeAllAnimations];
    [self pop_addAnimation:openAnimation forKey:nil];
}

-(void)setMenuClose{

    POPSpringAnimation *collapseAnimation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    collapseAnimation.completionBlock=^(POPAnimation *anim, BOOL finished){
        if (finished) {
            isOpen=NO;
            [self setLabelsUserInteractionEnabled:YES];
            [self setBlankViewShow:NO];
        }
    };
    collapseAnimation.toValue=[NSValue valueWithCGRect:_frame];
    [self pop_removeAllAnimations];
    [self pop_addAnimation:collapseAnimation forKey:nil];
}

@end
