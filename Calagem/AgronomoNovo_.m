//
//  NovoAgronomoViewController.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 18/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "NovoAgronomoViewController.h"
#import <sqlite3.h>
#import "AgronomoTableViewController.h"

@interface NovoAgronomoViewController ()

@end

@implementation NovoAgronomoViewController

@synthesize Id_Max = _Id_Max;

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
    [[UIBarButtonItem appearance]
     setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, -1000)
     forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

}

-(void)Set_DBPath:(NSString *)Path {
    databasePath = Path;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Salvar:(id)sender {
    
    [self GravarAgronomo];
    
    AgronomoTableViewController * objAgronomo = [[AgronomoTableViewController alloc]init];
    
    [objAgronomo carregarAgronomo];
}

-(void) GravarAgronomo {
    sqlite3_stmt *statement;
    @try {
        const char * dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            char *errmsg;
            sqlite3_exec(db, [[NSString stringWithFormat:@"insert into agronomo (nome, crea, telefone, celular) values ('%@', '%@', '%@', '%@')", _TxtAgronomo.text, _TxtCrea.text, _TxtTelefone.text, _TxtCelular.text] UTF8String], NULL, NULL, &errmsg);
        } else {
            NSLog(@"Ocorreu um erro com a abertura do banco.");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Problema com a praparação");
    }
    @finally {
        sqlite3_step(statement);
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }   
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
