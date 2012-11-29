//
//  ViewController.m
//  HUDDemoApp
//
//  Created by Marin Todorov on 29/11/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "ViewController.h"

#import "HUD.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)actionShowTimed:(id)sender
{
    [HUD showUIBlockingIndicator];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
}

-(IBAction)actionCustomText:(id)sender
{
    [HUD showUIBlockingIndicatorWithText:@"Custom text!"];
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
}

-(IBAction)actionWithTimeout:(id)sender
{
    [HUD showUIBlockingIndicatorWithText:@"Will timeout in 2 secs!" withTimeout:2.0];
}

static float prog = 0;
static MBProgressHUD* hud = nil;

-(IBAction)actionWithProgress:(id)sender
{
    prog = 0;
    hud = [HUD showUIBlockingProgressIndicatorWithText:@"Progressing" andProgress:prog];
    
    [self doProgress];
}

-(void)doProgress
{
    prog +=2;
    hud.progress = prog/100;
    hud.labelText = [NSString stringWithFormat:@"Done %.f %%", prog];
    [hud setNeedsDisplay];
    
    if (prog < 100) {
        [self performSelector:@selector(doProgress) withObject:nil afterDelay:0.1];
    } else {
        [HUD hideUIBlockingIndicator];
    }
}

-(IBAction)actionShowAlert:(id)sender
{
    [HUD showAlertWithTitle:@"Alert box" text:@"Yupeee!"];
}

-(IBAction)actionShowModal:(id)sender
{
    [HUD showAlertWithTitle:@"An alert box!" text:@"Yupeee! Press the checkmark to close it whenever you're done reading the text!" target:self action:@selector(closed)];
}

-(void)closed
{
    [HUD hideUIBlockingIndicator];
    [HUD showUIBlockingIndicatorWithText:@"You've closed the alert box." withTimeout:2.0];
}

-(void)hideHUD
{
    [HUD hideUIBlockingIndicator];
}

@end
