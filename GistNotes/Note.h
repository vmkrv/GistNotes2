//
//  Note.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 10.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteEntity.h"

@interface Note : NSObject
@property (strong, nonatomic) NSString *gistId;
@property (strong, nonatomic) NSString *noteId;
@property (strong, nonatomic) NSString *noteText;

- (instancetype)initWithInfo:(NoteEntity*)noteEntity;
@end
