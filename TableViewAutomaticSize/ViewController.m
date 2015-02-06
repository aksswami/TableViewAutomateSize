//
//  ViewController.m
//  TableViewAutomaticSize
//
//  Created by Amit kumar Swami on 07/02/15.
//  Copyright (c) 2015 Aks. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#include <stdlib.h>

@interface ViewController ()

@property (nonatomic, strong) NSString * str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.str  = @"Random Data ";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - TableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableCellIdentifier" forIndexPath:indexPath];
    int r = arc4random_uniform(25);
    NSString * strLabel = @"";
    for (int i = 0; i < r; i++) {
        strLabel = [strLabel stringByAppendingString:self.str];
    }
    cell.textLabel.text = strLabel;
    return cell;
}

@end
