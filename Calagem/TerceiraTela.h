//
//  SecondViewController.h
//  Paraiso FM
//
//  Created by Fabricio Aguiar de Padua on 13/04/13.
//  Copyright (c) 2013 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>


@interface TerceiraTela : UIViewController <MFMailComposeViewControllerDelegate> {
    IBOutlet UIButton *Botao_Site;
    __weak IBOutlet UIButton *Contato;
    __weak IBOutlet UIButton *Contar_amigo;
    __weak IBOutlet UIButton *Comentario;

}

- (IBAction)Site:(id)sender;


@end
