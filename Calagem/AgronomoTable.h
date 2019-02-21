//
//  AgronomoTable.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 25/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <MessageUI/MessageUI.h>
#import "GADInterstitialDelegate.h"
#import "GADBannerViewDelegate.h"

@class GADBannerView, GADRequest;


@interface AgronomoTable : UITableViewController <GADBannerViewDelegate, GADInterstitialDelegate>{
   
}

@property (nonatomic, retain) NSMutableArray * Agronomos;

@property(nonatomic, strong) GADBannerView *adBanner;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingSpinner;


@end
