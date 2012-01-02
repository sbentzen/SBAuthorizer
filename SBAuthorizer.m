 // 
 // SBAuthorizer.m
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.
 // 
#import "SBAuthorizer.h"

@implementation SBAuthorizer

@synthesize protectionSpace = _protectionSpace;
- (id)init
{
	if((self = [super init]))
	{
	}
	return self;
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
	return YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	if ([challenge previousFailureCount] == 0) {
			[[challenge sender] useCredential:[[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:_protectionSpace] forAuthenticationChallenge:challenge];
		} 
	    else {
	        [[challenge sender] cancelAuthenticationChallenge:challenge];  
	    }
}

-(BOOL) authorizeUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm {
	protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:[URL host] port:443 protocol:NSURLProtectionSpaceHTTPS realm:realm authenticationMethod:NSURLAuthenticationMethodServerTrust];
	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:[NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceForSession] forProtectionSpace:_protectionSpace];
	NSURLConnection *authorizationConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:URL] delegate:self];

}

-(void) authorizeUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm andCallBackBlock:(finishedAuthorization)callback{
	if ([self authorizeUser:username withPassword:password againstURL:URL realm:realm] == YES){
		callback();
	}
	else{
		NSLog (@"Something Happened");
	}	
}

@end