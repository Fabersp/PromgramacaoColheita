//
//  NovoAgronomoViewController.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 18/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface NovoAgronomoViewController : UIViewController{
    int Id_Agronomo;
    NSString *Id_Max;
    sqlite3 * db;
    NSString * databasePath;
}

@property (nonatomic, retain) NSString * NomeAgronomo, * Crea, * Celular, * Telefone, *Id_Max;

@property (weak, nonatomic) IBOutlet UITextField *TxtAgronomo;
@property (weak, nonatomic) IBOutlet UITextField *TxtCrea;
@property (weak, nonatomic) IBOutlet UITextField *TxtTelefone;
@property (weak, nonatomic) IBOutlet UITextField *TxtCelular;

- (IBAction)Salvar:(id)sender;

-(void) GravarAgronomo;


@end
