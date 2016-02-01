//
//  ViewController.m
//  XJLCollapseMenu
//
//  Created by dog_47 on 12/25/15.
//  Copyright © 2015 dog-47.com. All rights reserved.
//

#import "ViewController.h"
#import "XJLCollaspeMenu.h"

@interface ViewController ()<XJLCollaspeMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    

    
    
    NSArray *array1=@[@"1111",@"2222",@"3333",@"4444"];
    NSArray *array2=@[@"5555"];
    NSArray *array3=@[@"7777",@"8888",@"9999"];
    NSArray *array4=@[@"测试"];
    NSArray *all=@[array1,array2,array3,array4];
    
    
    XJLCollaspeMenu *menu=[[XJLCollaspeMenu alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) andArray:all Container:MENU_CONTAINER_TABLEVIEW];
    menu.delegate=self;
    [self.view addSubview:menu];
    
    UIView *_view=[menu getOpenViewAtIndex:1];
    _view.backgroundColor=[UIColor greenColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=@"空白view1";
    label.center=CGPointMake(_view.frame.size.width/2.0f, _view.frame.size.height/2.0f);
    label.textColor=[UIColor whiteColor];
    [_view addSubview:label];
    
    UIView *_view2=[menu getOpenViewAtIndex:2];
    _view2.backgroundColor=[UIColor redColor];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label2.text=@"空白view2";
    label2.center=CGPointMake(_view2.frame.size.width/2.0f, _view2.frame.size.height/2.0f);
    label2.textColor=[UIColor whiteColor];
    [_view2 addSubview:label2];
    
    
}


-(void)menuSelected:(NSInteger)_index inRow:(NSInteger)_row{
    NSLog(@"index:%ld  row%ld",_index,_row);
}

-(void)menuOpenAtIndex:(NSInteger)_index{
    NSLog(@"menu打开 index:%ld",_index);
}


@end
