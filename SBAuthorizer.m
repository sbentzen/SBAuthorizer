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
@synthesize username;
@synthesize password;
@synthesize realm;
@synthesize url;
- (id)init
{
	if((self = [super init]))
	{
	}
	return self;
}

-(id) initWithUser:(NSString *)aUsername withPassword:(NSString *)aPassword againstURL:(NSURL *)URL realm:(NSString *)aRealm andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback{
	
    if (self = [super init]) {
        finishedAuthorization = [callback copy];
        self.username = [aUsername copy];
        self.password = [aPassword copy];
        self.realm = [aRealm copy];
        self.url = [URL copy];
    }
	return self;
}
-(id) initWithUser:(NSString *)aUsername withPassword:(NSString *)aPassword againstURL:(NSURL *)URL andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback{
	
    if (self = [super init]) {
        finishedAuthorization = [callback copy];
        self.username = [aUsername copy];
        self.password = [aPassword copy];
        self.url = [URL copy];
    }
	return self;
}


-(void) startAuthorization{
    // NSLog(@"HALLO");
    self.protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:[self.url host] port:443 protocol:NSURLProtectionSpaceHTTPS realm:self.realm authenticationMethod:NSURLAuthenticationMethodServerTrust];
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceForSession] forProtectionSpace:self.protectionSpace];
    NSURLConnection *authenticationConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:self.url] delegate:self];
    [authenticationConnection start];
}

#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    receivedResponse = response;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    finishedAuthorization(nil, nil, error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (receivedData == nil) {
        receivedData = [[NSMutableData alloc] initWithData:data];
    } else {
        [receivedData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    finishedAuthorization(receivedData, receivedResponse, nil);
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    if ([[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:_protectionSpace] != nil) {
        return YES;
    }
    else{
        return NO;
    }
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if ([challenge previousFailureCount] == 0) {
        [[challenge sender] useCredential:[[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:_protectionSpace] forAuthenticationChallenge:challenge];
        // NSLog(@"Challenge Attempted");
    }
    else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // NSLog(@"Challenge Failed");
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
	return YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	if ([challenge previousFailureCount] == 0) {
			[[challenge sender] useCredential:[[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:_protectionSpace] forAuthenticationChallenge:challenge];
        // NSLog(@"Challenge Attempted");
		} 
	    else {
	        [[challenge sender] cancelAuthenticationChallenge:challenge];
            // NSLog(@"Challenge Failed");
	    }
}


@end