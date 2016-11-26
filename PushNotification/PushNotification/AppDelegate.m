//
//  AppDelegate.m
//  PushNotification
//
//  Created by Unchastity on 11/24/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "AppDelegate.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //设置UNUserNotificationCenterDelegate代理
        center.delegate = self;
        //请求push notification authorization
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound |UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                //allow
                NSLog(@"allow push notification");
                //获取setting
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                    NSLog(@"notification setting = %@",settings);
                }];
            }
        }];
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UNUserNotificationCenterDelegate
//获取通知
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    //获取通知的请求
    UNNotificationRequest *notificationRequest = notification.request;
    //通知的时候
    NSDate *notificationDate = notification.date;
    NSLog(@"receive notification time: %@", notificationDate);
    
    //获取请求的标识符
    NSString *requestIdentifier = notificationRequest.identifier;
    NSLog(@"request identifier: %@", requestIdentifier);
    //通知请求的内容
    UNNotificationContent *notificationContent = notificationRequest.content;
    //通知请求的触发器
    UNNotificationTrigger *trigger = notificationRequest.trigger;
    NSLog(@"trigger class: %@", NSStringFromClass([trigger class]));
    
    //收到通知后，应用的图标显示的数字，可以看作通知的条数
    NSNumber *bagde = notificationContent.badge;
    //通知的title
    NSString *title = notificationContent.title;
    //通知的subTitle
    NSString *subTitle = notificationContent.subtitle;
    //通知的body
    NSString *body = notificationContent.body;
    //通知的提示声音
    UNNotificationSound *notificationSound = notificationContent.sound;
    //userInfo for remote notification
    NSDictionary *info = notificationContent.userInfo;
    
    if ([trigger isKindOfClass: [UNPushNotificationTrigger class]])
    {
        NSLog(@"远程推送");
    }else
    {
        NSLog(@"收到本地通知:{\ntitle: %@, \nsubtitle: %@, \nbody: %@, \nbadge: %@, \nSound: %@, \nuserInfo: %@", title, subTitle, body, bagde, notificationSound, info);
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}


// when the user responded to the notification
// 对收到的通知作出响应，点击打开，删除等
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    //获取执行点击事件的action的标识符
    NSString *actionIdentifier = response.actionIdentifier;
    NSLog(@"response actionIdentifier: %@", actionIdentifier);
    //获取用户响应的通知
    UNNotification *notification = response.notification;
    
    //用户响应通知的时间
    NSDate *responseDate = notification.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss.SSS";
    NSString *time = [formatter stringFromDate:responseDate];
    //用户响应的通知的请求
    UNNotificationRequest *request = notification.request;
    //请求的内容
    UNNotificationContent *content = request.content;
    
    if ([request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        NSLog(@"用户响应远程推送");
    }else
    {
        NSLog(@"用户响应本地推送：{response time:%@, \ntitle:%@, \nsubTitle: %@, \nbody: %@, \nbadge: %@, \nSound: %@, \nuserInfo: %@", time, content.title, content.subtitle, content.body, content.badge, content.sound, content.userInfo);
    }
    
    
    
}

@end
