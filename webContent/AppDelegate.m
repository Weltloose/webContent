//
//  AppDelegate.m
//  webContent
//
//  Created by weltloose on 2019/12/15.
//  Copyright © 2019 weltloose. All rights reserved.
//

#import "AppDelegate.h"
#import "getwebContent.h"
#import "dataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    getwebContentViewController *uvc = [[getwebContentViewController alloc] init];
    
    dataModel *data = [[dataModel alloc] init];
    uvc.datas = data;
    uvc.username = @"xiaodong";
    uvc.password = @"1234";
    uvc.groupID = 2;
    uvc.eventID = 2;
    // 关于ios时间 https://www.jianshu.com/p/f8aab37a27ff
    uvc.timeFrom = @"2014-11-10 02:10:11";
    uvc.timeTo = @"2014-11-11 02:10:11";
    uvc.content = @"我系小明爸爸";
    self.window.rootViewController = uvc;
    [self.window makeKeyAndVisible];
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


@end
