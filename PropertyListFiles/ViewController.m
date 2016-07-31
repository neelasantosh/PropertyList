//
//  ViewController.m
//  PropertyListFiles
//
//  Created by Rajesh on 17/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize segment,tableView,rootDictionary,arrayStudent;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //load student.plist in root dictionary
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"student" ofType:@"plist"];
    NSData *plistData = [[NSData alloc]initWithContentsOfFile:plistpath];
    
    NSPropertyListFormat format;
    NSError *error;
    rootDictionary = [NSPropertyListSerialization
                      propertyListWithData:plistData
                      options:NSPropertyListMutableContainers
                      format:&format
                      error:&error];
    NSLog(@"the data :%@",rootDictionary);
    
    //get array of dmc students from root dictionary
    arrayStudent = [rootDictionary objectForKey:@"DMC"];
    
    
}//eod viewdidload

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayStudent.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    //get student dictionary from arraystudent for indexpath
    NSMutableDictionary *studentDictionary = [arrayStudent objectAtIndex:indexPath.row];
    //get name and prn from dictioanry
    NSString *name = [studentDictionary objectForKey:@"name"];
    NSNumber *numPrn = [studentDictionary objectForKey:@"prn"];
    
    NSString *str = [NSString stringWithFormat:@"Name:%@,Prn:%@", name,numPrn];
    cell.textLabel.text = str;
    
    //show marks
    //DMC marks
    if (segment.selectedSegmentIndex == 0)
    {
        NSNumber *numAndroid = [studentDictionary objectForKey:@"android_marks"];
        NSNumber *numiOS = [studentDictionary objectForKey:@"ios_marks"];
        NSString *marks = [NSString stringWithFormat:@"Android Marks:%@,iOS Marks:%@",numAndroid,numiOS];
        cell.detailTextLabel.text = marks;
        
    }
    //DAC Marks
    if (segment.selectedSegmentIndex == 1)
    {
        NSNumber *numOracle = [studentDictionary objectForKey:@"oracle_marks"];
        NSNumber *numJava = [studentDictionary objectForKey:@"java_marks"];
        NSString *marks = [NSString stringWithFormat:@"Oracle Marks:%@,Java Marks:%@",numOracle,numJava];
        cell.detailTextLabel.text = marks;

    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeCourse:(id)sender {
    if (segment.selectedSegmentIndex == 0) {
         arrayStudent = [rootDictionary objectForKey:@"DMC"];
    }
    if (segment.selectedSegmentIndex == 1) {
        arrayStudent = [rootDictionary objectForKey:@"DAC"];
    }
    
    [self.tableView reloadData];
}
@end
