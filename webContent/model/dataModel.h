//
//  dataModel.h
//  webContent
//
//  Created by weltloose on 2019/12/19.
//  Copyright © 2019 weltloose. All rights reserved.
//

#ifndef dataModel_h
#define dataModel_h

#import <UIKit/UIKit.h>

@interface dataModel: NSObject

@property(nonatomic, strong) NSString *username, *password;
@property(nonatomic, strong) NSMutableArray *groups;
@property(nonatomic, strong) NSMutableDictionary *events;

-(void) print;

@end

#endif /* dataModel_h */
