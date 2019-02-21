//
//  CalagemTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "RelatorioGessagem.h"
#import "CalagemNovaTable.h"
#import "CellRelatorio.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <CoreText/CoreText.h>

#import "GADBannerView.h"
#import "GADRequest.h"
#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-6439752646521747/3360842512"
#define simulador @"377d635157683106a48cd155a9d9bb8a"


#define tamanhoCorpo 10
#define tamanhoRodape 8
#define tamanhoCabecalho 12
#define tamanhoTitulo 14
#define tamanhoTituloPrincipal 16

#define fonteNormal @"Helvetica"
#define fonteNegrito @"Helvetica-Bold"

#define linhaSupResultado 240
#define linhaInfrResultado 180

@interface RelatorioGessagem () {
    CGSize pageSize;
}

@end

@implementation RelatorioGessagem

@synthesize Variedade;
@synthesize Agronomo;  //obj context
@synthesize Agronomos; //arraymutable
@synthesize VariedadeObj;
@synthesize VariedadesArray;
@synthesize strPropriedade;
@synthesize strProprietario;
@synthesize ProprietarioProprietario;

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
    strProprietario = [ProprietarioProprietario valueForKey:@"proprietario"];
    strPropriedade  = [ProprietarioProprietario valueForKey:@"propriedade"];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    GADBannerView *bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = INTERSTITIAL_AD_UNIT_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    
    return bannerView_;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
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
    
    // Qual o nome do banco //
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Colheita"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Colheita" inManagedObjectContext:self.managedObjectContext];
    
    // Required! Unless you set the resultType to NSDictionaryResultType, distinct can't work.
    // All objects in the backing store are implicitly distinct, but two dictionaries can be duplicates.
    // Since you only want distinct names, only ask for the 'name' property.

    // qual  a tabela ser usada //
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"variedade"]];
    
    // Monta o Where //
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"proprietario == %@ and propriedade == %@",strProprietario, strPropriedade];
    [fetchRequest setPredicate:predicateID];
    
    // criar o order by //
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"variedade" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    fetchRequest.returnsDistinctResults = YES;
    
    // Now it should yield an NSArray of distinct values in dictionaries.
    NSArray *dictionaries = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSLog (@"names: %@",dictionaries);
    
    Variedade = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
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
    return Variedade.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSManagedObject * variedade = [Variedade objectAtIndex:indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    cell.textLabel.text   = [variedade valueForKey:@"variedade"];
    return cell;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Proprietario = [ProprietarioProprietario valueForKey:@"proprietario"];
    NSString * Propriedade = [ProprietarioProprietario valueForKey:@"propriedade"];
    
   
    NSManagedObject * selectedVariedade = [Variedade objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString *VarVariedade  = [NSString stringWithFormat:@"Variedade: %@", [selectedVariedade valueForKey:@"variedade"]];
    
    NSString *StrVariedade = [NSString stringWithFormat:@"%@", [selectedVariedade valueForKey:@"variedade"]];
    
    //Select All com paramentro proprietario - propriedade - variedade//
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Colheita"];
    
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"variedade == %@ and proprietario == %@ and propriedade == %@",StrVariedade, Proprietario,Propriedade];
    [fetchRequest setPredicate:predicateID];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"dataPrevista" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    VariedadesArray = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    //pego o primeiro registro//
    VariedadeObj = [VariedadesArray objectAtIndex:0];
    
    NSString * NomeArquivo = [NSString stringWithFormat:@"Relatório de Programação da Colheita - %@ - %@.pdf", Propriedade, StrVariedade];
    
    NSString * fileName = [self getPDFFileName:NomeArquivo];
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self textoDinamico:@"Relatório - Programação da Colheita" Fn:fonteNegrito Ft:tamanhoTituloPrincipal x:160 y:60];
   
    // Começa a desenhar o cabeçalho //
    [self textoDinamico:strProprietario Fn:fonteNegrito Ft:tamanhoCabecalho x:60 y:100];
    [self textoDinamico:strPropriedade  Fn:fonteNegrito Ft:tamanhoCabecalho x:60 y:120];
    
    [self textoDinamico:VarVariedade    Fn:fonteNegrito  Ft:tamanhoCabecalho x:60 y:140];
    
    // Linha depois do cabeçalho ?
    CGPoint PrimeiraFrom = CGPointMake(50, 160);
    CGPoint PrimeiraTo = CGPointMake(560, 160);
    [self Linha:PrimeiraFrom toPoint:PrimeiraTo];
    
    NSInteger linha = 180;
    
    [self textoDinamico:@"Plantio"    Fn:fonteNegrito Ft:tamanhoCabecalho x:65  y:163];
    [self textoDinamico:@"Lote"       Fn:fonteNegrito Ft:tamanhoCabecalho x:190 y:163];
    [self textoDinamico:@"Ciclo"      Fn:fonteNegrito Ft:tamanhoCabecalho x:292 y:163];
    [self textoDinamico:@"Germinação" Fn:fonteNegrito Ft:tamanhoCabecalho x:382 y:163];
    [self textoDinamico:@"Colheita"   Fn:fonteNegrito Ft:tamanhoCabecalho x:500 y:163];
    
    if ([VariedadesArray count] > 38) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Erro"
                              message:@"Não é possível imprimir mais que 38 registros!"
                              delegate:nil cancelButtonTitle:nil
                              otherButtonTitles:@"ok", nil];
        [alert show];
    } else {
        //começo a fazer o relatórios//
        for (int i = 0; i < [VariedadesArray count]; i++)
        {
            VariedadeObj = [VariedadesArray objectAtIndex:i];
            
            NSString * dataPlantio  = [VariedadeObj valueForKey:@"dataPlantio"];
            NSString * lote         = [VariedadeObj valueForKey:@"lote"];
            NSString * ciclo        = [VariedadeObj valueForKey:@"diasCiclo"];
            NSString * atraso       = [VariedadeObj valueForKey:@"diasAtraso"];
            NSString * dataColheita = [VariedadeObj valueForKey:@"dataPrevistaStr"];
            
            // Resultados //
            [self textoDinamico:dataPlantio  Fn:fonteNormal Ft:tamanhoCorpo x:60  y:linha];
            [self textoDinamico:lote         Fn:fonteNormal Ft:tamanhoCorpo x:200 y:linha];
            [self textoDinamico:ciclo        Fn:fonteNormal Ft:tamanhoCorpo x:300 y:linha];
            [self textoDinamico:atraso       Fn:fonteNormal Ft:tamanhoCorpo x:400 y:linha];
            [self textoDinamico:dataColheita Fn:fonteNegrito Ft:tamanhoCorpo x:500 y:linha];
            
            linha += 15;
        }
        // Linha depois do cabeçalho
        CGPoint SegundaFrom = CGPointMake(50, 750);
        CGPoint SegundaTo   = CGPointMake(560, 750);
        [self Linha:SegundaFrom toPoint:SegundaTo];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy 'às' HH:mm'h'"];
        
        NSDate *now = [[NSDate alloc] init];
        
        NSString *DateHora = [dateFormat stringFromDate:now];
        NSString *LinkApp  = @"Relatório gerado pelo App: http://goo.gl/jD9f3h";
        
        [self textoDinamico:LinkApp Fn:fonteNormal Ft:tamanhoRodape x:50 y:752];
        [self textoDinamico:DateHora Fn:fonteNormal Ft:tamanhoRodape x:480 y:752];
        
        
        // Close the PDF context and write the contents out.
        UIGraphicsEndPDFContext();
        
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
            mail.mailComposeDelegate= (id)self;
            [[mail navigationBar] setTintColor:[UIColor whiteColor]];
            [mail setSubject:[NSString stringWithFormat:@"Rel. de Prog. da Colheita - %@ - %@", Propriedade, StrVariedade]];
            [self presentViewController:mail animated:YES completion:nil];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *file = [documentsDirectory stringByAppendingPathComponent:NomeArquivo];
            NSData *data = [NSData dataWithContentsOfFile:file];
            
            /// Set up argument to attach PDF to email.
            [mail addAttachmentData:data mimeType:@"application/pdf" fileName:NomeArquivo];
            [self presentViewController:mail animated:YES completion:^{NSLog (@"Action Completed");}];
            
        }
        else
        {
            NSLog(@"Message cannot be sent");
        }
    }
}

-(NSString*)getPDFFileName:(NSString *)nomeArquivo
{
    NSString* fileName = nomeArquivo;
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    return pdfFileName;

}
- (void) textoDinamico:(NSString *)Texto Fn:(NSString *)fonteNome Ft:(NSInteger)fonteTamanho x:(NSInteger)valorX y:(NSInteger)valorY{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIFont * font = [UIFont fontWithName:fonteNome size:fonteTamanho];
    CGContextSetFillColorWithColor(context, [[UIColor blackColor]CGColor]);
    CGRect textRect = CGRectMake(valorX, valorY, pageSize.width, pageSize.height);

    [Texto drawInRect:textRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}







-(void)Linha:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}

@end
