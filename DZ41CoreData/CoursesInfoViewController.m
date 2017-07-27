//
//  CoursesInfoViewController.m
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "CoursesInfoViewController.h"
#import "Course+CoreDataClass.h"
#import "SpheresViewController.h"
#import "Student+CoreDataClass.h"
#import "DataManager.h"
#import "CoursesViewController.h"
#import "CourseInfoCell.h"
#import "CourseSphereCell.h"
#import "UserCell.h"

@interface CoursesInfoViewController ()<UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Course *course;
@property (strong , nonatomic) NSArray *studentsArray;
@property (strong, nonatomic) NSMutableSet *selectedStudentsSet;

@end

typedef enum {
    
    NameRow,
    DisciplineRow,
    SphereRow,
    
} Row;

typedef enum {
    
    InformationSection,
    StudentsSection,
    
} SKSection;

static NSString *nameCellIdentifier = @"nameCell";
static NSString *sphereCellIdentifier = @"sphereCell";
static NSString *disciplineCellIdentifier = @"disciplineCell";
static NSString *studentCellIdentifier = @"studentCell";
static NSString *sphereSegueIdentifier = @"spheres";


@implementation CoursesInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEdit) {
        
        CoursesViewController *vc = self.coursesViewController;
        
        self.course = [vc.fetchedResultsController objectAtIndexPath:vc.indexPathForEdit];
        
        self.selectedStudentsSet = [NSMutableSet setWithSet:self.course.students];
    } else {
        self.selectedStudentsSet = [NSMutableSet set];
    }
    
    self.studentsArray = [[[[DataManager sharedManager] persistentContainer] viewContext]
                          executeFetchRequest:[Student fetchRequest] error:nil];
    
    self.studentCells = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == StudentsSection) {
        [self.selectedStudentsSet addObject:[self.studentsArray objectAtIndex:indexPath.row]];
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == StudentsSection) {
        [self.selectedStudentsSet removeObject:[self.studentsArray objectAtIndex:indexPath.row]];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == StudentsSection) {
        
        return YES;
    }
    return NO;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.sphereCell.sphereTextField]) {
        [self performSegueWithIdentifier:sphereSegueIdentifier sender:textField];
        return NO;
    }
    return YES;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == InformationSection) {
        return 3;
    } else if (section == StudentsSection) {
        return [self.studentsArray count];
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == InformationSection) {
        return @"Course information";
    } else if (section == StudentsSection) {
        return @"Students on course";
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == InformationSection) {
        
        switch (indexPath.row) {
            case NameRow:
                cell = [tableView dequeueReusableCellWithIdentifier:nameCellIdentifier
                                                       forIndexPath:indexPath];
                
                self.nameCell = (CourseInfoCell *)cell;
                
                if (self.isEdit) {
                    self.nameCell.nameTextField.text = self.course.name;
                }
                
                return self.nameCell;
                
            case DisciplineRow:
                cell = [tableView dequeueReusableCellWithIdentifier:disciplineCellIdentifier
                                                       forIndexPath:indexPath];
                
                self.disciplineCell = (CourseInfoCell *)cell;
                
                if (self.isEdit) {
                    self.disciplineCell.disciplineTextField.text = self.course.discipline;
                }
                
                return self.disciplineCell;
                
            case SphereRow:
                cell = [tableView dequeueReusableCellWithIdentifier:sphereCellIdentifier
                                                       forIndexPath:indexPath];
                
                self.sphereCell = (CourseSphereCell *)cell;
                
                if (self.isEdit) {
                    self.sphereCell.sphereTextField.text = self.course.sphere;
                }
                
                return self.sphereCell;
            default:
                return nil;
        }
    } else if (indexPath.section == StudentsSection) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier
                                               forIndexPath:indexPath];
        
        UserCell *studentCell = (UserCell *)cell;
        
        Student *student = [self.studentsArray objectAtIndex:indexPath.row];
        
        studentCell.textLabel.text = [NSString stringWithFormat:@"%@, %@", student.name, student.lastname];
        
        [self.studentCells addObject:studentCell];
        
        if (self.isEdit && [self.selectedStudentsSet containsObject:student]) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        return studentCell;
    }
    
    return nil;
}

#pragma mark - Actions

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    
    NSManagedObjectContext *context = [self.coursesViewController.fetchedResultsController managedObjectContext];
    
    if (!self.isEdit) {
        
        Course *course = [[Course alloc] initWithContext:context];
        
        course.name = self.nameCell.nameTextField.text;
        course.discipline = self.disciplineCell.disciplineTextField.text;
        course.sphere = self.sphereCell.sphereTextField.text;
        course.students = self.selectedStudentsSet;
        
    } else {
        
        self.course.name = self.nameCell.nameTextField.text;
        self.course.discipline = self.disciplineCell.disciplineTextField.text;
        self.course.sphere = self.sphereCell.sphereTextField.text;
        self.course.students = self.selectedStudentsSet;
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:sphereSegueIdentifier]) {
        
        SpheresViewController *vc = [segue destinationViewController];
        
        vc.delegate = self.sphereCell;
        
        vc.popoverPresentationController.delegate = self;
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        
        CGRect popoverRect = [sender convertRect:((UITextField *)sender).frame toView:self.tableView];
        
        popover.sourceView = self.tableView;
        popover.sourceRect = popoverRect;
    }
}


@end
