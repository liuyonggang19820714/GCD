//
//  ViewController.m
//  GCD
//
//  Created by 极客学院 on 16/4/8.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImage1;
@property (weak, nonatomic) IBOutlet UIImageView *myImage2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 使用同步函数，往主队列添加任务，会死锁
    dispatch_sync(mainQueue, ^{
        NSLog(@"主队列所在线程 = %@",[NSThread currentThread]);
    });*/
    
 /*
    //获取全局并行队列
    dispatch_queue_t concurentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(concurentQueue, ^{
        NSLog(@"全局并行队列所在线程 = %@",[NSThread currentThread]);
    });
    
    dispatch_sync(concurentQueue, ^{
        NSLog(@"全局并行队列所在线程2 = %@",[NSThread currentThread]);
    });*/

    // 创建串行队列
//    dispatch_queue_t myQueue = dispatch_queue_create("lyg.jkxy.com", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_sync(myQueue, ^{
//        NSLog(@"自定义队列所在线程 = %@",[NSThread currentThread]);
//    });
//
//    dispatch_sync(myQueue, ^{
//        NSLog(@"自定义队列所在线程2 = %@",[NSThread currentThread]);
//    });
    
    // 创建并行队列
//    dispatch_queue_t myQueue = dispatch_queue_create("lyg.jkxy.com", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_sync(myQueue, ^{
//        NSLog(@"自定义并行队列所在线程 = %@",[NSThread currentThread]);
//    });
//    
//    dispatch_sync(myQueue, ^{
//        NSLog(@"自定义并行队列所在线程2 = %@",[NSThread currentThread]);
//    });
    
   // [self async];
   
   
    //获取全局并行队列
//    dispatch_queue_t concurentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_async(concurentQueue, ^{
//        NSLog(@"全局并行队列所在线程 = %@",[NSThread currentThread]);
//        
//        NSURL*url = [NSURL URLWithString:@"http://www.zhouchengzuo.org/images/15-11-14/04/2-54275df8-531-558.jpg"];
//        NSData*data = [NSData dataWithContentsOfURL:url];
//        UIImage*image1 = [UIImage imageWithData:data];
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.myImage1.image = image1;
//        });
//        
//    });

    // 合并汇总结果
    __block UIImage*image1;
    __block UIImage*image2;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSLog(@"线程 = %@",[NSThread currentThread]);
        // 并行执行的线程一
        NSURL*url = [NSURL URLWithString:@"http://www.zhouchengzuo.org/images/15-11-14/04/2-54275df8-531-558.jpg"];
            NSData*data = [NSData dataWithContentsOfURL:url];
            image1 = [UIImage imageWithData:data];

    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        // 并行执行的线程二
        NSLog(@"线程 = %@",[NSThread currentThread]);
        NSURL*url = [NSURL URLWithString:@"http://img.xgo-img.com.cn/pics/1736/1735160.jpg"];
        NSData*data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 汇总结果
        
        self.myImage1.image = image1;
        self.myImage2.image = image2;
    });

    // 5:48
}

-(void)async
{
    /*
     // 获取主队列
     dispatch_queue_t mainQueue = dispatch_get_main_queue();
     
     dispatch_async(mainQueue, ^{
     NSLog(@"主队列所在线程 = %@",[NSThread currentThread]);
     });
     
     //获取全局并行队列
     dispatch_queue_t concurentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     
     dispatch_async(concurentQueue, ^{
     NSLog(@"全局并行队列所在线程 = %@",[NSThread currentThread]);
     });
     
     dispatch_async(concurentQueue, ^{
     NSLog(@"全局并行队列所在线程2 = %@",[NSThread currentThread]);
     });
     */
    
    // 创建串行队列
    //    dispatch_queue_t myQueue = dispatch_queue_create("lyg.jkxy.com", DISPATCH_QUEUE_SERIAL);
    //
    //    dispatch_async(myQueue, ^{
    //        NSLog(@"自定义队列所在线程 = %@",[NSThread currentThread]);
    //    });
    //
    //    dispatch_async(myQueue, ^{
    //        NSLog(@"自定义队列所在线程2 = %@",[NSThread currentThread]);
    //    });
    
    
    // 创建并行队列
//    dispatch_queue_t myQueue = dispatch_queue_create("lyg.jkxy.com", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_async(myQueue, ^{
//        NSLog(@"自定义并行队列所在线程 = %@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(myQueue, ^{
//        NSLog(@"自定义并行队列所在线程2 = %@",[NSThread currentThread]);
//    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionRepeat animations:^{
                            [UIView setAnimationTransition:(arc4random() % 4 + 1) forView:self.myImage1 cache:YES];
                        } completion:^(BOOL finished) {
                            [UIView setAnimationsEnabled:NO];
                        }];
}
@end
