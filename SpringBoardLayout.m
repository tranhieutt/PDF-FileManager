//
//  SpringBoardLayout.m
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//

#import "SpringBoardLayout.h"
#import "SpringboardLayoutAtributes.h"

@implementation SpringBoardLayout
- (id)init
{
    if (self = [super init])
    {
        self.itemSize = CGSizeMake(100, 100);
        self.minimumInteritemSpacing = 40;
        self.minimumLineSpacing = 40;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(32, 32, 32, 32);
    }
    return self;
}

// INSERT DELETION MODE SNIPPET HERE

- (BOOL)isDeletionModeOn
{
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(SpringboardLayoutDelegate)])
    {
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:self.collectionView layout:self];
        
    }
    return NO;
    
}

// INSERT ATTRIBUTES SNIPPET HERE

+ (Class)layoutAttributesClass
{
    return [SpringboardLayoutAtributes class];
}

- (SpringboardLayoutAtributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpringboardLayoutAtributes *attributes = (SpringboardLayoutAtributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    if ([self isDeletionModeOn])
        attributes.deleteButtonHidden = NO;
    else
        attributes.deleteButtonHidden = YES;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (SpringboardLayoutAtributes *attribs in attributesArrayInRect)
    {
        if ([self isDeletionModeOn]) attribs.deleteButtonHidden = NO;
        else attribs.deleteButtonHidden = YES;
    }
    return attributesArrayInRect;
}

@end
