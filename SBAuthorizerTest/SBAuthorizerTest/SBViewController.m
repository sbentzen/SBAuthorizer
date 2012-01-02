//
//  SBViewController.m
//  SBAuthorizerTest
//
//  Created by Shaun Bentzen on Monday, January 2 2012.
//  Copyright (c) 2012 SambaWorks. All rights reserved.
//

#import "SBViewController.h"
#import "SBAuthorizer.h"

@implementation SBViewController
@synthesize StatusLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#warning FIX THE USERNAME AND PASSWORD INFORMATION
    SBAuthorizer *authorizer = [[SBAuthorizer alloc] initWithUser:@"YOURUSERNAMEHERE" withPassword:@"YOURPASSWORDHERE!" againstURL:[NSURL URLWithString:@"PLACEYOU'RETRYINGTOAUTHENTICATEAGAINST"] realm:@"REALMFORAUTHENTICATION" andCallback: ^(NSData *data, NSURLResponse *response, NSError *error){
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [StatusLabel setText:@"Failure"];
            [StatusLabel setTextColor:[UIColor redColor]];
            [StatusLabel setFont:[UIFont boldSystemFontOfSize:14]];
        }
        else{
            NSLog(@"Hallo Thar");
            [StatusLabel setText:@"Success"];
            [StatusLabel setTextColor:[UIColor greenColor]];
            [StatusLabel setFont:[UIFont boldSystemFontOfSize:14]];
        }
    }];
    [authorizer startAuthorization];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
