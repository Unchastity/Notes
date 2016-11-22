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
    int _countTotal;
    int _secondCountTotal;
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UILabel *record1;


@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UILabel *record2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _countTotal = 60;
    _secondCountTotal = 60;
    self.countDownBtn.userInteractionEnabled = YES;
    [self.countDownBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    self.secondBtn.userInteractionEnabled = YES;
    [self.secondBtn setTitle:@"send Security Code" forState:UIControlStateNormal];
}


- (IBAction)clickCountDownBtn:(UIButton *)sender {
    
    NSLog(@"first button");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        --_countTotal;
        int second = _countTotal;
        if (second != 0) {
            self.countDownBtn.userInteractionEnabled = NO;
            //self.countDownBtn.tintColor = [UIColor grayColor];
            self.countDownBtn.titleLabel.textColor = [UIColor grayColor];
            NSString *countDownTime = [NSString stringWithFormat: @"%d s", second];
            [self.countDownBtn setTitle: countDownTime forState: UIControlStateNormal];
        }else {
            
            _countTotal = 60;
            self.countDownBtn.userInteractionEnabled = YES;
            [self.countDownBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
            //[timer invalidate];
            //timer = nil;
            [_timer invalidate];
        }
        [self.record1 setText:[NSString stringWithFormat:@"%d", _countTotal]];

    }];
}

- (IBAction)clickSecondBtn:(UIButton *)sender {
    
    NSLog(@"second button");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click ok button");
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//            NSLog(@"dismiss view controller");
//        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
                
                --_secondCountTotal;
                int second = _secondCountTotal;
                if (second != 0) {
                    self.secondBtn.userInteractionEnabled = NO;
                    self.secondBtn.titleLabel.textColor = [UIColor grayColor];
                    NSString *countDownTime =[NSString stringWithFormat: @"%ds", second];
                    [self.secondBtn setTitle: countDownTime forState: UIControlStateNormal];
                }else {
                    
                    _secondCountTotal = 60;
                    self.secondBtn.userInteractionEnabled = YES;
                    [self.secondBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                    [timer invalidate];
                    timer = nil;
                    //[_timer invalidate];
                }
                [self.record2 setText: [NSString stringWithFormat: @"%d", _secondCountTotal]];

            }];

        });
        
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}
@end
