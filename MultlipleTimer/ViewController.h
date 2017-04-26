//
//  ViewController.h
//  MultlipleTimer
//
//  Created by Avish Manocha on 4/17/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    __weak IBOutlet UITableView *tblObj;
}


@end

