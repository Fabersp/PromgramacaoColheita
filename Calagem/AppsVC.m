//
//  AppsVC.m
//  AppDoAgronomo
//
//  Created by Fabricio Aguiar de Padua on 07/08/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "AppsVC.h"

@interface AppsVC ()

@end

@implementation AppsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BtnAppColheita:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/programacao-da-colheita/id936528031?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}
- (IBAction)BtnAdubacao:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/soja/id924713049?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

- (IBAction)BtnGessagemCalagem:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/gessagem-calagem/id922285748?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

- (IBAction)BtnTemperatura:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/temperature-converter-2/id882262472?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

- (IBAction)BtnCalagem:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/calagem/id887326016?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

- (IBAction)BtnConversor:(id)sender {
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/conversor-agrario/id907981355?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
