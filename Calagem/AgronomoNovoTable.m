//
//  AgronomoNovoTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 25/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "AgronomoNovoTable.h"

#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-6439752646521747/3360842512"
#define simulador @"377d635157683106a48cd155a9d9bb8a"

@interface AgronomoNovoTable ()

@end

@implementation AgronomoNovoTable

@synthesize txtNome;
@synthesize txtCrea;
@synthesize txtTelefone;
@synthesize txtCelular;
@synthesize txtEmail;
@synthesize txtUF;
@synthesize Agronomo;  //obj context
@synthesize Agronomos; //arraymutable

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

    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Agronomo"];
    Agronomos = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    if ([Agronomos count] == 1)
    {
        Agronomo = [Agronomos objectAtIndex:0];
    
        [txtNome setText:[Agronomo valueForKey:@"nome"]];
        [txtCrea setText:[Agronomo valueForKey:@"crea"]];
        [txtUF setText:[Agronomo valueForKey:@"uf"]];
        [txtTelefone setText:[Agronomo valueForKey:@"telefone"]];
        [txtCelular setText:[Agronomo valueForKey:@"celular"]];
        [txtEmail setText:[Agronomo valueForKey:@"email"]];
    }
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    
    // Note: Edit SampleConstants.h to update kSampleAdUnitId with your interstitial ad unit id.
    self.interstitial.adUnitID = INTERSTITIAL_AD_UNIT_ID;
    [self.interstitial loadRequest:[self request]];
    [self.loadingSpinner startAnimating];
    
}

- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID, simulador, nil];
    return request;
}

#pragma mark GADBannerViewDelegate implementation

// We've received an ad successfully.


- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)dealloc {
    _interstitial.delegate = nil;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.loadingSpinner.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2,
                                             self.loadingSpinner.center.y);
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    // [self.loadingSpinner stopAnimating];
    
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.loadingSpinner stopAnimating];
    // Alert the error.
    
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

- (IBAction)btnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSalvar:(id)sender {
    if ([txtNome.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                               initWithTitle:@"Erro"
                               message:@"É necessário preencher o Nome!!"
                               delegate:nil cancelButtonTitle:nil
                               otherButtonTitles:@"ok", nil];
        [alert show];
    } else {
        NSManagedObjectContext * context = [self managedObjectContext];
        if (Agronomo) {
            // update novo agronomo
            [Agronomo setValue:txtNome.text forKey:@"nome"];
            [Agronomo setValue:txtCrea.text forKey:@"crea"];
            [Agronomo setValue:txtUF.text forKey:@"uf"];
            [Agronomo setValue:txtTelefone.text forKey:@"telefone"];
            [Agronomo setValue:txtCelular.text forKey:@"celular"];
            [Agronomo setValue:txtEmail.text forKey:@"email"];
        } else {
            //criar novo agronomo
            NSManagedObject * novoAgronomo = [NSEntityDescription insertNewObjectForEntityForName:@"Agronomo" inManagedObjectContext:context];
            [novoAgronomo setValue:txtNome.text forKey:@"nome"];
            [novoAgronomo setValue:txtCrea.text forKey:@"crea"];
            [novoAgronomo setValue:txtUF.text forKey:@"uf"];
            [novoAgronomo setValue:txtTelefone.text forKey:@"telefone"];
            [novoAgronomo setValue:txtCelular.text forKey:@"celular"];
            [novoAgronomo setValue:txtEmail.text forKey:@"email"];
        }
        
        NSError * error = nil;
        if (![context save:&error]) {
            //  NSLog(@"Falha ao salvar!", error, [error localizedDescription]);
        }
        [self.interstitial presentFromRootViewController:self];

        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
