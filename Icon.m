//
//  Icon.m
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//
#define MARGIN 4
#import "Icon.h"
#import <QuartzCore/QuartzCore.h>
#import "SpringboardLayoutAtributes.h"
#import <QuartzCore/QuartzCore.h>
static UIImage *deleteButtonImg;

@implementation Icon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,6 *self.bounds.size.height/8)];
        _imageView.layer.cornerRadius = 10.0f;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSLog(@" %f %f ",self.bounds.size.height,self.bounds.size.width);
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 6 *self.bounds.size.width/8, self.bounds.size.width,2 *self.bounds.size.height/8)];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont fontWithName:@"Verdana" size:14];
        _label.textColor = [UIColor whiteColor];
         [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_label];
        
         
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width/4, self.bounds.size.width/4)];// size if delebutton
        
        
        
        if (!deleteButtonImg)
        {
            
            // Set up deleteButton
            CGRect buttonFrame = self.deleteButton.frame;
            
            UIGraphicsBeginImageContext(buttonFrame.size);
            
            CGFloat sz = MIN(buttonFrame.size.width, buttonFrame.size.height);
          
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(buttonFrame.size.width/2, buttonFrame.size.height/2) radius:sz/2-MARGIN startAngle:0 endAngle:M_PI * 3 clockwise:YES];
            
            
        // Phan trang tri nut delete_ CHUA HIEU KY DUOC
            
            [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
            [path addLineToPoint:CGPointMake(sz-MARGIN, sz-MARGIN)];
            [path moveToPoint:CGPointMake(MARGIN, sz-MARGIN)];
            [path addLineToPoint:CGPointMake(sz-MARGIN, MARGIN)];
            [[UIColor redColor] setFill];
            
            
            [[UIColor whiteColor] setStroke];
            [path setLineWidth:2.5];
            [path fill];
            [path stroke];
            deleteButtonImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        [self.deleteButton setImage:deleteButtonImg forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
    }


    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - attribute application snippet // 
- (void) applyLayoutAttributes:(SpringboardLayoutAtributes  *)layoutAttributes
{
    if (layoutAttributes.isDeleteButtonHidden)
    {
        self.deleteButton.layer.opacity = 0.0;
        [self stopQuivering];
    }
    else
    {
        self.deleteButton.layer.opacity = 1.0;
        [self startQuivering];
        
    }

}
- (void)startQuivering
{
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-2) * M_PI/180.0;
    float stopAngle = -startAngle;
    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
    quiverAnim.autoreverses = YES;
    quiverAnim.duration = 0.2;
    quiverAnim.repeatCount = HUGE_VALF;
    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset = timeOffset;
    CALayer *layer = self.layer;
    [layer addAnimation:quiverAnim forKey:@"quivering"];
}

- (void)stopQuivering
{
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
}

@end
