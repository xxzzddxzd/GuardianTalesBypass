//
//  hxshxx.m
//  hxshx
//
//  Created by xxzzddxzd on 2018/9/7.
//


#import "p_inc.h"
#import <Foundation/Foundation.h>
#import <substrate.h>
#import <mach-o/dyld.h>
#import <sys/socket.h>

#import "csharpfunc.h"
#define XLog(FORMAT, ...) NSLog(@"#pc %@" , [NSString stringWithFormat:FORMAT, ##__VA_ARGS__]);
#define psta XLog(@"%lx,%@",_dyld_get_image_vmaddr_slide(0),[NSThread callStackSymbols]);

long doLoadFramework(){
    XLog(@"###############JBDETECT##################");
    id a =[NSBundle mainBundle];
    id path = [a bundlePath];
    id bp = [path stringByAppendingString:@"/Frameworks/UnityFramework.framework"];
    id c =[NSBundle bundleWithPath:bp];
    [c load];
    long alsr=0;
//    XLog(@"alsr main %lx",_dyld_get_image_vmaddr_slide(0));
    for (int i=0; i<_dyld_image_count(); i++) {
        
        if ([[NSString stringWithUTF8String:_dyld_get_image_name(i) ]  containsString:@"UnityFramework.framework/UnityFramework"]) {
            XLog(@"%d,%s",i,_dyld_get_image_name(i));
            XLog(@"0x%lx",_dyld_get_image_vmaddr_slide(i))
            return _dyld_get_image_vmaddr_slide(i);
        }
    }
    return _dyld_get_image_vmaddr_slide(0);
}


void (*tp2_setuserinfo)(long x0,long x1);
void ne_tp2_setuserinfo(long x0,long x1){
    XLog(@"tp2_setuserinfo")
}
void execNewAc(){
    XLog(@"---START INJECT---")
    id a =[NSBundle mainBundle];
    id path = [a bundlePath];
    id bp = [path stringByAppendingString:@"/Frameworks/tersafe2.framework"];
    id bpbin = [bp stringByAppendingString:@"/tersafe2"];
    const char * bin =[bpbin UTF8String];
    MSImageRef image = MSGetImageByName(bin);
    void *_tp2_setuserinfo = MSFindSymbol(image,"_tp2_setuserinfo");
    MSHookFunction( _tp2_setuserinfo, (void*)ne_tp2_setuserinfo, (void**)&tp2_setuserinfo);
}
















