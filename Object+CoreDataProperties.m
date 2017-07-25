//
//  Object+CoreDataProperties.m
//  DZ41CoreData
//
//  Created by Vasilii on 25.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "Object+CoreDataProperties.h"

@implementation Object (CoreDataProperties)

+ (NSFetchRequest<Object *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Object"];
}


@end
