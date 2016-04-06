//
//  ViewController.m
//  HLLSelectDemo
//
//  Created by admin on 16/4/6.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonnull ,strong) NSMutableArray * datas;
@property (nonatomic ,strong) NSIndexPath  * selectedIndexPath;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *chooseTypeSegmentControl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation ViewController

static NSString * const kCellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = self.editButton;
    self.tableView.tableHeaderView = self.chooseTypeSegmentControl;
    
    _datas = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 30; index ++) {
        NSString * string = [NSString stringWithFormat:@"This is NO.%ld",(long)index];
        [_datas addObject:string];
    }
#pragma mark - 决定单选或者多选
//    _tableView.allowsSelection = YES;
//    _tableView.allowsMultipleSelection = YES;
//    _tableView.allowsMultipleSelectionDuringEditing = YES;
//    _tableView.allowsSelectionDuringEditing = YES;
}
#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

#pragma mark - 防止cell重用问题
    if (cell.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return  cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    

    if (_chooseTypeSegmentControl.selectedSegmentIndex == 1) {
        
#pragma mark - 单选可以回退
        if (_selectedIndexPath == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _selectedIndexPath = nil;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _selectedIndexPath = indexPath;
        }
    }else{
    
#pragma mark - 单选多选通用
        if (cell.selected) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

#pragma mark - 单选多选通用
    if (!cell.selected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - Action

- (IBAction)chooseSegentDidChangeVaule:(UISegmentedControl *)sender {
    
    self.navigationItem.rightBarButtonItem = nil;
    
    _tableView.allowsSelection = NO;
    _tableView.allowsMultipleSelection = NO;
    _tableView.allowsMultipleSelectionDuringEditing = NO;
    
    if (sender.selectedSegmentIndex == 0) {
        
        _tableView.allowsSelection = YES;
    }else if (sender.selectedSegmentIndex == 1){
        
        _tableView.allowsSelection = YES;
    }else if (sender.selectedSegmentIndex == 2){
        
        _tableView.allowsMultipleSelection = YES;
    }else if (sender.selectedSegmentIndex == 3){
        
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        self.navigationItem.rightBarButtonItem = self.editButton;
    }
}
- (IBAction)editData:(UIBarButtonItem *)sender {
    
    if (self.tableView.isEditing) {
        self.editButton.title = @"Edit";
        [self.tableView setEditing:NO animated:YES];
    }else{
        self.editButton.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
    }
}

@end
