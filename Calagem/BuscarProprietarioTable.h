//
//  BuscarProprietarioTable.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 28/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitialDelegate.h"
#import "GADBannerViewDelegate.h"

@class GADBannerView, GADRequest;



@interface BuscarProprietarioTable : UITableViewController <GADBannerViewDelegate, GADInterstitialDelegate> {
    
    NSIndexPath * SelecionadoIndex;
    UITextField * textoProprietario;
    UITextField * textoPropriedade;
    UITextField * textoEndereco;
    UITextField * textoCidade;
    UITextField * textoTelefone;
    UITextField * textoCelular;
    UITextField * textoEmail;

}

@property (nonatomic, retain) NSMutableArray * proprietario;

@property (nonatomic, retain) UITextField * textoProprietario;
@property (nonatomic, retain) UITextField * textoPropriedade;
@property (nonatomic, retain) UITextField * textoEndereco;
@property (nonatomic, retain) UITextField * textoCidade;
@property (nonatomic, retain) UITextField * textoTelefone;
@property (nonatomic, retain) UITextField * textoCelular;
@property (nonatomic, retain) UITextField * textoEmail;

@property(nonatomic, strong) GADBannerView *adBanner;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingSpinner;

@end
