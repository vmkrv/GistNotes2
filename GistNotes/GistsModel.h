//
//  GistsModel.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 08.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <Foundation/Foundation.h>
//-- Models
#import "Gist.h"
#import "Note.h"

@protocol GistsModelDelegate;

@interface GistsModel : NSObject
@property (strong, nonatomic) NSMutableArray *gists;
@property (strong, nonatomic) NSMutableArray *notes;
@property (weak, nonatomic) id<GistsModelDelegate> delegate;
- (void)retrieveGists;
- (void)retrieveNotes;
- (void)downloadGists;
- (Gist*)getGistOriginalWithId:(NSString*)gistId;
- (void)addNote:(NSString*)noteText withId:(NSString*)gistId;
- (void)editGist:(NSString*)gistDescription withId:(NSString*)gistId;
- (void)editNote:(NSString*)noteText withId:(NSString*)noteId;
- (void)getNotesForGist:(NSString*)gistId;
@end

@protocol GistsModelDelegate
- (void)dataRetrieveSucceed;
- (void)dataRetrieveFailed;
@end