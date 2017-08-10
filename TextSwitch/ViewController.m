//
//  ViewController.m
//  TextSwitch
//
//  Created by Vasily Popov on 8/10/17.
//  Copyright © 2017 Vasily Popov. All rights reserved.
//

#import "ViewController.h"
#import "UITextSwitch.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextSwitch) NSArray *switchCollection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchPressed:(id)sender {
    
    UITextSwitch *item = sender;
    [item setOn:!item.isOn animated:YES];
}

@end
