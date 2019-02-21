//
//  ProprietarioNovoTable.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 25/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GADInterstitialDelegate.h"
#import "GADBannerViewDelegate.h"

@class GADBannerView, GADRequest;

@interface ProprietarioNovoTable : UITableViewController <GADBannerViewDelegate, GADInterstitialDelegate>

@property (strong) NSManagedObject * Proprietario;

@property (weak, nonatomic) IBOutlet UITextField *txtProprietario;
@property (weak, nonatomic) IBOutlet UITextField *txtPropriedade;
@property (weak, nonatomic) IBOutlet UITextField *txtEndereco;
@property (weak, nonatomic) IBOutlet UITextField *txtCidade;
@property (weak, nonatomic) IBOutlet UITextField *txtTelefone;
@property (weak, nonatomic) IBOutlet UITextField *txtCelular;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;


@property(nonatomic, strong) GADBannerView *adBanner;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingSpinner;



@end
