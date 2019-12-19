//
//  getwebContent.m
//  webInterate
//
//  Created by weltloose on 2019/12/15.
//  Copyright © 2019 weltloose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getwebContent.h"

@interface getwebContentViewController () <SRWebSocketDelegate>

@end

@implementation getwebContentViewController

@synthesize username, password, groupID, eventID, timeFrom, timeTo, content, webSocket;
@synthesize datas;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self button1];
    [self button2];
    [self button3];
    [self button4];
    [self button5];
    [self button6];
    [self button7];
    [self button8];
    [self button9];
    [self button10];
    NSString *urlStr = [NSString stringWithFormat:@"http://118.126.92.37:8081/ws?username=%@", self.username];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    // 遵守SRWebSocketDelegate协议
    self.webSocket.delegate = self;
    // 打开
    [self.webSocket open];
}

// 1. 已经打开连接
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"websocket open");
}

//3. 接收数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    //NSLog(@"%@", message);
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.datas.events[[[NSString alloc]initWithFormat: @"%@", dict[@"groupID"]]] = [dict[@"events"] mutableCopy];
    NSLog(@"data model info: ");
    [self.datas print];
}


-(void) registerUser {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/register"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", self.username, self.password];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                if([dict[@"ok"] boolValue] == true)
                    self.datas.username = self.username;
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
}

-(void) loginUser {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/login"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", self.username, self.password];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                if([dict[@"ok"] boolValue] == true)
                    self.datas.username = self.username;
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
    
}


-(void) getEventList {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString: [NSString stringWithFormat: @"http://118.126.92.37:8081/api/getEventList?username=%@", self.username]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                self.datas.events = [dict[@"events"][@"data"] mutableCopy];
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
    
}

-(void) getGroupList {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString: [NSString stringWithFormat: @"http://118.126.92.37:8081/api/getGroups?username=%@", self.username]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                self.datas.groups = [dict[@"groupList"] mutableCopy];
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
    
}

-(void) leaveGroup {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/leaveGroup"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&groupID=%d", self.username, self.groupID];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                if([dict[@"ok"] boolValue]==true){
                    for(int i = 0; i < (int)datas.groups.count; i++)
                    { if([self.datas.groups[i] intValue]==self.groupID)
                        {
                            [datas.groups removeObjectAtIndex:i];
                            break;
                        }
                    }
                }
                NSLog(@"data model info: ");
                [self.datas print];
                
            }
        }];
    [dataTask resume];
    
}

-(void) enterGroup {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/joinGroup"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&groupID=%d", self.username, self.groupID];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                if([dict[@"ok"] boolValue] == true){
                    [datas.groups addObject:[[NSNumber alloc]initWithInt:self.groupID]];
                }
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
    
}

-(void) createGroup {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/createGroup"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@", self.username];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
                if([dict[@"groupID"] intValue] != -1){
                    [self.datas.groups addObject:dict[@"groupID"]];
                }
                NSLog(@"data model info: ");
                [self.datas print];
            }
        }];
    [dataTask resume];
    
}

-(void) deleteEvent {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/deleteEvent"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"groupID=%d&eventID=%d", self.groupID, self.eventID];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
            }
        }];
    [dataTask resume];
    
}

-(void) addEvent {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/addEvent"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&groupID=%d&timeFrom=%@&timeTo=%@&content=%@", self.username, self.groupID,self.timeFrom,self.timeTo,self.content];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
            }
        }];
    [dataTask resume];
    
}

-(void) editEvent {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://118.126.92.37:8081/api/editEvent"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&groupID=%d&eventID=%d&timeFrom=%@&timeTo=%@&content=%@", self.username, self.groupID,self.eventID,self.timeFrom,self.timeTo,self.content];
    NSString *body = [bodyStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", dict);
            }
        }];
    [dataTask resume];
    
}

- (UIButton *)button1 {
    if(_button1 == nil) {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.1,[UIScreen mainScreen].bounds.size.width * 0.6,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button1 setTitle:@"register" forState:UIControlStateNormal];
        _button1.backgroundColor = [UIColor blackColor];
        _button1.layer.cornerRadius = 5;
        _button1.titleLabel.textColor = [UIColor blackColor];
        [_button1 addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button1];
    }
    return _button1;
}

