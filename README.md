
# HYGestureUnlocked

一句话添加手势解锁




效果图:








![image](https://github.com/hy285585804/HYGRUnlocked/blob/master/unlock.gif)













具体实现:

添加 <HYUnlocked>文件夹到你的工程中





导入头文件 : #import "HYLockView.h"





遵守协议  :  HYLockViewDelegate






初始化方法中:



  
   -(void)viewDidLoad {
   
   
    [super viewDidLoad];
  
    /*
     *    < 一句话添加手势解锁 >
     *
     *    InView: 添加到那个视图上
     *    Target: 代理人
     */
    
    [HYLockView showInView:self.view andTarget:self];
}







//代理方法

-(void)HYLockView:(HYLockView *)lockView didSelectedPassword:(NSString *)password{
    
    NSLog(@"password = %@", password);
    
}




