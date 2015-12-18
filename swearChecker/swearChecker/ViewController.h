//
//  ViewController.h
//  swearChecker
//
//  Created by Max Rose on 12/18/15.
//  Copyright © 2015 MR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>{
    int redCount;
    int blackCount;
}
@property (nonatomic, strong) NSDictionary *messages;
@property (nonatomic, retain) NSString *userText;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *test;
@property (nonatomic) BOOL canSendMessages;
@property (nonatomic) BOOL containsBlackWords;
@property (nonatomic) BOOL containsRedWords;
@property (nonatomic) BOOL messageIsReadyToSend;

@end

