//
//  Object+CoreDataProperties.h
//  DZ41CoreData
//
//  Created by Vasilii on 25.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "Object+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Object (CoreDataProperties)

+ (NSFetchRequest<Object *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
