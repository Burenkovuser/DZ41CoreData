//
//  SpheresViewController.h
//  DZ41CoreData
//
//  Created by Vasilii on 26.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SpheresProtocol <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *sphereTextField;
@property (assign, nonatomic) NSInteger selectedRow;

@end

@interface SpheresViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *spherePicker;
@property (weak, nonatomic) id <SpheresProtocol> delegate;

@end
