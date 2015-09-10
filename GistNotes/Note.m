//
//  Note.m
//  GistNotes
//
//  Created by Veaceslav Macarov on 10.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import "Note.h"

@implementation Note
@synthesize gistId, noteId, noteText;

- (instancetype)initWithInfo:(NoteEntity*)noteEntity
{
    self = [super init];
    if (self) {
        gistId = noteEntity.gistId;
        noteText = noteEntity.noteText;
        noteId = noteEntity.noteId;
    }
    return self;
}
@end
