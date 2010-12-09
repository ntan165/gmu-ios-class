//
//  SMLoginViewController.m
//  SportsManagement
//
//  Created by Jason Harwig on 11/18/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import "SMLoginViewController.h"


@implementation SMLoginViewController
- (id)initWithChallenge:(NSURLAuthenticationChallenge *)c
{
    challenge = [c retain];
    return [super initWithNibName:@"Login" bundle:nil];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithChallenge:nil];
}
- (void) dealloc
{
    [challenge release];
    [super dealloc];
}

- (void)viewDidLoad
{
    username.text = [[challenge proposedCredential] user];
    password.text = [[challenge proposedCredential] password];
}

- (IBAction)login
{
    NSString *u = username.text;
    NSString *p = password.text;
    if ([u isEqualToString:@""] || [p isEqualToString:@""])
        return;
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:u
                                                             password:p
                                                          persistence:NSURLCredentialPersistencePermanent];    
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

// TODO implement UITextFieldDelegate method to dismiss keyboard on ENTER


@end
