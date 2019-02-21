//
//  CalagemTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "CalagemTable.h"
#import "CalagemNovaTable.h"
#import "CalagemCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>


@interface CalagemTable ()

@end

@implementation CalagemTable

@synthesize Calagem;


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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Apagar";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext * context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[Calagem objectAtIndex:indexPath.row]];
    }
    
    NSError * error = nil;
    if (![context save:&error]) {
        NSLog(@"Não foi possível deletar!");
        return;
    }
    
    [Calagem removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Calagem"];
    Calagem = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    [self.tableView reloadData];
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
    return Calagem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalagemCell *cell = (CalagemCell *)[tableView dequeueReusableCellWithIdentifier:@"CalagemCell"];
    
    NSManagedObject * calagem = [Calagem objectAtIndex:indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    cell.LbProprietario.text   = [calagem valueForKey:@"proprietario"];
    cell.Propriedade.text      = [calagem valueForKey:@"propriedade"];
  /*  cell.DataCalagem.text      = [calagem valueForKey:@"data"];
    cell.Amostra.text          = [calagem valueForKey:@"amostra"];
    cell.ResultadoCalagem.text = [NSString stringWithFormat:@"%@ (t/ha).",[formatter stringForObjectValue:[calagem valueForKey:@"resultado"]]];
    cell.LegendaResultado.text = [calagem valueForKey:@"legendaResultado"];
    
    NSString * ValorResultado = [calagem valueForKey:@"resultado"];
    
    double ValorResult = [ValorResultado doubleValue]; //[cell.ResultadoCalagem.text doubleValue];
    
    if (ValorResult > 0) {
        cell.ResultadoCalagem.textColor = [UIColor redColor];
        cell.LegendaResultado.textColor = [UIColor redColor];
    } else {
        cell.ResultadoCalagem.textColor = [UIColor blackColor];
        cell.LegendaResultado.textColor = [UIColor blackColor];
    }
   */
   
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"UpdateCalagem"]) {
        NSManagedObject * selectedCar = [Calagem objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        CalagemNovaTable * destViewController = segue.destinationViewController;
        destViewController.calagem = selectedCar;
        destViewController.title = @"Editar";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  

  //  CalagemNovaTable * detalhes = [[CalagemNovaTable alloc]init];
  //  [self.navigationController pushViewController:detalhes animated:YES];
  // CalagemNovaTable *EditarCalagem = [[CalagemNovaTable alloc] initWithWindowNibName:@"CalagemNovaTable"];
  // [controllerWindow showWindow:self];
    
}

@end
