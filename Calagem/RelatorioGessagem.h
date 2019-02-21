//
//  CalagemTable.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

#import <MessageUI/MessageUI.h>
#import "GADInterstitialDelegate.h"
#import "GADBannerViewDelegate.h"

@class GADBannerView, GADRequest;


@interface RelatorioGessagem : UITableViewController <MFMailComposeViewControllerDelegate,GADBannerViewDelegate, GADInterstitialDelegate> {
    NSString *strProprietario;
    NSString *strPropriedade;
    
}
@property (nonatomic, retain) NSString * strProprietario, *strPropriedade;
@property (nonatomic, retain) NSMutableArray * Variedade;
@property (strong) NSManagedObject * Agronomo;
@property (nonatomic, retain) NSMutableArray * Agronomos;

@property (strong) NSManagedObject * ProprietarioProprietario;

@property (strong) NSManagedObject * VariedadeObj;
@property (nonatomic, retain) NSMutableArray * VariedadesArray;

@property(nonatomic, strong) GADBannerView *adBanner;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingSpinner;



@end
