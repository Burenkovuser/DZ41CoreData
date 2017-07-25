//
//  Student+CoreDataProperties.m
//  DZ41CoreData
//
//  Created by Vasilii on 25.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic email;
@dynamic lastname;
@dynamic name;
@dynamic course;

@end
