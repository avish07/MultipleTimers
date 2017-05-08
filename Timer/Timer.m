//
//  Timer.m
//  MultipleTimer
//
//  Created by Avish Manocha on 16/04/17.
//  Copyright © 2017 Avish Manocha. All rights reserved.
//

#import "Timer.h"
#import "UICircularSlider.h"

@implementation Timer

+ (void)configureCell:(UITableViewCell *)cell withTimerArr:(NSMutableArray *)timerArr withSecondsArr:(NSMutableArray *)secondsArr forAtIndexPath:(NSIndexPath *)indexPath{
    
    if (timerArr.count) {
       dispatch_async(dispatch_get_main_queue(), ^{
            
            UILabel *timerLbl = (UILabel *)[cell.contentView viewWithTag:1];
            UILabel *circularTimerLbl = (UILabel *)[cell.contentView viewWithTag:2];
            UICircularSlider *slider = (UICircularSlider *)[cell.contentView viewWithTag:3];
            
           if (![timerArr[indexPath.row] isKindOfClass:[NSDate class]]) {
                [timerLbl  setText:@"Timer Over"];
                [circularTimerLbl setText:@"00:00"];
                slider.value = 0;
                [slider setHidden:false];
                return ;
            }
           
            NSInteger time = [timerArr[indexPath.row] timeIntervalSinceDate: [NSDate date]];
            NSInteger hour = (time / 3600) % 60;
            NSInteger minute = (time / 60) % 60;
            NSInteger second = time % 60;
            
            if (hour <= 0 && minute <= 0 && second <= 0) {
                [timerLbl  setText:@"Timer Over"];
                [circularTimerLbl setText:@"Over"];
                [slider setHidden:true];
                return ;
            }
            
            NSString *hrs, *minutes, *seconds;
            if (hour > 0) {
                hrs = [NSString stringWithFormat:@"%ld", (long)hour];
                if (hrs.length < 2) {
                    hrs = [NSString stringWithFormat:@"0%@", hrs];
                }
                
                minutes = [NSString stringWithFormat:@"%ld", (long)minute];
                if (minutes.length < 2) {
                    minutes = [NSString stringWithFormat:@"0%@", minutes];
                }
                
                [timerLbl setText:[NSString stringWithFormat:@"%@:%@", hrs, minutes]];
                [circularTimerLbl setText:[NSString stringWithFormat:@"%@:%@", hrs, minutes]];
            }
            else
            {
                minutes = [NSString stringWithFormat:@"%ld", (long)minute];
                if (minutes.length < 2) {
                    minutes = [NSString stringWithFormat:@"0%@", minutes];
                }
                
                seconds = [NSString stringWithFormat:@"%ld", (long)second];
                if (seconds.length < 2) {
                    seconds = [NSString stringWithFormat:@"0%@", seconds];
                }
                
                [timerLbl setText:[NSString stringWithFormat:@"%@:%@", minutes, seconds]];
                [circularTimerLbl setText:[NSString stringWithFormat:@"%@:%@", minutes, seconds]];
            }
            
            float sliderValue = (float)1/[secondsArr[indexPath.row] integerValue];
            slider.value = sliderValue * ([secondsArr[indexPath.row] integerValue] - time);
        });
  }
}


@end
