//
//  ViewController.h
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//

#import <UIKit/UIKit.h>
#import "SpringBoardLayout.h"
#import "ReaderViewController.h"
#import "ViewReaderController.h"
#import "Web_ViewController.h"

@interface ViewController : UICollectionViewController <SpringboardLayoutDelegate,UIGestureRecognizerDelegate, ReaderViewControllerDelegate>
@property (strong,nonatomic) NSMutableArray *itemsInApps;
@property (strong,nonatomic) NSURL *currentURL;
@property   (strong,nonatomic) UIActivityViewController *shareController;
@property   (strong,nonatomic) NSURL *url;
@property (strong,nonatomic) NSArray *paths;
@property  (strong,nonatomic) NSString *documentDirectory;
@property   (strong,nonatomic)  NSFileManager *fileManager;

- (void)initFileManager;
- (void) displayMessage: (NSString *) message;
- (void) showIpAddressWithPort: (NSString *) port;

@end
