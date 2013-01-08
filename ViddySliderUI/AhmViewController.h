//
//  AhmViewController.h
//  ViddySliderUI
//
//  Created by AHMAD on 1/7/13.
//  Copyright (c) 2013 Ahmadeus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>

@interface AhmViewController : UIViewController {
   IBOutlet UIView * firstView;
   IBOutlet UIView * secondView;
   IBOutlet UIView * thirdView;
   IBOutlet UIView * touchContainerView;
   
   IBOutlet UIButton * firstButton;
   IBOutlet UIButton * secondButton;
   IBOutlet UIButton * thirdButton;
   IBOutlet UIView * moveButton;
   
   int prevSelectedIndex;
   int currentSelectedIndex;
}

@property (nonatomic, strong ) UIView * moveButton;
@property (nonatomic, strong ) UIView * touchContainerView;
@property (nonatomic, strong ) UIButton * firstButton;
@property (nonatomic, strong ) UIButton * secondButton;
@property (nonatomic, strong ) UIButton * thirdButton;
@property (nonatomic, strong )  UIView * firstView;
@property (nonatomic, strong )  UIView * secondView;
@property (nonatomic, strong )  UIView * thirdView;
-(void) switchBetweenViews;
-(IBAction)setCurrentView:(id)sender;

@end
