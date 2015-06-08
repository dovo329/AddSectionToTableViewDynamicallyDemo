//
//  ViewController.m
//  addSectionDemo
//
//  Created by Douglas Voss on 6/6/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) int numSections;
@property (nonatomic, strong) NSMutableArray *numRowsForSection;
@property (nonatomic, strong) UIBarButtonItem *button;
@property (nonatomic, strong) NSTimer *appearTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.numSections = 2;
    self.numRowsForSection = [NSMutableArray new];
    [self.numRowsForSection addObject:@1];
    [self.numRowsForSection addObject:@2];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.button = [[UIBarButtonItem alloc] initWithTitle:@"Add Section" style:UIBarButtonItemStylePlain target:self action:@selector(buttonMethod)];
    self.navigationItem.rightBarButtonItem = self.button;
    self.view.backgroundColor = [UIColor redColor];
}

-(void)buttonMethod
{
    NSLog(@"button pressed");
    self.numSections++;
    // add new section with 0 rows to begin with
    [self.numRowsForSection addObject:@0];
    // start timer to make new rows appear
    self.appearTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timedAppearMethod) userInfo:nil repeats:YES];
}

-(void)timedAppearMethod
{
    int newSectionIndex = (int)([self.numRowsForSection count]-1);
    int curNumRows = [self.numRowsForSection[newSectionIndex] intValue];
    if (curNumRows <= self.numSections)
    {
        curNumRows++;
        self.numRowsForSection[newSectionIndex] = [NSNumber numberWithInt:curNumRows];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(curNumRows-1) inSection:newSectionIndex]
                         atScrollPosition:UITableViewScrollPositionBottom
                                 animated:YES];
    } else {
        // cancel timer
        self.appearTimer = nil;
        [self.appearTimer invalidate];
    }
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section: %d", (int)section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.numRowsForSection[section] intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
