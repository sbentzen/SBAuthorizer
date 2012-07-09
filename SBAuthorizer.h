 // 
 // SBAuthorizer.h
 // sbentzen
 // 
 // Created by Shaun Bentzen on 2011-12-21.
 // Copyright 2011 Shaun Bentzen. All rights reserved.
 // 
 // 

/**
 *  A class to abstract authentication and provide callback methods upon successful completion of authentication
 *  I think there may be ways that i can improve on this, maybe add a default block or add some resiliency?
*/
@interface SBAuthorizer : NSObject <NSURLConnectionDelegate>
{
@private
    void (^finishedAuthorization)(NSData *data, NSURLResponse *response, NSError *error);
    NSString *username;
    NSString *password;
    NSString *realm;
    NSURL *url;
	NSURLProtectionSpace *protectionSpace;
	NSMutableData *receivedData;
    NSURLResponse *receivedResponse;
}
/**
 * The protection space for this app
 */
@property (nonatomic, strong) NSURLProtectionSpace *protectionSpace;
/**
 * The username to authenticate
 */
@property (nonatomic, strong) NSString *username;
/**
 * The password to use
 */
@property (nonatomic, strong) NSString *password;
/**
 * The realm (server, domain or whatever) to authenticate against
 */
@property (nonatomic, strong) NSString *realm;
/**
 * the URL you're trying to access
 */
@property (nonatomic, strong) NSURL *url;


/**
 * The initializer method for this library. there's another one just without the realm when you know that you don't have to use it.
 * @param username The username to authenticate
 * @param password The password to use
 * @param URL The URL to access
 * @param realm Used when realms are different than server names
 * @param callback the callback block and what to do when authentication is complete
	
*/
-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL realm:(NSString *)realm andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;

/**
 * Another initializer method
 * @param username The username to authenticate
 * @param password The password to use
 * @param URL The URL to access
 * @param callback the callback block and what to do when authentication is complete
	
 */
-(id) initWithUser:(NSString *)username withPassword:(NSString *)password againstURL:(NSURL *)URL andCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;

/**
 * Begin the NSURL connection with the information provided to authenticate the user
 */
-(void) startAuthorization;
@end