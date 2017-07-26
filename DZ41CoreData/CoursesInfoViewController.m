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
//#import "CourseSphereCell.h"
//#import "SKUserCell.h"

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
    
    SKInformationSection,
    SKStudentsSection,
    
} SKSection;

static NSString *nameCellIdentifier = @"nameCell";
static NSString *sphereCellIdentifier = @"sphereCell";
static NSString *disciplineCellIdentifier = @"disciplineCell";
static NSString *studentCellIdentifier = @"studentCell";
static NSString *sphereSegueIdentifier = @"spheres";


@implementation CoursesInfoViewController
/*
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
*/

@end
