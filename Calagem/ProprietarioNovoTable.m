//
//  ProprietarioNovoTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 25/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "ProprietarioNovoTable.h"

#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-6439752646521747/3360842512"
#define simulador @"377d635157683106a48cd155a9d9bb8a"

@interface ProprietarioNovoTable ()

@end

@implementation ProprietarioNovoTable

@synthesize txtPropriedade;
@synthesize txtProprietario;
@synthesize txtEndereco;
@synthesize txtCidade;
@synthesize txtTelefone;
@synthesize txtCelular;
@synthesize txtEmail;
@synthesize Proprietario;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (Proprietario){
        [txtProprietario setText:[Proprietario valueForKey:@"nomeProprietario"]];
        [txtPropriedade setText:[Proprietario valueForKey:@"Propriedade"]];
        [txtEndereco setText:[Proprietario valueForKey:@"endereco"]];
        [txtCidade setText:[Proprietario valueForKey:@"cidade"]];
        [txtTelefone setText:[Proprietario valueForKey:@"telefone"]];
        [txtCelular setText:[Proprietario valueForKey:@"celular"]];
        [txtEmail setText:[Proprietario valueForKey:@"email"]];
    }
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    
    // Note: Edit SampleConstants.h to update kSampleAdUnitId with your interstitial ad unit id.
    self.interstitial.adUnitID = INTERSTITIAL_AD_UNIT_ID;
    [self.interstitial loadRequest:[self request]];
    [self.loadingSpinner startAnimating];
}

- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID, simulador, nil];
    return request;
}

#pragma mark GADBannerViewDelegate implementation

// We've received an ad successfully.


- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)dealloc {
    _interstitial.delegate = nil;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.loadingSpinner.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2,
                                             self.loadingSpinner.center.y);
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    // [self.loadingSpinner stopAnimating];
    
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.loadingSpinner stopAnimating];
    // Alert the error.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)btnSalvar:(id)sender {
    if ([txtProprietario.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Erro"
                              message:@"É necessário preencher o Proprietário e a Propriedade!"
                              delegate:nil cancelButtonTitle:nil
                              otherButtonTitles:@"ok", nil];
        [alert show];
    } else {
        NSManagedObjectContext * context = [self managedObjectContext];
        if (Proprietario) {
            // update novo agronomo
            [Proprietario setValue:txtProprietario.text forKey:@"nomeProprietario"];
            [Proprietario setValue:txtPropriedade.text forKey:@"propriedade"];
            [Proprietario setValue:txtEndereco.text forKey:@"endereco"];
            [Proprietario setValue:txtCidade.text forKey:@"cidade"];
            [Proprietario setValue:txtTelefone.text forKey:@"telefone"];
            [Proprietario setValue:txtCelular.text forKey:@"celular"];
            [Proprietario setValue:txtEmail.text forKey:@"email"];
        } else {
            //criar novo agronomo
            NSManagedObject * novoProprietario = [NSEntityDescription insertNewObjectForEntityForName:@"Proprietario" inManagedObjectContext:context];
            [novoProprietario setValue:txtProprietario.text forKey:@"nomeProprietario"];
            [novoProprietario setValue:txtPropriedade.text forKey:@"propriedade"];
            [novoProprietario setValue:txtEndereco.text forKey:@"endereco"];
            [novoProprietario setValue:txtCidade.text forKey:@"cidade"];
            [novoProprietario setValue:txtTelefone.text forKey:@"telefone"];
            [novoProprietario setValue:txtCelular.text forKey:@"celular"];
            [novoProprietario setValue:txtEmail.text forKey:@"email"];
        }
        
        NSError * error = nil;
        if (![context save:&error]) {
            //  NSLog(@"Falha ao salvar!", error, [error localizedDescription]);
        }
        [self.interstitial presentFromRootViewController:self];

        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext * context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)btnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
