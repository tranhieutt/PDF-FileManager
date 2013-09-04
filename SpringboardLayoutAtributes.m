//
//  SpringboardLayoutAtributes.m
//  iPhoneHTTPServer
//
//  Created by Mac on 8/29/13.
//
//

#import "SpringboardLayoutAtributes.h"

@implementation SpringboardLayoutAtributes
- (id) copyWithZone:(NSZone *)zone
{
    SpringboardLayoutAtributes *atributes = [super copyWithZone:zone];
    atributes.deleteButtonHidden    = _deleteButtonHidden;
    return atributes    ;
}

@end
