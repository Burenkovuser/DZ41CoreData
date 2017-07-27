//
//  CourseSphereCell.h
//  DZ41CoreData
//
//  Created by Vasilii on 27.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpheresViewController.h"

@interface CourseSphereCell : UITableViewCell <SpheresProtocol>

@property (assign, nonatomic) NSInteger selectedRow;
@property (weak, nonatomic) IBOutlet UITextField *sphereTextField;

@end
