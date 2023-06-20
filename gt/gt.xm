#import "p_inc.h"
//#import "hooksocket.h"

void constructor() __attribute__((constructor));
void constructor(void){
    doLoadFramework();
    execNewAc();
    NSLog(@"#pc start");
}
