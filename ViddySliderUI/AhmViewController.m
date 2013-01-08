//
//  AhmViewController.m
//  ViddySliderUI
//
//  Created by AHMAD on 1/7/13.
//  Copyright (c) 2013 Ahmadeus. All rights reserved.
//

#import "AhmViewController.h"

@interface AhmViewController ()

@end

@implementation AhmViewController
@synthesize firstView,secondView,thirdView, firstButton,secondButton,thirdButton,moveButton,touchContainerView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

   //set the frames far from the visible section in screen
   self.thirdView.frame = CGRectMake(640, 216, 320, 200);
   self.secondView.frame = CGRectMake(320, 216, 320, 200);
   // set the frame so it will placed within visible range since by default the first view is selected for display
   self.firstView.frame = CGRectMake(0, 216, 320, 200);
   
   
   // the moveButton is a View that responds to touches on screen to move between other buttons
   [self.moveButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image.png"]]];
   // set the first button image to highlighted image to indicate that it is the selected one
   [self.touchContainerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"switches"]]];
   // the portion of tool bar that contains switches and responds to the user touch and move

   // make the view with rounded corners
   self.touchContainerView.layer.cornerRadius = 5;
   self.touchContainerView.layer.masksToBounds = YES;
   [self.touchContainerView.layer setBorderWidth:1.0];

   prevSelectedIndex = 0; // previous index used to determine the animation direction left or right
   currentSelectedIndex = 0; // the current selection for the switch
   [self switchBetweenViews];
}

-(void) switchBetweenViews
{
   // used to determine animation direction (left or right)
   BOOL willAnimateFromLeft = NO;
   
   // this value will determine how far is the view from the visible range in screen
   int differenceBetweenSelectedAndPreviousView = abs(currentSelectedIndex- prevSelectedIndex);
   if(prevSelectedIndex > currentSelectedIndex)
      {
         // the animation will be from left
         willAnimateFromLeft = YES;
      }
   
   // get the frames for three views so we can edit the frame based on the switch index selection.
   CGRect firstFrame = self.firstView.frame;
   CGRect secondFrame = self.secondView.frame;
   CGRect thirdFrame = self.thirdView.frame;
   
   if(currentSelectedIndex == 0){
      
      // this means that we selected first button.
      // so we need to set the first view in visible range
      // and set the other two views outside the screen
      // this is done by adding 320  to the x offset of the view frame
      firstFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
      secondFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
      thirdFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
      
      
      [self.moveButton setFrame:self.firstButton.frame];// set the moved view to be placed at the first button frame to get the highlited effect
      
      [self.moveButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image.png"]]];// set desired image for the view
   }
   else if(currentSelectedIndex == 1){
      
      // set the moved view to be placed at the first button frame to get the highlited effect
      [self.moveButton setFrame:self.secondButton.frame];
      [self.moveButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"friends.png"]]];
      
      // this means that we selected the second button.
      // so we need to set the second view in visible range
      // this is done by adding 320  to the x offset of the view frame if the animation is from the left or by substract 320 from the x offset if the animation is from teh right
      if(willAnimateFromLeft)
         {
         firstFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
         secondFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
         thirdFrame.origin.x += differenceBetweenSelectedAndPreviousView * 320;
         }
      else
         {
         firstFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
         secondFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
         thirdFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
         }
      
   }
   else if(currentSelectedIndex == 2){
      
      // set the moved view to be placed at the first button frame to get the highlighted effect
      [self.moveButton setFrame:self.thirdButton.frame];
      
      [self.moveButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"world.png"]]];
      
      // this means that we selected the third button.
      // so we need to set the third view in visible range
      // and move other views off the screen
      // this is done by adding 320  to the x offset of t0e view frame
      firstFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
      secondFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
      thirdFrame.origin.x -= differenceBetweenSelectedAndPreviousView * 320;
   }
   
   //now we animate the view when change the frame from the old to the new
   [UIView animateWithDuration:0.30 animations:^{
      self.firstView.frame = firstFrame;
      self.secondView.frame = secondFrame;
      self.thirdView.frame = thirdFrame;
   }];
   prevSelectedIndex = currentSelectedIndex;
}

-(IBAction)setCurrentView:(id)sender
{
   // get the selected button using the tags, each button has a tag corresponding to the index
   UIButton * selectedButton = (UIButton *) sender;
   currentSelectedIndex = selectedButton.tag;
   
   [self switchBetweenViews];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
   
	UITouch *touch = [touches anyObject]; // get touch objects
	
   // check if the touch is for the appropiate view not any other view
	if ([touch view] == self.moveButton) {
		CGPoint location = [touch locationInView:self.touchContainerView];
      float leftCorner = location.x - (self.moveButton.frame.size.width/2) ;
      float rightCorner = location.x + (self.moveButton.frame.size.width/2) ;
      
      float xOffset = leftCorner;
      if(leftCorner< 0 )
         {
      // to prevent the moveButton View from being  moved outside the switches view frames
      // this will prevent from moving to outside from the left edge
         xOffset = leftCorner = 1 ;
         }
      if ( rightCorner>= self.touchContainerView.frame.size.width)
         {
            // to prevent the moveButton View form beign  moved outside the switches view frames
            xOffset  = rightCorner = self.touchContainerView.frame.size.width - self.moveButton.frame.size.width-1;
         }
      // set the frame of the moveButton view so its placed at the touch point
      // this will make it move along with the user finger movement on the screen
      self.moveButton.frame = CGRectMake(xOffset, 1, self.moveButton.frame.size.width, self.moveButton.frame.size.height);
      return;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
   
	UITouch *touch = [touches anyObject];// get touch objects
	
   // check if the touch is for the appropiate view not any other view
	
	if ([touch view] == moveButton) {
      
      // determine which button will be selected once the touch ends
      // to get the closest one :
      // calculate the intersection frame between the the moveButton view and each button
      // the largest width for the intersection will be for the closest button.
      // so we get the max intersection width and set the selectedIndex to the corresponding button
      CGRect firstRect = CGRectIntersection(self.moveButton.frame, self.firstButton.frame);
      CGRect secondRect = CGRectIntersection(self.moveButton.frame, self.secondButton.frame);
      CGRect thirdRect = CGRectIntersection(self.moveButton.frame, self.thirdButton.frame);
      
      float maxInterSect = firstRect.size.width;
      int selctedIndex = 0 ;
      if(secondRect.size.width > maxInterSect)
         {
         selctedIndex = 1;
         maxInterSect = secondRect.size.width;
         }
      if (thirdRect.size.width > maxInterSect)
         {
         selctedIndex = 2;
         maxInterSect = thirdRect.size.width;
         }
      
      currentSelectedIndex =selctedIndex ;
      
      // go to method to setup the view after the touch ends
      [self switchBetweenViews];
		return;
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
