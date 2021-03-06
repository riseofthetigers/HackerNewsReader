//
//  HNDataCoordinator.h
//  HackerNewsNetworker
//
//  Created by Ryan Nystrom on 4/6/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

@import Foundation;

#import "HNParseProtocol.h"

@class HNDataCoordinator;
@class HNService;

@protocol HNDataCoordinatorDelegate <NSObject>

- (void)dataCoordinator:(HNDataCoordinator *)dataCoordinator didUpdateObject:(id)object;
- (void)dataCoordinator:(HNDataCoordinator *)dataCoordinator didError:(NSError *)error;

@end

@interface HNDataCoordinator : NSObject

@property (nonatomic, weak, readonly) id <HNDataCoordinatorDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;
@property (nonatomic, strong, readonly) HNService *service;
@property (nonatomic, strong, readonly) id <HNParseProtocol> parser;

- (instancetype)initWithDelegate:(id <HNDataCoordinatorDelegate>)delegate
                   delegateQueue:(dispatch_queue_t)delegateQueue
                            path:(NSString *)path
                          parser:(id <HNParseProtocol>)parser
                     cacheName:(NSString *)cacheName NS_DESIGNATED_INITIALIZER;

- (void)fetch;
- (void)fetchWithParams:(NSDictionary *)params;
- (BOOL)isFetching;
- (BOOL)hasLoadedOnce;
- (NSString *)cacheName;

@end
