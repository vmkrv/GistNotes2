//
//  NoteEntity.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 11.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GistCopyEntity;

@interface NoteEntity : NSManagedObject

@property (nonatomic, retain) NSString *gistId;
@property (nonatomic, retain) NSString *noteText;
@property (nonatomic, retain) NSString *noteId;
@property (nonatomic, retain) GistCopyEntity *gist;

@end
