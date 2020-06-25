//
//  ViewController.m
//  Tip Calculator
//
//  Created by chad franklin on 6/24/20.
//  Copyright © 2020 chad franklin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;


@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"main view did load");
    
    NSInteger defaultTipIndex = [self getDefaultTipUserDefault];
    
    self.tipControl.selectedSegmentIndex = defaultTipIndex;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"main view will appear");
    
    BOOL darkModeOn = [self getDarkModeUserDefault];
    
    [self darkModeUIUpdate:darkModeOn];
    
    
}

- (IBAction)onTap:(id)sender {
    // NSLog(@"Hello");
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    [self calculateAndDisplayTip];
}

- (void)calculateAndDisplayTip {
    double bill = [self.billField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}








- (void)darkModeUIUpdate:(BOOL)on{
    if(on){
        self.mainView.backgroundColor = UIColor.darkGrayColor;
    } else {
        self.mainView.backgroundColor = UIColor.systemBackgroundColor;
    }
}

- (bool)getDarkModeUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL darkModeOn = [defaults boolForKey:@"default_dark_mode"];
    
    return darkModeOn;
}



- (NSInteger)getDefaultTipUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tipIndex = [defaults integerForKey:@"default_tip_index"];
    
    return tipIndex;
}

@end
