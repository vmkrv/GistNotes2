//
//  Place.m
//  City Guide
//
//  Created by Veaceslav Macarov on 23.08.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import "Gist.h"

#define kParameterId @"id"
#define kParameterDescription @"description"
#define kParameterDateCreated @"created_at"
#define kParameterOwner @"owner"

#define kParameterAvatar @"avatar_url"
#define kParameterLogin @"login"

@implementation Gist
@synthesize gistId, gistDescription, createdDate, owner, noteText;

#pragma mark - Designated Initializer

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        gistId = info[kParameterId];
        gistDescription = info[kParameterDescription];
        
        if ([gistDescription isEqual:[NSNull null]]) {
            gistDescription = @"";
        }
        
        createdDate = info[kParameterDateCreated];
        owner = [[Owner alloc] initWithInfo:info[kParameterOwner]];
        noteText = @"";
    }
    return self;
}

- (instancetype)initWithEntity:(GistCopyEntity *)GistCopyEntity
{
    self = [super init];
    if (self) {
        gistId = GistCopyEntity.gistId;
        gistDescription = GistCopyEntity.gistDescription;
        createdDate = GistCopyEntity.gistDate;
        
        if ([GistCopyEntity respondsToSelector:@selector(noteText)]) {
            noteText = GistCopyEntity.noteText;
        }
        
        NSString *tempAvatarPath;
        NSString *tempLogin;
        if (GistCopyEntity.avatarPath.length > 0) {
            tempAvatarPath = GistCopyEntity.avatarPath;
        } else {
            tempAvatarPath = @"";
        }
        if (GistCopyEntity.userLogin.length > 0) {
            tempLogin = GistCopyEntity.userLogin;
        } else {
           tempLogin = @"";
        }
        NSDictionary *info = @{kParameterAvatar:tempAvatarPath,kParameterLogin:tempLogin};
        owner = [[Owner alloc] initWithInfo:info];
    }
    return self;
}

@end
