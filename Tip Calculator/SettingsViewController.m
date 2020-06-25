//
//  SettingsViewController.m
//  Tip Calculator
//
//  Created by chad franklin on 6/24/20.
//  Copyright © 2020 chad franklin. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;


@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISwitch *darkModeSwitch;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"Settings view will appear");
    
    BOOL darkModeOn = [self getDarkModeUserDefault];
    
    self.darkModeSwitch.on = darkModeOn;
    [self darkModeUIUpdate:darkModeOn];
    
    NSInteger defaultTipIndex = [self getDefaultTipUserDefault];
    
    self.defaultTipControl.selectedSegmentIndex = defaultTipIndex;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onDarkModeChanged:(id)sender {
    
    BOOL on = self.darkModeSwitch.on;
    
    [self setDarkModeUserDefault:on];
    [self darkModeUIUpdate:on];
}

- (IBAction)onDefaultTipControlChanged:(id)sender {
    [self setDefaultTipUserDefault:self.defaultTipControl.selectedSegmentIndex];
}


// figure out if it's possible to change all of the text to white instead of changing each label independently
- (void)darkModeUIUpdate:(BOOL)on{
    if(on){
        self.mainView.backgroundColor = UIColor.darkGrayColor;
    } else {
        self.mainView.backgroundColor = UIColor.systemBackgroundColor;
    }
}


// if key doesn't exist, will return false
- (bool)getDarkModeUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL darkModeOn = [defaults boolForKey:@"default_dark_mode"];
    
    return darkModeOn;
}

- (void)setDarkModeUserDefault:(BOOL)on{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:on forKey:@"default_dark_mode"];
    [defaults synchronize];
}


- (NSInteger)getDefaultTipUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tipIndex = [defaults integerForKey:@"default_tip_index"];
    
    return tipIndex;
}

- (void)setDefaultTipUserDefault:(NSInteger)index{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:index forKey:@"default_tip_index"];
    [defaults synchronize];
}


@end
