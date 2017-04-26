//
//  Timer.h
//  MultipleTimer
//
//  Created by Avish Manocha on 16/04/17.
//  Copyright © 2017 Avish Manocha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Timer : NSObject

+ (void)configureCell:(UITableViewCell *)cell withTimerArr:(NSMutableArray *)timerArr withSecondsArr:(NSMutableArray *)secondsArr forAtIndexPath:(NSIndexPath *)indexPath;

@end
