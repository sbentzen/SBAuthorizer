 // 
 // SBAuthorizer.h
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.
 // 
 // 
 // 

typedef bool (^finishedAuthorization)();

@interface SBAuthorizer : NSObject <NSURLConnectionDelegate>
{
@private
	NSURLProtectionSpace *protectionSpace;
	
}

@property (nonatomic, strong) NSURLProtectionSpace *protectionSpace;

-(BOOL) authorizeUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm;
-(void) authorizeUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm andCallBackBlock:(finishedAuthorization)callback;

@end