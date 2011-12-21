 // 
 // SBUser.h
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.


@interface SBUser : NSObject
{
	NSString *username;
	NSString *password;
}


@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
+(SBUser *)userWithName:(NSString *)username andPassword:(NSString*)password;
@end
