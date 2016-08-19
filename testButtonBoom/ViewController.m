//
//  ViewController.m
//  testButtonBoom
//
//  Created by 王迎博 on 16/8/19.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 20, 20)];
    [btn addTarget:self action:@selector(boom:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.cornerRadius = btn.frame.size.width / 2;
    [self.view addSubview:btn];
    
}

- (void)boom:(UIButton *)btn{
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    
    [emitter setEmitterSize:CGSizeMake(CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame))];
    emitter.emitterPosition = CGPointMake(btn.frame.size.width /2.0, btn.frame.size.height / 2.0);
    emitter.emitterShape = kCAEmitterLayerCircle;
    emitter.emitterMode = kCAEmitterLayerOutline;
    [btn.layer addSublayer:emitter];
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    [cell setName:@"zanShape"];
    
    cell.contents = (__bridge id _Nullable)([self createImageWithColor:[UIColor blackColor]].CGImage);
    cell.birthRate = 0;
    cell.lifetime = 0.4;
    cell.alphaSpeed = -2;
    
    cell.velocity = 20;
    cell.velocityRange = 20;
    emitter.emitterCells = @[cell];
    
    CABasicAnimation *effectLayerAnimation=[CABasicAnimation animationWithKeyPath:@"emitterCells.zanShape.birthRate"];
    [effectLayerAnimation setFromValue:[NSNumber numberWithFloat:1500]];
    [effectLayerAnimation setToValue:[NSNumber numberWithFloat:0]];
    [effectLayerAnimation setDuration:0.0f];
    [effectLayerAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [emitter addAnimation:effectLayerAnimation forKey:@"ZanCount"];
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [self circleImage:theImage];;
}

-(UIImage*) circleImage:(UIImage*) image{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width , image.size.height );
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
