//
//  AddViewController.m
//  EveryDo
//
//  Created by Steele on 2015-11-03.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "AddViewController.h"
#import "ToDo.h"


@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UITextField *priorityNumber;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskArray = [NSMutableArray new];
    }
    return self;
}

- (IBAction)addTaskButton:(id)sender {
    
    ToDo *task = [[ToDo alloc] initWithTitle:self.taskName.text taskDiscription:self.taskDescription.text priority:(int)[self.priorityNumber.text intValue]];
    [self.taskArray addObject:task];
}


@end
