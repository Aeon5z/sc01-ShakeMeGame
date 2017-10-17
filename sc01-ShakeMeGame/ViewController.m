//
//  ViewController.m
//  sc01-ShakeMeGame
//
//  Created by user on 10/2/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int     counter;
    int     score;
    int     gameMode; // 1 - BeingPlayed
                      // 2 - Game Over
}
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblHint;
@property (weak, nonatomic) IBOutlet UISlider *sliderTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    score = 0;
    self.sliderTimer.value = 30;
    self.lblTimer.text = @"30";
    counter = self.sliderTimer.value;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self selector:@selector(orientaionChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)timerChange:(id)sender {
    counter = (int)self.sliderTimer.value;
    self.lblTimer.text = [NSString stringWithFormat:@"%i", (int)self.sliderTimer.value];
}

- (IBAction)startGamePressed:(id)sender {
    if (score == 0) {
        gameMode = 1; // we started the game
        self.lblHint.text = @" ";
        self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
        // create a timer
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                               selector:@selector(startCounter)
                                               userInfo:nil repeats:YES];
        self.btnStart.enabled = NO;
        self.sliderTimer.enabled = NO;
        
        if (counter == 0) {
            score = 0;
            counter = self.sliderTimer.value;
           
           
            self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
            self.lblScore.text = [NSString stringWithFormat:@"%i", score];
            
            
            
        }
    }
    
    
    
}

-(void)startCounter {
   // decrement the counter
    counter -= 1;
    
    self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
    
    if (counter == 0){
        [timer invalidate];
        gameMode =2;        // game is opver
        
        // toggle the start button to "Restart", enable it
        [self.btnStart setTitle:@"Restart" forState:UIControlStateNormal];
        self.btnStart.enabled = YES;
        self.sliderTimer.enabled = YES;
    }
    
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(event.subtype == UIEventSubtypeMotionShake  ) {
        if(gameMode == 1 ){
            // increment the score
            score += 1;
            
            // display
            self.lblScore.text = [NSString stringWithFormat:@"%i", score];
        }
    }
}

-(void)orientaionChanged: (NSNotification *)note{
    if(gameMode ==1){
        score++;
        self.lblScore.text = [NSString stringWithFormat:@"%i", score];
        
    }
}
















@end
