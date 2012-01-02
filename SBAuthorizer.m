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
@synthesize _username;
@synthesize _password;
@synthesize _realm;
@synthesize _url;
- (id)init
{
	if((self = [super init]))
	{
	}
	return self;
}

-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback{
	
    if (self = [super init]) {
        finishedAuthorization = [callback copy];
        _username = [username copy];
        _password = [password copy];
        _realm = [realm copy];
        _url = [URL copy];
    }
	return self;
}
-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback{
	
    if (self = [super init]) {
        finishedAuthorization = [callback copy];
        _username = [username copy];
        _password = [password copy];
        _url = [URL copy];
    }
	return self;
}


-(void) startAuthorization{
    NSLog(@"HALLO");
    _protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:[_url host] port:443 protocol:NSURLProtectionSpaceHTTPS realm:_realm authenticationMethod:NSURLAuthenticationMethodServerTrust];
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:[NSURLCredential credentialWithUser:_username password:_password persistence:NSURLCredentialPersistenceForSession] forProtectionSpace:_protectionSpace];
    NSURLConnection *authenticationConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:_url] delegate:self];
    [authenticationConnection start];
}

#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    receivedResponse = response;
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    finishedAuthorization(nil, nil, error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (receivedData == nil) {
        receivedData = [[NSMutableData alloc] initWithData:data];
    } else {
        [receivedData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    finishedAuthorization(receivedData, receivedResponse, nil);
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
	return YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	if ([challenge previousFailureCount] == 0) {
			[[challenge sender] useCredential:[[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:_protectionSpace] forAuthenticationChallenge:challenge];
        NSLog(@"Challenge Attempted");
		} 
	    else {
	        [[challenge sender] cancelAuthenticationChallenge:challenge];
            NSLog(@"Challenge Failed");
	    }
}


@end