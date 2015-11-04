//
//  ToDo.m
//  EveryDo
//
//  Created by Steele on 2015-11-03.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString*)title taskDiscription:(NSString*)taskDiscription priority:(int)priority
{
    self = [super init];
    if (self) {
        _title = title;
        _taskDescription = taskDiscription;
        _priorityNumber = priority;
        _completed = NO;
    }
    return self;
}



@end
