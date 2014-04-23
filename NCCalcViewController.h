//
//  NCCalcViewController.h
//  NewCalculator1
//
//  Created by Анастасия Долгих on 4/23/14.
//  Copyright (c) 2014 Anastasia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCCalcViewController : UIViewController<UITextFieldDelegate>
    typedef NS_ENUM(NSInteger, Sign)
    {
        plus = 1,
        minus = 2,
        multiply = 3,
        divide = 4,
        _sqrt = 5,
        _sin = 6,
        _cos = 7,
        percent = 8
    };
@end
