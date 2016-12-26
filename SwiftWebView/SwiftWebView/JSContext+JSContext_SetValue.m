//
//  JSContext+JSContext_SetValue.m
//  SwiftWebView
//
//  Created by zerlinda on 2016/10/31.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

#import "JSContext+JSContext_SetValue.h"

@implementation JSContext (JSContext_SetValue)

-(JSContext*)setCustomValue:(id)value key:(NSString*)key{
    self[key] = value;
    return self;
}

@end
