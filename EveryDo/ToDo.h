//
//  ToDo.h
//  EveryDo
//
//  Created by Steele on 2015-11-03.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *taskDescription;
@property (nonatomic) int priorityNumber;
@property (nonatomic) BOOL completed;


- (instancetype)initWithTitle:(NSString*)title taskDiscription:(NSString*)taskDiscription priority:(int)priority;


@end
