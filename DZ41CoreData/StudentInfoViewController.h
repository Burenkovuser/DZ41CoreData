//
//  StudentInfoViewController.h
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StudentsViewController;
@class StudentInfoCell;

@interface StudentInfoViewController : UITableViewController

@property (weak, nonatomic) StudentsViewController *studentViewController;

@property (weak, nonatomic) StudentInfoCell *nameCell;
@property (weak, nonatomic) StudentInfoCell *lastnameCell;
@property (weak, nonatomic) StudentInfoCell *emailCell;
@property (assign, nonatomic) BOOL isEdit;

- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)doneAction:(UIBarButtonItem *)sender;

@end
