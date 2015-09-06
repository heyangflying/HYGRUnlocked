//
//  HYLockView.m
//  HYGestureUnlocked
//
//  Created by heyang on 15/8/20.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//

#import "HYLockView.h"

@interface HYLockView ()

@property (nonatomic,strong) NSMutableArray *selectedBtns;//选中按钮数组
@property (nonatomic,assign) CGPoint lastPoint;//最后的触摸点

@end



@implementation HYLockView

//懒加载
- (NSMutableArray *)selectedBtns
{
    if(!_selectedBtns){
        _selectedBtns = [NSMutableArray array];
    }
    return  _selectedBtns;
}



+ (id)showInView:(UIView *)view andTarget:(id)target
{
  
    return [[self alloc]initWithFrame:view.frame andView:view andTarget:target];
}


- (instancetype)initWithFrame:(CGRect)frame andView:(UIView *)view andTarget:(id)target{
    
    if(self = [super initWithFrame:frame]){
        
       
      //  添加背景
           view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];

        //设置大小和位置
           CGFloat screenW      = [UIScreen mainScreen].bounds.size.width;
           self.bounds          = CGRectMake(0, 0, screenW, screenW);
           self.backgroundColor = [UIColor clearColor];
           self.center          = view.center;
           self.delegate        = target;
        
            [view addSubview:self];

        //初始化按钮
            [self setupBtns];
        
    }
    
    return self;
}

-(void)setupBtns{
    
        //添加9个按钮
    
    for (NSInteger i = 0; i < 9; i++) {
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //绑定tag
        btn.tag = i;
        
        // 设置默认图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        // 设置选中的图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        // 设置按钮不可用
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [self touchesMoved:touches withEvent:event];
    
  
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    

    //拼接选中按钮的tag
    NSMutableString *password = [NSMutableString string];
    
    //拼接密码
    for (UIButton *seletedBtn in self.selectedBtns) {
     
        [password appendFormat:@"%u",seletedBtn.tag];
        
    }
    
    //代理
    if([self.delegate respondsToSelector:@selector(HYLockView:didSelectedPassword:)]){
    
        [self.delegate HYLockView:self didSelectedPassword:password];

    }
    //取消所有按钮的选中状态为NO
    
    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:)withObject:@NO];
   
    //移除所有选中按钮
    
    [self.selectedBtns removeAllObjects];
    
    //重绘
    
    [self setNeedsDisplay];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
   
    UITouch *touch = [touches anyObject];
    CGPoint touchP = [touch locationInView:touch.view];
    
    for (UIButton *btn  in self.subviews) {
       
        //判断当前触摸点在不在按钮的范围内
        if(CGRectContainsPoint(btn.frame, touchP)){
           
            
            //放入选中按钮数组中,如果选中状态为NO才需要添加进去
            
            if(btn.selected == NO){
                [self.selectedBtns addObject:btn];
            }
            
            //设置选中
            btn.selected = YES;
            
        }else{
            
            //记录最后触摸点
            
            self.lastPoint = touchP;
            
        }
    }
    //重绘
    [self setNeedsDisplay];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
   
    
        CGFloat btnW       = 74;
        CGFloat btnH       = 74;
        NSInteger btnCount = self.subviews.count;

    // 间距
        CGFloat padding    = (self.frame.size.width - 3 * btnW) / 4;

    
    for (NSInteger i     = 0; i < btnCount; i++) {
   
        UIButton *btn    = self.subviews[i];
        // 列
        NSInteger column = i % 3;
        // 行
        NSInteger row    = i / 3;
        // 位置
        //  间距 + （按钮的宽度 + 间距） * 列
        CGFloat btnX     = padding + (btnW + padding) * column;
        // 间距 + （按钮的高度 + 间距） * 行
        CGFloat btnY     = padding + (btnH + padding) * row;
      
        btn.frame        = CGRectMake(btnX, btnY, btnW, btnH);

    }
    
}
//绘制路径
- (void)drawRect:(CGRect)rect {
   
    
    NSInteger selectedBtnsCount = self.selectedBtns.count;
    
    //如果选中按钮为0 直接返回
    if(selectedBtnsCount == 0) return;
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < selectedBtnsCount; i ++) {
        
        CGPoint btnCenter = [self.selectedBtns[i] center];
        if(i == 0){
            [path moveToPoint:btnCenter];
        }else{
            [path addLineToPoint:btnCenter];
        }
        
    }
    
    //追加一个点的路径
    
    [path addLineToPoint:self.lastPoint];
    //宽度
    path.lineWidth = 8;
    //连接点的样式
    path.lineJoinStyle = kCGLineJoinRound;
    //头样式
    path.lineCapStyle = kCGLineCapRound;
    //颜色
    [[UIColor greenColor]set];
    //画
    [path stroke];
}


@end
