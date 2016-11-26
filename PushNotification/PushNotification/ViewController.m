//
//  ViewController.m
//  PushNotification
//
//  Created by Unchastity on 11/24/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "ViewController.h"

#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.\
    
    [self createLocalNotification];
}

-(void)createLocalNotification {
    
    UNMutableNotificationContent *content1 = [[UNMutableNotificationContent alloc] init];
    content1.title = @"晴空的信息";
    content1.subtitle = @"来自微信";
    content1.body = @"我要敷面膜了";
    content1.badge = @2;
    //附件
    NSString *pngPath = [[NSBundle mainBundle] pathForResource:@"icon_certification_status1@2x" ofType:@"png"];
    NSURL *pngURL = [NSURL fileURLWithPath:pngPath];
    //options
    NSMutableDictionary *dict = [NSMutableDictionary new];
    //描述文件类型的统一类型标识符，若不提供该键，则根据附件的文件扩展名来确定其类型
    //常用：kUTTypeImage, kUTTypeJPEG2000, kUTTTIFF, kUTTypePICT, kUTTypeGIF, kUTTypePNG, kUTTypeQuickTimeImage
    dict[UNNotificationAttachmentOptionsTypeHintKey] = (__bridge id _Nullable)(kUTTypeImage);
    //设置缩略图是否隐藏，YES为隐藏
    dict[UNNotificationAttachmentOptionsThumbnailHiddenKey] = @NO;
    //设置缩略图显示frame
    dict[UNNotificationAttachmentOptionsThumbnailClippingRectKey] = (__bridge id _Nullable)CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 0.5, 0.5));
    NSError *error = nil;
    UNNotificationAttachment *atta = [UNNotificationAttachment attachmentWithIdentifier:@"atta1" URL:pngURL options:dict error:&error];
    content1.attachments = @[atta];
    content1.launchImageName = @"image01.jpg";
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"test1.wav"];
    content1.sound = sound;
    
    content1.categoryIdentifier = @"categoryIdentifier1";
    content1.threadIdentifier = @"threadIdentifier1";
    //触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    //创建notification request
    NSString *requrestIdentifier = @"requestIdentifier1";
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:requrestIdentifier content:content1 trigger:trigger];
    //将request 添加到notification center
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}


@end
