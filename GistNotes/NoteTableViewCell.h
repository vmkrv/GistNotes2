//
//  NoteTableViewCell.h
//  GistNotes
//
//  Created by Veaceslav Macarov on 11.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@end
