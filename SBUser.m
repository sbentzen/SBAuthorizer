 // 
 // SBUser.h
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.
#import "SBUser.h"

@implementation SBUser
@synthesize username = _username;
@synthesize password = _password;

- (id)init
{
	if((self = [super init]))
	{
	}
	return self;
}

+(SBUser *)userWithName:(NSString *)username andPassword:(NSString*)password{
	SBUser *user = [[SBUser alloc] init];
	[user setUsername:username];
	[user setPassword:password];
	return [user copy];
}


@end