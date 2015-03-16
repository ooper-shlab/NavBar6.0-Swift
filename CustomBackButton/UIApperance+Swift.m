//
//  UIApperance.m
//  NavBar
//
//  Created by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//

#import "UIApperance+Swift.h"

@implementation UIBarItem(UIApperance_Swift)
+ (instancetype)oop_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn: containerClass, nil];
}
@end
