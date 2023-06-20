#line 1 "/Users/xuzhengda/Documents/Github/GuardianTalesBypass/gt/gt.xm"
#import "p_inc.h"


void constructor() __attribute__((constructor));
void constructor(void){
    doLoadFramework();
    execNewAc();
    NSLog(@"#pc start");
}
