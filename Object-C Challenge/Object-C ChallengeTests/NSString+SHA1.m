//
//  NSString+SHA1.m
//  McDonaldsSDK
//
//  Created by sathyam on 1/26/15.
//  Copyright (c) 2015 McDonald's. All rights reserved.
//

#import "NSString+SHA1.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SHA1)
- (NSString *)sha1String
{
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t sha1Data[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(stringData.bytes, (unsigned int)stringData.length, sha1Data);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", sha1Data[i]];
    return output;
}
@end
