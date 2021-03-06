//
//  UIViewController+UISplitViewController.m
//  HackerNewsReader
//
//  Created by Ryan Nystrom on 6/1/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import "UIViewController+UISplitViewController.h"

#import "HNNavigationController.h"

@implementation UIViewController (hn_UISplitViewController)

- (void)configureLeftButtonAsDisplay {
    if (self.navigationController.viewControllers.firstObject == self) {
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
}

- (void)showDetailViewControllerWithFallback:(UIViewController *)controller {
    NSAssert(controller != nil, @"Cannot show detail for a nil controller");
    if ([self respondsToSelector:@selector(showDetailViewController:sender:)]) {
        if (!self.splitViewController.isCollapsed) {
            controller = [[HNNavigationController alloc] initWithRootViewController:controller];
        }
        [self showDetailViewController:controller sender:self];
    } else if (self.splitViewController) {
        NSArray *controllers = self.splitViewController.viewControllers;
        UINavigationController *navigation = nil;
        if (controllers.count > 1) {
            navigation = [controllers objectAtIndex:1];
        }

        NSAssert(navigation != nil, @"Detail controller has not been created for split view controller");
        NSAssert([navigation isKindOfClass:[UINavigationController class]], @"Second controller is not of type UINavigationController");
        navigation.viewControllers = @[controller];

        if (!navigation || !controllers.firstObject) {
            return;
        }

        self.splitViewController.viewControllers = @[controllers.firstObject, navigation];
    } else {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
