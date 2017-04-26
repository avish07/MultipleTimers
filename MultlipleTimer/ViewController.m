//
//  ViewController.m
//  MultlipleTimer
//
//  Created by Avish Manocha on 4/17/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "ViewController.h"
#import "UICircularSlider.h"
#import "Timer.h"

@interface ViewController (){
    NSTimer *refreshTimer;
    NSMutableArray *timerArr, *secondsArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialiseData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialiseData{
    timerArr = [[NSMutableArray alloc] init];
    secondsArr = [[NSMutableArray alloc] init];
    
    // expireInArr (time left), expireTimeArr (Total time)
    NSMutableArray *expireArr;
    expireArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 15; i++) {
        if (i == 5 || i == 10) {
            [expireArr addObject:@{@"expire_in": @"-1", @"expire_time": @"1800"}];
        }
        
        if (i < 5 || i > 13) {
            [expireArr addObject:@{@"expire_in" : @"1800", @"expire_time": @"1800"}];
        }
        else
        {
            [expireArr addObject:@{@"expire_in" : @"900", @"expire_time": @"1800"}];
        }
    
    }
    
    for (NSDictionary *dict in expireArr) {
        NSDate *newDate;
        if ([dict[@"expire_in"] integerValue] < 0) {
            [timerArr addObject:@"-1"];
        }
        else
        {
            newDate = [NSDate dateWithTimeIntervalSinceNow: [dict[@"expire_in"] integerValue]];
            [timerArr addObject: newDate];
        }
        
        if (newDate > 0) {
            NSInteger seconds = [[NSDate dateWithTimeIntervalSinceNow:[dict[@"expire_time"] intValue]] timeIntervalSinceDate:[NSDate date]];
            [secondsArr addObject: [NSString stringWithFormat:@"%ld", (long)seconds]];
        }
        else
        {
            [secondsArr addObject:@"-1"];
        }
    }
    [tblObj setDataSource:self];
    [tblObj setDelegate:self];
    [tblObj reloadData];
    [self validateTimer];
}

// timer
-(void)validateTimer{
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadTableCells:) userInfo:nil repeats:YES];
}

-(void)reloadTableCells:(NSTimer *)timer{
    for (UITableViewCell *cell in tblObj.visibleCells) {
        NSIndexPath *path = [tblObj indexPathForCell:cell];
        if (path.row < timerArr.count) {
            [Timer configureCell:cell withTimerArr:timerArr withSecondsArr:secondsArr forAtIndexPath:path];
        }
    }
}

#pragma mark - UITableview Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return timerArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"TimerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [Timer configureCell:cell withTimerArr:timerArr withSecondsArr:secondsArr forAtIndexPath:indexPath];
    
    return cell;
    
}

@end
