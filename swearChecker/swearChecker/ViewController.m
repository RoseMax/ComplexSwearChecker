//
//  ViewController.m
//  swearChecker
//
//  Created by Max Rose on 12/18/15.
//  Copyright © 2015 MR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self getList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getList{
    NSString *url = @"JSON LOCATION GOES HERE";
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if(error)return;
                NSError *jerror;
                self.messages = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jerror];
            }] resume];
}
- (IBAction)test:(id)sender {
    [self getMessageReadyToSend];
}
-(void)showBlackAlertView{
    UIAlertController *blackAlert = [UIAlertController alertControllerWithTitle:@"That is not very nice"message:@"This message contains mean words. Are you sure you want to send?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sendMessage = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Flagged Message Sent");
        //send message
    }];
    UIAlertAction *stopMessage = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Flagged Message Stopped");
        //stop message
    }];
    [blackAlert addAction:sendMessage];
    [blackAlert addAction:stopMessage];
    [self presentViewController:blackAlert animated:YES completion:nil];
    
}
-(void)showRedAlertView{
    UIAlertController *redAlert = [UIAlertController alertControllerWithTitle:@"Message will not be sent"message:@"You're message contained hurtful language and will not be sent."preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *stopMessage = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Flagged Message Stopped");
    }];
    [redAlert addAction:stopMessage];
    [self presentViewController:redAlert animated:YES completion:nil];
    
}
-(void)checkRedList{
    NSString *redList = [self.messages objectForKey:@"KEY FOR OBJECTIVELY OFFENSIVE WORDS GOES HERE"];
    NSArray *redArray = [redList componentsSeparatedByString:@","];
    int r;
    for (r = 0; r < [redArray count]; r++){
        id redWord = [redArray objectAtIndex:r];
        if ([self.userText containsString:redWord]) {
            redCount = redCount +1;
        }
        else{
        }
    }
}
-(void)checkBlackList{
    NSString *blackList = [self.messages objectForKey:@"KEY FOR SUBJECTIVELY OFFENSIVE WORDS GOES HERE"];
    NSArray *blackArray = [blackList componentsSeparatedByString:@","];
    int b;
    for (b = 0; b < [blackArray count]; b++) {
        id blackWord = [blackArray objectAtIndex:b];
        if ([self.userText containsString:blackWord]) {
            blackCount = blackCount +1;
        }
        else {
        }
    }
}
-(void)messageChecker{
    NSString *messageText = [self.textField.text lowercaseString];
    NSString *spacelessMessageText = [messageText stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.userText = spacelessMessageText;
    redCount = 0;
    blackCount = 0;
    [self checkRedList];
    [self checkBlackList];
    self.containsRedWords = NO;
    if (redCount >= 1) {
        self.containsRedWords = YES;
        self.messageIsReadyToSend = NO;
        //stop message
    }
    if (blackCount>=1) {
        self.containsBlackWords = YES;
    }
    else{
        self.containsBlackWords = NO;
        self.canSendMessages = YES;
        NSLog(@"Unflagged Message Sent");
    }
}
-(void)getMessageReadyToSend{
    [self messageChecker];
    NSLog(@"%d %d", redCount, blackCount);
    
    if (self.containsRedWords == YES) {
        //stop message
        NSLog(@"Message Denied");
        [self showRedAlertView];
    }
    else{
        if (self.containsBlackWords == YES) {
            [self showBlackAlertView];
        }
        self.messageIsReadyToSend = YES;
    }
}

@end