- (UIButton *)button2 {
    if(_button2 == nil) {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.2,[UIScreen mainScreen].bounds.size.width * 0.6,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button2 setTitle:@"login" forState:UIControlStateNormal];
        _button2.backgroundColor = [UIColor blackColor];
        _button2.layer.cornerRadius = 5;
        _button2.titleLabel.textColor = [UIColor blackColor];
        [_button2 addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button2];
    }
    return _button2;
}

- (UIButton *)button3 {
    if(_button3 == nil) {
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.3,[UIScreen mainScreen].bounds.size.width * 0.6,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button3 setTitle:@"getEventList" forState:UIControlStateNormal];
        _button3.backgroundColor = [UIColor blackColor];
        _button3.layer.cornerRadius = 5;
        _button3.titleLabel.textColor = [UIColor blackColor];
        [_button3 addTarget:self action:@selector(getEventList) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button3];
    }
    return _button3;
}

- (UIButton *)button4 {
    if(_button4 == nil) {
        _button4 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.4,[UIScreen mainScreen].bounds.size.width * 0.6,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button4 setTitle:@"getGroupList" forState:UIControlStateNormal];
        _button4.backgroundColor = [UIColor blackColor];
        _button4.layer.cornerRadius = 5;
        _button4.titleLabel.textColor = [UIColor blackColor];
        [_button4 addTarget:self action:@selector(getGroupList) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button4];
    }
    return _button4;
}

- (UIButton *)button5 {
    if(_button5 == nil) {
        _button5 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.5,[UIScreen mainScreen].bounds.size.width * 0.6,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button5 setTitle:@"leaveGroup" forState:UIControlStateNormal];
        _button5.backgroundColor = [UIColor blackColor];
        _button5.layer.cornerRadius = 5;
        _button5.titleLabel.textColor = [UIColor blackColor];
        [_button5 addTarget:self action:@selector(leaveGroup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button5];
    }
    return _button5;
}

- (UIButton *)button6 {
    if(_button6 == nil) {
        _button6 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.6,[UIScreen mainScreen].bounds.size.width * 0.7,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button6 setTitle:@"enterGroup" forState:UIControlStateNormal];
        _button6.backgroundColor = [UIColor blackColor];
        _button6.layer.cornerRadius = 5;
        _button6.titleLabel.textColor = [UIColor blackColor];
        [_button6 addTarget:self action:@selector(enterGroup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button6];
    }
    return _button6;
}

- (UIButton *)button7 {
    if(_button7 == nil) {
        _button7 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.7,[UIScreen mainScreen].bounds.size.width * 0.7,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button7 setTitle:@"createGroup" forState:UIControlStateNormal];
        _button7.backgroundColor = [UIColor blackColor];
        _button7.layer.cornerRadius = 5;
        _button7.titleLabel.textColor = [UIColor blackColor];
        [_button7 addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button7];
    }
    return _button7;
}

- (UIButton *)button8 {
    if(_button8 == nil) {
        _button8 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.8,[UIScreen mainScreen].bounds.size.width * 0.7,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button8 setTitle:@"deleteEvent" forState:UIControlStateNormal];
        _button8.backgroundColor = [UIColor blackColor];
        _button8.layer.cornerRadius = 5;
        _button8.titleLabel.textColor = [UIColor blackColor];
        [_button8 addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button8];
    }
    return _button8;
}

- (UIButton *)button9 {
    if(_button9 == nil) {
        _button9 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.9,[UIScreen mainScreen].bounds.size.width * 0.7,[UIScreen mainScreen].bounds.size.height * 0.02)];
        [_button9 setTitle:@"addEvent" forState:UIControlStateNormal];
        _button9.backgroundColor = [UIColor blackColor];
        _button9.layer.cornerRadius = 5;
        _button9.titleLabel.textColor = [UIColor blackColor];
        [_button9 addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button9];
    }
    return _button9;
}

- (UIButton *)button10 {
    if(_button10 == nil) {
        _button10 = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.2, [UIScreen mainScreen].bounds.size.height * 0.93,[UIScreen mainScreen].bounds.size.width * 0.7,[UIScreen mainScreen].bounds.size.height * 0.05)];
        [_button10 setTitle:@"editEvent" forState:UIControlStateNormal];
        _button10.backgroundColor = [UIColor blackColor];
        _button10.layer.cornerRadius = 5;
        _button10.titleLabel.textColor = [UIColor blackColor];
        [_button10 addTarget:self action:@selector(editEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button10];
    }
    return _button10;
}

@end
