//
//  Web_ViewController.h
//  iPhoneHTTPServer
//
//  Created by HieuCoder on 8/31/13.
//
//

#import <UIKit/UIKit.h>

@interface Web_ViewController : UIViewController <UIWebViewDelegate,UIGestureRecognizerDelegate >
@property (weak, nonatomic) IBOutlet UIWebView *web;
- (void) initWebview:(NSString *)filePath;
@end
