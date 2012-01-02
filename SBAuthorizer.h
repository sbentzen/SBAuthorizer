 // 
 // SBAuthorizer.h
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.
 // 
 // 
 // 



@interface SBAuthorizer : NSObject <NSURLConnectionDelegate>
{
@private
    void (^finishedAuthorization)(NSData *data, NSURLResponse *response, NSError *error);
    NSString *_username;
    NSString *_password;
    NSString *_realm;
    NSURL *_url;
	NSURLProtectionSpace *protectionSpace;
	NSMutableData *receivedData;
    NSURLResponse *receivedResponse;
}

@property (nonatomic, strong) NSURLProtectionSpace *protectionSpace;
@property (nonatomic, strong) NSString *_username;
@property (nonatomic, strong) NSString *_password;
@property (nonatomic, strong) NSString *_realm;
@property (nonatomic, strong) NSURL *_url;
-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;
-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;
- (void) startAuthorization;
@end