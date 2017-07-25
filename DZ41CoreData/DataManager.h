//
//  DataManager.h
//  DZ41CoreData
//
//  Created by Vasilii on 25.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (DataManager *) sharedManager;

@end
