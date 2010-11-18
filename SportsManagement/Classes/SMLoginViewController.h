//
//  SMLoginViewController.h
//  SportsManagement
//
//  Created by Jason Harwig on 11/18/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SMLoginViewController : UIViewController {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    
    NSURLAuthenticationChallenge *challenge;
}

- (id)initWithChallenge:(NSURLAuthenticationChallenge *)c;
- (IBAction)login;

@end