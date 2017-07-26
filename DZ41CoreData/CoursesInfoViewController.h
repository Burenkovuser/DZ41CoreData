//
//  CoursesInfoViewController.h
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoursesViewController;
@class CourseInfoCell;
//@class CourseSphereCell;
//@class UserCell;

@interface CoursesInfoViewController : UITableViewController

@property (weak, nonatomic) CoursesViewController *coursesViewController;

@property (weak, nonatomic) CourseInfoCell *nameCell;
@property (weak, nonatomic) CourseInfoCell *disciplineCell;
//@property (weak, nonatomic) CourseSphereCell *sphereCell;
//@property (strong, nonatomic) NSMutableArray<UserCell *> *studentCells;

@property (assign, nonatomic) BOOL isEdit;

- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)doneAction:(UIBarButtonItem *)sender;


@end
