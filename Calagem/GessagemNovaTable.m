//
//  CalagemNovaTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "GessagemNovaTable.h"
#import "BuscarProprietarioTable.h"

#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-6439752646521747/3360842512"
#define simulador @"377d635157683106a48cd155a9d9bb8a"

#define N 0
#define P2O5 60
#define K2O 40


@interface GessagemNovaTable () <RMDateSelectionViewControllerDelegate, RMPickerViewControllerDelegate>

@end

@implementation GessagemNovaTable

@synthesize txtProprietario;
@synthesize txtPropriedade;

@synthesize listaSelect;

@synthesize colheita;
@synthesize ValorFinal = _ValorFinal;
@synthesize txtLote;
@synthesize txtVariedade;
@synthesize txtDataPlantio;
@synthesize txtDataprevista;
@synthesize txtDiaAtraso;
@synthesize txtCiclo;
@synthesize VarDataPrevista;
@synthesize StrDataPrevista;


@synthesize selectedIndexPath = _selectedIndexPath;


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
    
    if (colheita){
        
        [txtProprietario setText:[colheita valueForKey:@"proprietario"]];
        [txtPropriedade  setText:[colheita valueForKey:@"propriedade"]];
        [txtLote         setText:[colheita valueForKey:@"lote"]];
        [txtVariedade    setText:[colheita valueForKey:@"variedade"]];
        [txtDataPlantio  setText:[colheita valueForKey:@"dataPlantio"]];
        [txtDiaAtraso    setText:[colheita valueForKey:@"diasAtraso"]];
        [txtCiclo        setText:[colheita valueForKey:@"diasCiclo"]];
        [txtDataprevista setText:[colheita valueForKey:@"dataPrevistaStr"]];

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
     [self.loadingSpinner stopAnimating];
    
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.loadingSpinner stopAnimating];
    // Alert the error.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCalendario:(id)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    
    //You can enable or disable bouncing and motion effects
    //dateSelectionVC.disableBouncingWhenShowing = YES;
    //dateSelectionVC.disableMotionEffects = YES;
    
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create
        
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
        
        NSString *convertedString = [dateFormatter stringFromDate:aDate];
        
      //  NSLog(@"Converted String : %@",convertedString);
        
        txtDataPlantio.text = convertedString;
        
      //  NSLog(@"Successfully selected date: %@ (With block)", aDate);
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        NSLog(@"Date selection was canceled (with block)");
    }];
    
    //You can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.calendar = [NSCalendar currentCalendar];
}

-(void)viewDidAppear:(BOOL)animated{
   
}

#pragma mark - RMPickerViewController Delegates
- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    //NSLog(@"Successfully selected rows: %@", selectedRows);
    
   
}

