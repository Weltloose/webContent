//
//  dataModel.m
//  webContent
//
//  Created by weltloose on 2019/12/19.
//  Copyright © 2019 weltloose. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "dataModel.h"

@interface dataModel ()

@end

@implementation dataModel
@synthesize username, password, groups, events;

-(void)print{
    NSLog(@"%@", self.username);
    NSLog(@"%@", self.password);
    NSLog(@"%@", self.groups);
    NSLog(@"%@", self.events);
}

-(id)init{
    if ((self=[super init])) {
        self.groups = [[NSMutableArray alloc] init];
        self.events = [[NSMutableDictionary alloc] init];
    }
    return self;
    
}

@end

