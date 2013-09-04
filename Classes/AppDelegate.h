#import <UIKit/UIKit.h>
#import "SpringBoardLayout.h"

@class iPhoneHTTPServerViewController;
@class HTTPServer;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	HTTPServer *httpServer;
	
	UIWindow *window;
	iPhoneHTTPServerViewController *viewController;
    SpringBoardLayout    *springboardLayout;
    
}

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) IBOutlet iPhoneHTTPServerViewController *viewController;

@end

