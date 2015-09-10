//
//  GistCopyEntity.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 11.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GistEntity, NoteEntity;

@interface GistCopyEntity : NSManagedObject

@property (nonatomic, retain) NSString *avatarPath;
@property (nonatomic, retain) NSString *gistDate;
@property (nonatomic, retain) NSString *gistDescription;
@property (nonatomic) BOOL  gistEdited;
@property (nonatomic, retain) NSString *gistId;
@property (nonatomic, retain) NSString *noteText;
@property (nonatomic, retain) NSString *userLogin;
@property (nonatomic, retain) GistEntity *originalGist;
@property (nonatomic, retain) NSSet *notes;
@end

@interface GistCopyEntity (CoreDataGeneratedAccessors)

- (void)addNotesObject:(NoteEntity*)value;
- (void)removeNotesObject:(NoteEntity*)value;
- (void)addNotes:(NSSet*)values;
- (void)removeNotes:(NSSet*)values;

@end
