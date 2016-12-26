//
//  Tools.m
//  SwiftWebView
//
//  Created by zerlinda on 2016/10/31.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (void)setupContext: (JSContext *)ctx forKey: (NSString *)key toDo: (void (^)(NSString *text))todo {
    ctx[key] = ^(NSString *t) {
        todo(t);
    };
    
}

+(JSContext*)setvalue:(id)value forKey:(NSString *)key withContext:(JSContext*)context{
    context[key] = value;
    return context;
}

@end
