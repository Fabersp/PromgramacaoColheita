//
//  CalagemNovaTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "CalagemNovaTable.h"
#import "BuscarProprietarioTable.h"


@interface CalagemNovaTable () <RMDateSelectionViewControllerDelegate, RMPickerViewControllerDelegate>

@end

@implementation CalagemNovaTable

@synthesize txtProprietario;
@synthesize txtPropriedade;
@synthesize txtSolo;
@synthesize txtCultivo;
@synthesize txtData;
@synthesize txtPrnt;
@synthesize txtElementok;
@synthesize txtElementoCa;
@synthesize txtElementoMg;
@synthesize txtElementoHAL;
@synthesize listaSelect;
@synthesize LbResultadoV2;
@synthesize txtAmostra;
@synthesize txtResultadoSB;
@synthesize txtResultadoCTC;
@synthesize txtResultadoV1;
@synthesize LbResultadoFinal;
@synthesize calagem;
@synthesize ValorFinal = _ValorFinal;
@synthesize LbLegendaResultado;
@synthesize endereco;
@synthesize cidade;
@synthesize telefone;
@synthesize celular;
@synthesize email;
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
    
    if (calagem){
        [txtProprietario setText:[calagem valueForKey:@"proprietario"]];
        [txtPropriedade setText:[calagem valueForKey:@"propriedade"]];
        [txtSolo setText:[calagem valueForKey:@"solo"]];
        [txtCultivo setText:[calagem valueForKey:@"cultivo"]];
        [txtData setText:[calagem valueForKey:@"data"]];
        [txtAmostra setText:[calagem valueForKey:@"amostra"]];
        [LbLegendaResultado setText:[calagem valueForKey:@"legendaResultado"]];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSString * ValorV2     = [formatter stringForObjectValue:[calagem valueForKey:@"v2"]];
        NSString * ValorPrnt   = [formatter stringForObjectValue:[calagem valueForKey:@"prnt"]];
        NSString * ValorK      = [formatter stringForObjectValue:[calagem valueForKey:@"k"]];
        NSString * ValorCa     = [formatter stringForObjectValue:[calagem valueForKey:@"ca"]];
        NSString * ValorHAL    = [formatter stringForObjectValue:[calagem valueForKey:@"hal"]];
        NSString * ValorMg     = [formatter stringForObjectValue:[calagem valueForKey:@"mg"]];
        NSString * ValorSB     = [formatter stringForObjectValue:[calagem valueForKey:@"sb"]];
        NSString * ValorCTB    = [formatter stringForObjectValue:[calagem valueForKey:@"ctcph"]];
        NSString * ValorV1     = [formatter stringForObjectValue:[calagem valueForKey:@"v1"]];
        NSString * ResultadoFinal = [formatter stringForObjectValue:[calagem valueForKey:@"resultado"]];
        
        [LbResultadoV2    setText:[ValorV2   stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtPrnt          setText:[ValorPrnt stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtElementok     setText:[ValorK    stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtElementoCa    setText:[ValorCa   stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtElementoHAL   setText:[ValorHAL  stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtElementoMg    setText:[ValorMg   stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtResultadoSB   setText:[ValorSB   stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtResultadoCTC  setText:[ValorCTB  stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [txtResultadoV1   setText:[ValorV1   stringByReplacingOccurrencesOfString:@"." withString:@","]];
        [LbResultadoFinal setText:[NSString  stringWithFormat:@"%@ (t/ha)", [ResultadoFinal stringByReplacingOccurrencesOfString:@"." withString:@","]]];
    }
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
        NSLog(@"Converted String : %@",convertedString);
        
        txtData.text = convertedString;
        
        NSLog(@"Successfully selected date: %@ (With block)", aDate);
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        NSLog(@"Date selection was canceled (with block)");
    }];
    
    //You can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.calendar = [NSCalendar currentCalendar];
}

-(void)viewDidAppear:(BOOL)animated{
   
    
}


- (IBAction)btnPesquisarSolo:(id)sender {
    listaSelect = [[NSMutableArray alloc] init];
    [listaSelect addObject:@"Arenoso"];
    [listaSelect addObject:@"Argiloso"];
    
    RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
    pickerVC.delegate = self;
    
    //You can enable or disable bouncing and motion effects
    //pickerVC.disableBouncingWhenShowing = YES;
    //pickerVC.disableMotionEffects = YES;
    
    [pickerVC showWithSelectionHandler:^(RMPickerViewController *vc, NSArray *selectedRows) {
        
        NSString * result = [[selectedRows valueForKey:@"description"] componentsJoinedByString:@""];
        
        if ([result isEqualToString:@"0"]) {
            txtSolo.text = @"Arenoso";
        }
        if ([result isEqualToString:@"1"]) {
            txtSolo.text = @"Argiloso";
        }
        [self CalcularV2:txtSolo.text ValorCultivo:txtCultivo.text];
        
        NSLog(@"mm,m: %@ ", selectedRows.description);
    } andCancelHandler:^(RMPickerViewController *vc) {
        NSLog(@"Selection was canceled (with block)");
    }];
}

#pragma mark - RMPickerViewController Delegates
- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    //NSLog(@"Successfully selected rows: %@", selectedRows);
    
   
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
        
        if (calagem) {
            // update calagem
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            
            NSNumber * ValorV2        = [f numberFromString:[LbResultadoV2.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorPrnt      = [f numberFromString:[txtPrnt.text  stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorK         = [f numberFromString:[txtElementok.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorCa        = [f numberFromString:[txtElementoCa.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorHAL       = [f numberFromString:[txtElementoHAL.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorMg        = [f numberFromString:[txtElementoMg.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorSB        = [f numberFromString:[txtResultadoSB.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorCTB       = [f numberFromString:[txtResultadoCTC.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ValorV1        = [f numberFromString:[txtResultadoV1.text stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            NSNumber * ResultadoFinal = [f numberFromString:[_ValorFinal stringByReplacingOccurrencesOfString:@"." withString:@"."]];
            
            [calagem setValue:txtProprietario.text forKey:@"proprietario"];
            [calagem setValue:txtPropriedade.text forKey:@"propriedade"];
            [calagem setValue:txtSolo.text forKey:@"solo"];
            [calagem setValue:txtCultivo.text forKey:@"cultivo"];
            [calagem setValue:ValorV2 forKey:@"v2"];
            [calagem setValue:txtAmostra.text forKey:@"amostra"];
            [calagem setValue:txtData.text forKey:@"data"];
            [calagem setValue:ValorPrnt forKey:@"prnt"];
            [calagem setValue:ValorK forKey:@"k"];
            [calagem setValue:ValorCa forKey:@"ca"];
            [calagem setValue:ValorHAL forKey:@"hal"];
            [calagem setValue:ValorMg forKey:@"mg"];
            [calagem setValue:ValorSB forKey:@"sb"];
            [calagem setValue:ValorCTB forKey:@"ctcph"];
            [calagem setValue:ValorV1 forKey:@"v1"];
            [calagem setValue:ResultadoFinal forKey:@"resultado"];
            [calagem setValue:LbLegendaResultado.text forKey:@"legendaResultado"];
            
        } else {
            //criar nova calagem
            NSManagedObject * novaCalagem = [NSEntityDescription insertNewObjectForEntityForName:@"Calagem" inManagedObjectContext:context];
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            
            NSNumber * ValorV2        = [f numberFromString:LbResultadoV2.text];
            NSNumber * ValorPrnt      = [f numberFromString:txtPrnt.text];
            NSNumber * ValorK         = [f numberFromString:txtElementok.text];
            NSNumber * ValorCa        = [f numberFromString:txtElementoCa.text];
            NSNumber * ValorHAL       = [f numberFromString:txtElementoHAL.text];
            NSNumber * ValorMg        = [f numberFromString:txtElementoMg.text];
            NSNumber * ValorSB        = [f numberFromString:txtResultadoSB.text];
            NSNumber * ValorCTB       = [f numberFromString:txtResultadoCTC.text];
            NSNumber * ValorV1        = [f numberFromString:txtResultadoV1.text];
            NSNumber * ResultadoFinal = [f numberFromString:_ValorFinal];
            
            [novaCalagem setValue:txtProprietario.text forKey:@"proprietario"];
            [novaCalagem setValue:txtPropriedade.text forKey:@"propriedade"];
            [novaCalagem setValue:txtSolo.text forKey:@"solo"];
            [novaCalagem setValue:txtCultivo.text forKey:@"cultivo"];
            [novaCalagem setValue:ValorV2 forKey:@"v2"];
            [novaCalagem setValue:txtData.text forKey:@"data"];
            [novaCalagem setValue:txtAmostra.text forKey:@"amostra"];
            [novaCalagem setValue:ValorPrnt forKey:@"prnt"];
            [novaCalagem setValue:ValorK forKey:@"k"];
            [novaCalagem setValue:ValorCa forKey:@"ca"];
            [novaCalagem setValue:ValorHAL forKey:@"hal"];
            [novaCalagem setValue:ValorMg forKey:@"mg"];
            [novaCalagem setValue:ValorSB forKey:@"sb"];
            [novaCalagem setValue:ValorCTB forKey:@"ctcph"];
            [novaCalagem setValue:ValorV1 forKey:@"v1"];
            [novaCalagem setValue:ResultadoFinal forKey:@"resultado"];
            [novaCalagem setValue:LbLegendaResultado.text forKey:@"legendaResultado"];
        }
        
        NSError * error = nil;
        if (![context save:&error]) {
            //  NSLog(@"Falha ao salvar!", error, [error localizedDescription]);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)btnCalcular:(id)sender {
    [self Calcular];
}

- (IBAction)btnPesquisarCultivo:(id)sender {
    listaSelect = [[NSMutableArray alloc] init];
    [listaSelect addObject:@"Algodão"];
    [listaSelect addObject:@"Feijão"];
    [listaSelect addObject:@"Milho"];
    [listaSelect addObject:@"Soja"];
    [listaSelect addObject:@"Trigo"];
    
    RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
    pickerVC.delegate = self;
    
    [pickerVC showWithSelectionHandler:^(RMPickerViewController *vc, NSArray *selectedRows) {
        
        NSString * result = [[selectedRows valueForKey:@"description"] componentsJoinedByString:@""];
        
        int linha = [result integerValue];
        
        switch (linha){
            case 0: txtCultivo.text = @"Algodão"; break;
            case 1: txtCultivo.text = @"Feijão"; break;
            case 2: txtCultivo.text = @"Milho"; break;
            case 3: txtCultivo.text = @"Soja"; break;
            case 4: txtCultivo.text = @"Trigo"; break;
        }
        
        [self CalcularV2:txtSolo.text ValorCultivo:txtCultivo.text];
        
        NSLog(@"mm,m: %@ ", selectedRows.description);
    } andCancelHandler:^(RMPickerViewController *vc) { NSLog(@"Selection was canceled (with block)"); }];
}

-(void) CalcularV2:(NSString *)Solo ValorCultivo:(NSString *)Cultivo{
    
    if ([Solo isEqualToString:@"Arenoso"]) {
        if ([Cultivo isEqualToString:@"Algodão"]) { LbResultadoV2.text = @"50"; }
        if ([Cultivo isEqualToString:@"Feijão"])  { LbResultadoV2.text = @"50"; }
        if ([Cultivo isEqualToString:@"Milho"])   { LbResultadoV2.text = @"50"; }
        if ([Cultivo isEqualToString:@"Soja"])    { LbResultadoV2.text = @"50"; }
        if ([Cultivo isEqualToString:@"Trigo"])   { LbResultadoV2.text = @"50"; }
    }
    if ([Solo isEqualToString:@"Argiloso"]) {
        if ([Cultivo isEqualToString:@"Algodão"]) { LbResultadoV2.text = @"70"; }
        if ([Cultivo isEqualToString:@"Feijão"])  { LbResultadoV2.text = @"70"; }
        if ([Cultivo isEqualToString:@"Milho"])   { LbResultadoV2.text = @"70"; }
        if ([Cultivo isEqualToString:@"Soja"])    { LbResultadoV2.text = @"70"; }
        if ([Cultivo isEqualToString:@"Trigo"])   { LbResultadoV2.text = @"60"; }
    }
}



#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

- (void) Calcular{
    
    NSString * ValorCaStr  = [txtElementoCa.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSString * ValorMgStr  = [txtElementoMg.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSString * ValorkStr   = [txtElementok.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSString * ValorHALStr = [txtElementoHAL.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    
    double ValorCa  = [ValorCaStr  doubleValue];
    double ValorMg  = [ValorMgStr  doubleValue];
    double ValorK   = [ValorkStr   doubleValue];
    double ValorHAL = [ValorHALStr doubleValue];
    
    double ResultadoSB   = ValorCa + ValorMg + ValorK;
    double ResultadoCTC  = ResultadoSB + ValorHAL;
    double ResultadoV1   = (ResultadoSB / ResultadoCTC) * 100;
    double ResultadoV2   = [LbResultadoV2.text doubleValue];
    double ResultadoPRNT = 100 / [txtPrnt.text doubleValue];
    
    txtResultadoSB.text   = [[NSString stringWithFormat:@"%.2f", ResultadoSB]  stringByReplacingOccurrencesOfString:@"." withString:@","];
    txtResultadoCTC.text  = [[NSString stringWithFormat:@"%.2f", ResultadoCTC] stringByReplacingOccurrencesOfString:@"." withString:@","];
    txtResultadoV1.text   = [[NSString stringWithFormat:@"%.2f", ResultadoV1]  stringByReplacingOccurrencesOfString:@"." withString:@","];
    
    // ****** Cálculo fórmula ****** //
    double NC = ((ResultadoV2 - ResultadoV1) * ResultadoCTC / 100) / ResultadoPRNT;
    
    _ValorFinal = [[NSString stringWithFormat:@"%.3f", NC] stringByReplacingOccurrencesOfString:@"." withString:@","];
    
    if (NC <= 0) {
        LbResultadoFinal.text = [NSString stringWithFormat:@"%@ (t/ha).", _ValorFinal];
        LbLegendaResultado.text = @"Não é necessário fazer a calagem";
    }
    if (NC > 0) {
        LbResultadoFinal.text = [NSString stringWithFormat:@"%@ (t/ha).", _ValorFinal];
        LbLegendaResultado.text = @"É necessário fazer a calagem.";
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtElementok resignFirstResponder];
    [txtElementoCa resignFirstResponder];
    [txtElementoMg resignFirstResponder];
    [txtElementoHAL resignFirstResponder];
    [txtPrnt resignFirstResponder];
    [txtAmostra resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [txtElementok resignFirstResponder];
    [txtElementoCa resignFirstResponder];
    [txtElementoMg resignFirstResponder];
    [txtElementoHAL resignFirstResponder];
    [txtPrnt resignFirstResponder];
    [txtAmostra resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"buscarProprietario"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.textoProprietario = txtProprietario;
        destViewController.textoPropriedade  = txtPropriedade;
        destViewController.textoEndereco     = endereco;
        
    }
}

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
