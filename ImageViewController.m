//
//  ImageViewController.m
//  PDFFileManager
//
//  Created by HieuCoder on 9/4/13.
//
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
UIActivityViewController* shareController;
}
@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) initImageView:(NSData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData];
    [_imageView setImage:image];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
   
    
}
- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)share:(UIBarButtonItem *) sender {
    NSLog(@" Test Share");
    
    NSData *compressedImage = UIImageJPEGRepresentation(self.imageView.image, 0.8 );
    NSLog(@" %@",self.imageView.image);
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath = [docsPath stringByAppendingPathComponent:@"image.jpg"];
    NSURL *imageUrl     = [NSURL fileURLWithPath:imagePath];
    [compressedImage writeToFile:imagePath atomically:YES];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[ @"Check this out!", imageUrl ] applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
      
}



@end
