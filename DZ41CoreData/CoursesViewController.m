//
//  CoursesViewController.m
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "CoursesViewController.h"
#import "CoursesInfoViewController.h"
#import "Course+CoreDataClass.h"
#import "CourseCell.h"


@interface CoursesViewController ()

@end

static NSString *newCourseIdentifier = @"addNewCourse";
static NSString *editCourseIdentifier = @"editCourse";

@implementation CoursesViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - fetched result

- (NSFetchedResultsController *) fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set sort descriptors
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    
    if (![aFetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}


#pragma mark - Table view data source

- (void)configureCell:(CourseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.indexPathForEdit = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:editCourseIdentifier sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:newCourseIdentifier]) {
        
        CoursesInfoViewController *vc = [segue destinationViewController];
        
        vc.coursesViewController = self;
        vc.isEdit = NO;
    }
    
    if ([segue.identifier isEqualToString:editCourseIdentifier]) {
        
        CoursesInfoViewController *vc = [segue destinationViewController];
        
        vc.coursesViewController = self;
        vc.title = @"Edit course";
        vc.isEdit = YES;
    }
}

@end
