//
//  getwebContent.h
//  webInterate
//
//  Created by weltloose on 2019/12/15.
//  Copyright © 2019 weltloose. All rights reserved.
//

#ifndef getwebContent_h
#define getwebContent_h

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
#import "dataModel.h"

@interface getwebContentViewController : UIViewController
{
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;
    UIButton *_button5;
    UIButton *_button6;
    UIButton *_button7;
    UIButton *_button8;
    UIButton *_button9;
    UIButton *_button10;
}

- (UIButton *)button1;
- (UIButton *)button2;
- (UIButton *)button3;
- (UIButton *)button4;
- (UIButton *)button5;
- (UIButton *)button6;
- (UIButton *)button7;
- (UIButton *)button8;
- (UIButton *)button9;
- (UIButton *)button10;

@property(nonatomic, strong) NSString *username, *password, *timeFrom, *timeTo, *content;
@property(nonatomic) NSInteger groupID, eventID;
@property(nonatomic, strong) SRWebSocket *webSocket;
@property(nonatomic, strong) dataModel *datas;

@end

#endif /* getwebContent_h */
