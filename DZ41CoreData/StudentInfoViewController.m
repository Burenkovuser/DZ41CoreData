//
//  StudentInfoViewController.m
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "StudentInfoViewController.h"
#import "Student+CoreDataClass.h"
#import "StudentsViewController.h"
#import "StudentInfoCell.h"

@interface StudentInfoViewController ()

@property (strong, nonatomic) Student *student;

@end

typedef enum {
    
    NameRow,
    LastnameRow,
    EmailRow,
    
} Row;

static NSString *nameCell = @"nameCell";
static NSString *lastnameCell = @"lastnameCell";
static NSString *emailCell = @"emailCell";

@implementation StudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEdit) {
        
        StudentsViewController *vc = self.studentViewController;
        
        self.student = [vc.fetchedResultsController objectAtIndexPath:vc.indexPathForEdit];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StudentInfoCell *cell = nil;
    
    
    switch (indexPath.row) {
        case NameRow:
            cell = [tableView dequeueReusableCellWithIdentifier:nameCell
                                                   forIndexPath:indexPath];
            if (self.isEdit) {
                cell.nameTextField.text = self.student.name;
            }
            
            self.nameCell = cell;
            
            return cell;
            
        case LastnameRow:
            cell = [tableView dequeueReusableCellWithIdentifier:lastnameCell
                                                   forIndexPath:indexPath];
            if (self.isEdit) {
                cell.lastnameTextField.text = self.student.lastname;
            }
            
            self.lastnameCell = cell;
            
            return cell;
            
        case EmailRow:
            cell = [tableView dequeueReusableCellWithIdentifier:emailCell
                                                   forIndexPath:indexPath];
            if (self.isEdit) {
                cell.emailTextField.text = self.student.email;
            }
            
            self.emailCell = cell;
            
            return cell;
            
        default:
            return cell;
    }
    
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    
    NSManagedObjectContext *context = [self.studentViewController.fetchedResultsController managedObjectContext];
    
    if (!self.isEdit) {
        
        Student *student = [[Student alloc] initWithContext:context];
        
        student.name = self.nameCell.nameTextField.text;
        student.lastname = self.lastnameCell.lastnameTextField.text;
        student.email = self.emailCell.emailTextField.text;
        
    } else {
        
        self.student.name = self.nameCell.nameTextField.text;
        self.student.lastname = self.lastnameCell.lastnameTextField.text;
        self.student.email = self.emailCell.emailTextField.text;
        
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
