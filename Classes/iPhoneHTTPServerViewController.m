#import "iPhoneHTTPServerViewController.h"

#import "FileManager.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"




@implementation iPhoneHTTPServerViewController

- (void) viewDidLoad
{
   
}



- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissModalViewControllerAnimated:YES];
}


@end
