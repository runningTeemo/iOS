//
//  Tools.h
//  SwiftWebView
//
//  Created by zerlinda on 2016/10/31.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface Tools : NSObject

+ (void)setupContext: (JSContext *)ctx forKey: (NSString *)key toDo: (void (^)(NSString *text))todo;


+(JSContext*)setvalue:(id)value forKey:(NSString *)key withContext:(JSContext*)context;

@end
