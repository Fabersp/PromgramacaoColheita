//
//  SecondViewController.m
//  Paraiso FM
//
//  Created by Fabricio Aguiar de Padua on 13/04/13.
//  Copyright (c) 2013 Pro Master Solution. All rights reserved.
//

#import "TerceiraTela.h"
#import <sys/utsname.h>




@interface TerceiraTela ()

@end

@implementation TerceiraTela

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Contato.layer.cornerRadius = 10.0f;
    Contato.layer.masksToBounds = YES;
    
    Contar_amigo.layer.cornerRadius = 10.0f;
    Contar_amigo.layer.masksToBounds = YES;
    
    Comentario.layer.cornerRadius = 10.0f;
    Comentario.layer.masksToBounds = YES;
    
   // self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Fundo~iphone.png"]];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)Sugestoes:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App Colheita"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"fabricio_0505_@hotmail.com", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)ContarAmigo:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"App Programação da Colheita"];
        
        NSString *emailBody = @"Olá,\n\n Estou utilizando o App para Programação da Colheita, ele está disponível para download. \n\n Baixe ele na Itunes.  http://goo.gl/pFJm4I";
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}








@end
