//
//  JSContext+JSContext_SetValue.h
//  SwiftWebView
//
//  Created by zerlinda on 2016/10/31.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContext (JSContext_SetValue)

-(JSContext*)setCustomValue:(id)value key:(NSString*)key;

@end
