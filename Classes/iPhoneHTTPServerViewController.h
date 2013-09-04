#import <UIKit/UIKit.h>
#import "ReaderViewController.h"


@interface iPhoneHTTPServerViewController : UIViewController <ReaderContentViewDelegate>
@property (strong,nonatomic) NSArray *itemsInApps;
@property (strong,nonatomic) NSURL *currentURL;

@end


