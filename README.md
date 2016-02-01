# XJLCollapseMenu
GIF:
 <p>![](https://github.com/dog047/XJLCollapseMenu/raw/master/XJLCollapseMenu.gif)
## Usage
在内部数组添加字符串，把内部数组嵌套在外部数组，作为初始化参数，内部数组的对象个数为1时，展开页面为UIView，否则为TableView
##Init

    NSArray *array1=@[@"1111",@"2222",@"3333",@"4444"];
    NSArray *array2=@[@"5555"];
    NSArray *array3=@[@"7777",@"8888",@"9999"];
    NSArray *array4=@[@"测试"];
    NSArray *all=@[array1,array2,array3,array4];
    
    XJLCollaspeMenu *menu=[[XJLCollaspeMenu alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) andArray:all];
    menu.delegate=self;
    [self.view addSubview:menu];
   ---------------------------------------
##CallBack

    -(void)menuSelected:(NSInteger)_index inRow:(NSInteger)_row{
    NSLog(@"index:%ld  row%ld",_index,_row);
    }
    -(void)menuOpenAtIndex:(NSInteger)_index{
    NSLog(@"menu打开 index:%ld",_index);
    }
    
##Setting
    UIView *_view=[menu getOpenViewAtIndex:1];
    _view.backgroundColor=[UIColor greenColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=@"空白view1";
    label.center=CGPointMake(_view.frame.size.width/2.0f, _view.frame.size.height/2.0f);
    label.textColor=[UIColor whiteColor];
    [_view addSubview:label];
