//
//  ViewController.m
//  Timer
//
//  Created by Unchastity on 11/22/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int _clickCot;
    int _countTotal;
}
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _countTotal = 60;
    _clickCot = 0;
    self.countDownBtn.userInteractionEnabled = YES;
    [self.countDownBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
}

- (IBAction)clickCountDownBtn:(UIButton *)sender {
    
    NSLog(@"click %d", ++_clickCot);
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        --_countTotal;
        int second = _countTotal;
        if (second != 0) {
            self.countDownBtn.userInteractionEnabled = NO;
            //self.countDownBtn.tintColor = [UIColor grayColor];
            self.countDownBtn.titleLabel.textColor = [UIColor grayColor];
            [self.countDownBtn setTitle:[NSString stringWithFormat: @"%ds", _countTotal] forState: UIControlStateNormal];
        }else {
            
            _countTotal = 60;
            self.countDownBtn.userInteractionEnabled = YES;
            [self.countDownBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
            [timer invalidate];
        }
    }];
}

- (IBAction)clickSecondBtn:(UIButton *)sender {
    
    NSLog(@"second button");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
