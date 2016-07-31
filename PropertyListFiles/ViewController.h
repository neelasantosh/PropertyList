//
//  ViewController.h
//  PropertyListFiles
//
//  Created by Rajesh on 17/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableDictionary *rootDictionary;

@property NSMutableArray *arrayStudent;
- (IBAction)changeCourse:(id)sender;

@end

