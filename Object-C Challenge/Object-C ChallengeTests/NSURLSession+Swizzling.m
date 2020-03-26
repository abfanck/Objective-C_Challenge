//
//  NSURLSession+Swizzling.m
//  Object-C ChallengeTests
//
//  Created by Alice Wiener on 25/03/20.
//

#import "NSURLSession+Swizzling.h"
#import <objc/runtime.h>
#import "NSString+SHA1.h"

// AMW: Method swizzling is the process of changing the implementation of an existing selector at runtime. Simply speaking, we can change the functionality of a method at runtime.
// AMW: Muitos dos frameworks que fazem o mock de requisições usam Swizzling.
// AMW: Por exemplo:
// AMW: https://github.com/jedlewison/Interceptor/blob/master/Interceptor/NSURLSession%2BSwizzling.m
// AMW: https://github.com/AliSoftware/OHHTTPStubs (see Automatic loading)
@implementation NSURLSession (Swizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(dataTaskWithURL:completionHandler:);
        SEL swizzledSelector = @selector(swizzled_dataTaskWithURL:completionHandler:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod)
        {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else
        {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (NSURLSessionDataTask *)swizzled_dataTaskWithURL:(NSURL *)url
                                 completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    NSString *hash = [url.absoluteString sha1String];
    
    // AMW: Precisaria mudar para pegar o bundle de testes.
    NSString *path;
    for (NSBundle *bundle in [NSBundle allBundles]) {
        path = [bundle pathForResource:hash ofType:@"json"];
        if (path != nil) break;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    completionHandler(data, nil, nil);

    return nil;
}

@end