- (IBAction)Voltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)Salvar:(id)sender {
    [self Calcular];
    if ([txtProprietario.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Erro"
                              message:@"É necessário preencher o Nome!!"
                              delegate:nil cancelButtonTitle:nil
                              otherButtonTitles:@"ok", nil];
        [alert show];
    } else {
        NSManagedObjectContext * context = [self managedObjectContext];
        
        if (colheita) {
            // update calagem
            [colheita setValue:txtProprietario.text forKey:@"proprietario"];
            [colheita setValue:txtPropriedade.text  forKey:@"propriedade"];
            [colheita setValue:txtLote.text         forKey:@"lote"];
            [colheita setValue:txtVariedade.text    forKey:@"variedade"];
            [colheita setValue:txtDataPlantio.text  forKey:@"dataPlantio"];
            
            if ([txtDiaAtraso.text isEqualToString:@""]){
                txtDiaAtraso.text = @"0";
            }
            if ([txtCiclo.text isEqualToString:@""]){
                txtCiclo.text = @"0";
            }
            
            [colheita setValue:txtCiclo.text        forKey:@"diasCiclo"];
            [colheita setValue:txtDiaAtraso.text    forKey:@"diasAtraso"];
            
            //Converter String para Data//
            NSString *dateString = txtDataprevista.text;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [formatter setDateStyle:NSDateFormatterShortStyle];
            NSDate *dateFromString = [NSDate date];
            
           // NSDate *dateFromString = [[NSDate alloc] init];
            
            dateFromString = [formatter dateFromString:dateString];
            // Termina a conversao //
            
            NSLog(@"Data data: %@",dateFromString);
            
            [colheita setValue:dateFromString forKey:@"dataPrevista"];
            
            [colheita setValue:txtDataprevista.text forKey:@"dataPrevistaStr"];
            
        } else {
            //criar nova calagem
            NSManagedObject * novaColheita = [NSEntityDescription insertNewObjectForEntityForName:@"Colheita" inManagedObjectContext:context];
            
            [novaColheita setValue:txtProprietario.text forKey:@"proprietario"];
            [novaColheita setValue:txtPropriedade.text  forKey:@"propriedade"];
            [novaColheita setValue:txtLote.text         forKey:@"lote"];
            [novaColheita setValue:txtVariedade.text    forKey:@"variedade"];
            [novaColheita setValue:txtDataPlantio.text  forKey:@"dataPlantio"];
            
            if ([txtDiaAtraso.text isEqualToString:@""]){
                txtDiaAtraso.text = @"0";
            }
            if ([txtCiclo.text isEqualToString:@""]){
                txtCiclo.text = @"0";
            }

            [novaColheita setValue:txtDiaAtraso.text    forKey:@"diasAtraso"];
            [novaColheita setValue:txtCiclo.text        forKey:@"diasCiclo"];
            
            NSString *dateString = txtDataprevista.text;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            dateFromString = [dateFormatter dateFromString:dateString];
            // Termina a conversao //
            
            [novaColheita setValue:dateFromString forKey:@"dataPrevista"];
            
            [novaColheita setValue:txtDataprevista.text forKey:@"dataPrevistaStr"];
        }
        
        NSError * error = nil;
        if (![context save:&error]) {
            //  NSLog(@"Falha ao salvar!", error, [error localizedDescription]);
        }
        [self.interstitial presentFromRootViewController:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pickerViewControllerDidCancel:(RMPickerViewController *)vc {
    NSLog(@"Selection was canceled");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return listaSelect.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *attString = [[NSString alloc] initWithString:[listaSelect objectAtIndex:row]];
    return attString;
    // return [NSString stringWithFormat:@"Row %lu", (long)row];
}

- (IBAction)btnCalcular:(id)sender {
    [self Calcular];
}

- (void) Calcular {
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataPlantio = [dateFormat dateFromString:txtDataPlantio.text];
    
    NSInteger diasCiclo = [txtCiclo.text integerValue];
    
    if ([txtDiaAtraso.text isEqualToString:@""]){
        txtDiaAtraso.text = @"0";
    }
    
    NSInteger diasAtraso = [txtDiaAtraso.text integerValue];

    NSInteger diasPlantio = diasCiclo + diasAtraso;
    
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setDay:diasPlantio];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate * dataColheita = [[NSDate alloc]init];
    
    dataColheita = [calendar dateByAddingComponents:components toDate:dataPlantio options:0];
    
    NSString *convertedString = [dateFormat stringFromDate:dataColheita];

    txtDataprevista.text = convertedString;
    
  //  NSLog(@"Data colheita: %@", convertedString);
    
    
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtLote         resignFirstResponder];
    [txtVariedade    resignFirstResponder];
    [txtDataPlantio  resignFirstResponder];
    [txtDataprevista resignFirstResponder];
    [txtVariedade    resignFirstResponder];
    [txtDiaAtraso    resignFirstResponder];
    [txtCiclo        resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [txtLote         resignFirstResponder];
    [txtVariedade    resignFirstResponder];
    [txtDataPlantio  resignFirstResponder];
    [txtDataprevista resignFirstResponder];
    [txtVariedade    resignFirstResponder];
    [txtDiaAtraso    resignFirstResponder];
    [txtCiclo        resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"buscarProprietario"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.textoProprietario = txtProprietario;
        destViewController.textoPropriedade = txtPropriedade;
    }
}

@end
