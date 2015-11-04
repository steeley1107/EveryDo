//
//  MasterViewController.m
//  EveryDo
//
//  Created by Steele on 2015-11-03.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CustomTableViewCell.h"
#import "AddViewController.h"
#import "ToDo.h"

@interface MasterViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.objects = [[NSMutableArray alloc] init];
    
    ToDo *task01 = [[ToDo alloc]initWithTitle:@"Clean Clothes" taskDiscription:@"need buy washing machine first"  priority:5];
    ToDo *task02 = [[ToDo alloc]initWithTitle:@"Grocery Shopping" taskDiscription:@"pickup healthy food"  priority:4];
    ToDo *task03 = [[ToDo alloc]initWithTitle:@"Buy Car" taskDiscription:@"something cheap"  priority:3];
    ToDo *task04 = [[ToDo alloc]initWithTitle:@"Call Joe" taskDiscription:@"he owes you money"  priority:2];
    ToDo *task05 = [[ToDo alloc]initWithTitle:@"Study" taskDiscription:@"iOS test coming up"  priority:1];
    
    [self.objects addObject:task01];
    [self.objects addObject:task02];
    [self.objects addObject:task03];
    [self.objects addObject:task04];
    [self.objects addObject:task05];
    
    [self.view addGestureRecognizer:self.swipeGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    [self performSegueWithIdentifier:@"showAdd" sender:sender];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    if ([[segue identifier] isEqualToString:@"showAdd"]) {
        
        AddViewController *addVC = segue.destinationViewController;
        addVC.taskArray = self.objects;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ToDo *object = self.objects[indexPath.row];
    
    if (object.completed) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:object.title];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        
        cell.taskLabel.attributedText = attributeString;
    }else {
        cell.taskLabel.text = object.title;
    }
    
    cell.taskDescription.text = object.taskDescription;
    cell.taskPriority.text = [NSString stringWithFormat:@"%d",object.priorityNumber];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (IBAction)swipeComplete:(UISwipeGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    
    ToDo *object = self.objects[swipedIndexPath.row];
    object.completed = YES;
    [self.tableView reloadRowsAtIndexPaths:@[swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDo *task = [self.objects objectAtIndex:fromIndexPath.row];
    [self.objects removeObjectAtIndex:fromIndexPath.row];
    [self.objects insertObject:task atIndex:toIndexPath.row];
}


@end
