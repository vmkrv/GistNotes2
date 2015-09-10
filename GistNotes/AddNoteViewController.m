//
//  AddNoteViewController.m
//  GistNotes
//
//  Created by Veaceslav Macarov on 10.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import "AddNoteViewController.h"
//-- Models
#import "GistsModel.h"

@interface AddNoteViewController () {
    GistsModel *gistModel;
}
@property (nonatomic, strong) IBOutlet UITextView *noteTextView;
@end

@implementation AddNoteViewController
@synthesize noteTextView, gistId, selectedNote;

#pragma mark - App Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.aTitle;
    gistModel = [[GistsModel alloc] init];
    
    noteTextView.text = selectedNote.noteText;
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(resignOnSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Selectors

- (IBAction)onSaveNote:(id)sender
{
    if (self.newNote) {
        [gistModel addNote:noteTextView.text withId:gistId];
    } else {
        [gistModel editNote:noteTextView.text withId:selectedNote.noteId];
    }
    [self.view endEditing:YES];
}

- (void)resignOnSwipe:(id)sender
{
    [self.view endEditing:YES];
}

@end
