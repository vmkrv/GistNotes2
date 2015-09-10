//
//  GistDetailViewController.m
//  GistNotes
//
//  Created by Veaceslav Macarov on 08.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import "GistDetailViewController.h"
//-- Categories
#import "UIImageView+AFNetworking.h"
//-- Models
#import "GistsModel.h"
#import "Note.h"
//-- Controllers
#import "AddNoteViewController.h"
//-- Custom cells
#import "NoteTableViewCell.h"

@interface GistDetailViewController () <GistsModelDelegate>
{
    GistsModel *gistModel;
}
@property (strong,nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong,nonatomic) IBOutlet UILabel *loginLabel;
@property (strong,nonatomic) IBOutlet UITextField *nameTextField;
@property (strong,nonatomic) IBOutlet UITextView *noteTextView;
@property (strong,nonatomic) IBOutlet UIButton *originalButton;
@property (strong,nonatomic) IBOutlet UIButton *saveButton;
@property (strong,nonatomic) IBOutlet UIButton *addNoteButton;
@property (strong,nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) IBOutlet UILabel *notesLabel;
@end

@implementation GistDetailViewController
@synthesize avatarImageView, loginLabel, nameTextField, noteTextView, selectedGist;
@synthesize original, originalButton, saveButton, addNoteButton, notesLabel;

#pragma mark - App Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = self.aTitle;
    
    gistModel = [[GistsModel alloc] init];
    gistModel.delegate = self;
    [gistModel getNotesForGist:selectedGist.gistId];
    
    [avatarImageView setImageWithURL:[NSURL URLWithString:self.selectedGist.owner.avatarUrl] placeholderImage:[UIImage imageNamed:@"noAvatar"]];
    loginLabel.text = selectedGist.owner.login;
    nameTextField.text = selectedGist.gistDescription;
    noteTextView.text = selectedGist.noteText;
    
    if (original) {
        //hide original button and make all fields non-editable
        [originalButton setHidden:YES];
        [saveButton setHidden:YES];
        [addNoteButton setHidden:YES];
        notesLabel.alpha = 0.0f;
        [nameTextField setEnabled:NO];
        [noteTextView setEditable:NO];
        [self.tableView setHidden:YES];
    }
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(resignOnSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [gistModel getNotesForGist:selectedGist.gistId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Selectors

- (IBAction)onSaveChanges:(id)sender
{
    [gistModel editGist:nameTextField.text withId:selectedGist.gistId];
    [self.view endEditing:YES];
}

- (IBAction)onOriginalGist:(id)sender
{
    Gist *originalGist = [gistModel getGistOriginalWithId:selectedGist.gistId];
    
    UIStoryboard *storyboard = self.storyboard;
    GistDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"gistDetaildID"];
    vc.selectedGist = originalGist;
    vc.aTitle = @"Original gist";
    vc.original = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onAddNote:(id)sender
{
    UIStoryboard *storyboard = self.storyboard;
    AddNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addNoteID"];
    vc.newNote = YES;
    vc.gistId = selectedGist.gistId;
    vc.aTitle = @"Add note";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resignOnSwipe:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - GistsModelDelegate

- (void)dataRetrieveSucceed
{
    [self.tableView reloadData];
}

- (void)dataRetrieveFailed
{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Ooops! Smth went wrong!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gistModel.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Note *note = gistModel.notes[indexPath.row];
    cell.noteTextView.text = note.noteText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Note *note = gistModel.notes[indexPath.row];
    
    UIStoryboard *storyboard = self.storyboard;
    AddNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addNoteID"];
    vc.newNote = NO;
    vc.selectedNote = note;
    vc.gistId = selectedGist.gistId;
    vc.aTitle = @"Edit note";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
