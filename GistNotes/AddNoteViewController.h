//
//  AddNoteViewController.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 10.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <UIKit/UIKit.h>
//-- Models
#import "Note.h"

@interface AddNoteViewController : UIViewController
@property (nonatomic) BOOL newNote;
@property (strong, nonatomic) NSString *gistId;
@property (strong, nonatomic) Note *selectedNote;
@property (strong, nonatomic) NSString *aTitle;
@end
