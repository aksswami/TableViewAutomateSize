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

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewController ()

@property (nonatomic, strong) NSString * str;
@property (nonatomic, strong) NSMutableArray * textArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.str  = @"Random Data ";
    self.textArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10; i++) {
        int r = arc4random_uniform(25);
        NSString * strLabel = self.str;
        for (int j = 0; j < r; j++) {
            strLabel = [strLabel stringByAppendingString:self.str];
        }
        [self.textArray addObject:strLabel];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    if ([self.textArray count] != 0) {
        return [self.textArray count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableCellIdentifier" forIndexPath:indexPath];
    cell.titleLabel.text = self.str;
    cell.subtitleLabel.text = self.textArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static CustomTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"CustomTableCellIdentifier"];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (void)configureBasicCell:(CustomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setText:self.str];
    [cell.subtitleLabel setText:self.textArray[indexPath.row]];
}


- (CGFloat)calculateHeightForConfiguredSizingCell:(CustomTableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];

    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}


@end
