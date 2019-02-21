//
//  AgronomoTableViewController.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 14/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "AgronomoTableViewController.h"


@interface AgronomoTableViewController ()

@end

@implementation AgronomoTableViewController

@synthesize Agonomo;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //***** botão esquerdo ***** ///
    UIBarButtonItem *editButton = self.editButtonItem;
    editButton.title = @"Editar";
    editButton.tintColor = [UIColor whiteColor];
    [editButton setTarget:self];
    [editButton setAction:@selector(toggleEdit)];
    self.navigationItem.leftBarButtonItem = editButton;
    
    // ***** Botão direito **** //
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void) criarBancoTabelas{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"calagem.sqlite"]];
    
    NSLog(@"databaseTable: %@", databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath] == NO)
    {
        const char * dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            char *errMsg;
            const char * sql_Agronomo = "CREATE TABLE IF NOT EXISTS AGRONOMO (ID_AGRONOMO INTEGER PRIMARY KEY AUTOINCREMENT, NOME TEXT, CREA, TELEFONE TEXT, CELULAR TEXT)";
            
            if (sqlite3_exec(db, sql_Agronomo, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table agronomo");
            }
            
            const char * sql_insertAgronomo = "insert into agronomo (nome, crea, telefone, celular) values ('Fabricio', '11XX', '1132340', '2334')";
            if (sqlite3_exec(db, sql_insertAgronomo, NULL, NULL, &errMsg) != SQLITE_OK){
                NSLog(@"Failed to INSERT table agronomo");
            }
            const char * sqlProprietario = "CREATE TABLE IF NOT EXISTS PROPRIETARIO (ID_PROPRIETARIO INTEGER PRIMARY KEY AUTOINCREMENT, PROPRIETARIO TEXT, PROPRIEDADE TEXT, TELEFONE TEXT, CELULAR TEXT, ENDERECO TEXT, CIDADE TEXT, UF TEXT)";
            
            if (sqlite3_exec(db, sqlProprietario, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table PROPRIETARIO");
            }
            
            const char * sql_insertproprietario = "insert into PROPRIETARIO (PROPRIETARIO, PROPRIEDADE, TELEFONE, CELULAR, ENDERECO, CIDADE, UF) values ('COOPARAISO', 'FAZENDA ITAGUABA', '35-3558-4949', '35-3558-4949', 'RODOVIA MG 050 KM 345', 'SÃO SEB. PARAISO', 'MG')";
            if (sqlite3_exec(db, sql_insertproprietario, NULL, NULL, &errMsg) != SQLITE_OK){
                NSLog(@"Failed to INSERT table PROPRIETARIO");
            }

            
            sqlite3_close(db);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
}


- (IBAction)toggleEdit {
    BOOL editing = !self.tableView.editing;
    self.navigationItem.rightBarButtonItem.enabled = !editing;
    if (editing) {
        self.navigationItem.leftBarButtonItem.title = @"Ok";
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
    }
    else{
        self.navigationItem.leftBarButtonItem.title = @"Editar";
        //Added in the edition for this button has the same color of the UIBarButtonSystemItemDone
        self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStylePlain;
    }
    [self.tableView setEditing:editing animated:YES];
}

-(void)carregarAgronomo {
   
    _Lista_NomeAgronomo = [[NSMutableArray alloc] init];
    _Lista_Crea         = [[NSMutableArray alloc] init];
    _id_agronomo        = [[NSMutableArray alloc] init];
    _Lista_Telefone     = [[NSMutableArray alloc] init];
    _Lista_Celular      = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    @try {
        const char * dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            const char * Query = "select * from agronomo ";
            if (sqlite3_prepare_v2(db, Query, -1, &statement, NULL) != SQLITE_OK) {
                NSLog(@"Problema com a preparação Statement. (%s)", sqlite3_errmsg(db));
            } else {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    [_id_agronomo addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                    [_Lista_NomeAgronomo addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)]];
                    [_Lista_Crea addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                    [_Lista_Telefone addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
                    [_Lista_Celular addObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)]];
                }
            }
        } else {
             NSLog(@"Ocorreu um erro com a abertura do banco");
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


-(NSString *) DeletarAgronomo:(NSString *) Id_Agronomo {
    sqlite3_stmt * statement;
    @try {
        const char * dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            NSString * sqlStatement = [NSString stringWithFormat:@"DELETE FROM AGRONOMO WHERE ID_AGRONOMO ='%@'", Id_Agronomo];
            
            if( sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &statement, NULL) == SQLITE_OK )
            {
                if( sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog( @"Item with url: %@ was deleted", Id_Agronomo);
                }
                else
                {
                    NSLog( @"DeleteFromDataBase: Failed from sqlite3_step. Error is:  %s", sqlite3_errmsg(db));
                }
            }
            else
            {
                NSLog( @"DeleteFromDataBase: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(db));
            }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _Lista_NomeAgronomo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    // Set up the cell...
    NSString *Title = [_Lista_NomeAgronomo objectAtIndex:indexPath.row];
    cell.textLabel.text = Title;
    NSString *SubTitle = [_Lista_Crea objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Registro Crea: %@", SubTitle];
    return cell;
}


-(void)viewWillAppear:(BOOL)animated {
    [self carregarAgronomo];
    [self.tableView reloadData];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Apagar";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
   // [AgronomoTableViewController setEditing:editing animated:animated];
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Index_Agronomo = _id_agronomo[indexPath.row];
        
        [_Lista_NomeAgronomo removeObjectAtIndex:indexPath.row];
        [_id_agronomo removeObjectAtIndex:indexPath.row];
        
        [self DeletarAgronomo:Index_Agronomo];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segue_editar"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        idxAgronomo = [_id_agronomo[indexPath.row] integerValue];
        [[segue destinationViewController] Set_Agronomo:idxAgronomo];
        [[segue destinationViewController] Set_DBPath:databasePath];
    }
    if ([[segue identifier] isEqualToString:@"segue_novo"]) {
        [[segue destinationViewController] Set_DBPath:databasePath];
    }

    
    
}
















@end
