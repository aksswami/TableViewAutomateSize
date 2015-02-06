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
        NSString * strLabel = @"";
        for (int j = 0; j < r; j++) {
            strLabel = [strLabel stringByAppendingString:self.str];
        }
        [self.textArray addObject:strLabel];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44.0f;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    int r = arc4random_uniform(25);
    NSString * strLabel = @"";
    for (int i = 0; i < r; i++) {
        strLabel = [strLabel stringByAppendingString:self.str];
    }
    cell.textLabel.text = strLabel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYSTEM_VERSION_LESS_THAN(@"8.0"))  //iOS7 or less
    {
        static UILabel* label;
        
        if (!label) {
            label = [[ UILabel alloc]
                     initWithFrame:CGRectMake(0,0, FLT_MAX, FLT_MAX)];
            label.text = self.textArray[indexPath.row];
        }
        
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        [label sizeToFit];
        return label.frame.size.height * 2;
    }
    else // iOS8 part
    {
        return UITableViewAutomaticDimension;
    }
}

@end
