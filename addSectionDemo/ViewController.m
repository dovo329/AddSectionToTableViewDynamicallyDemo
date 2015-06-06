//
//  ViewController.m
//  addSectionDemo
//
//  Created by Douglas Voss on 6/6/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, assign) int numSections;
@property (nonatomic, strong) UIBarButtonItem *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.numSections = 2;
    self.tableView.dataSource = self;
    self.button = [[UIBarButtonItem alloc] initWithTitle:@"Add Section" style:UIBarButtonItemStylePlain target:self action:@selector(buttonMethod)];
    self.navigationItem.rightBarButtonItem = self.button;
    self.view.backgroundColor = [UIColor redColor];
}

-(void)buttonMethod
{
    NSLog(@"button pressed");
    self.numSections++;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.id.string"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell.id.string"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row: %d", (int)indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"section: %d", (int)indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
