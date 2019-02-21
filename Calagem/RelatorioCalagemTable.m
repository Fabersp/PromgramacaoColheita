//
//  CalagemTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 26/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "RelatorioCalagemTable.h"
#import "CalagemNovaTable.h"
#import "CalagemCell.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>


#import <CoreText/CoreText.h>

#define tamanhoCorpo 10
#define tamanhoCabecalho 12
#define tamanhoTitulo 14
#define tamanhoTituloPrincipal 16

#define fonteNormal @"Helvetica"
#define fonteNegrito @"Helvetica-Bold"

#define linhaSupResultado 270
#define linhaInfrResultado 290

@interface RelatorioCalagemTable () {
    CGSize pageSize;
}

@end

@implementation RelatorioCalagemTable

@synthesize Calagem;
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
 /*   cell.data.text      = [calagem valueForKey:@"data"];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSManagedObject * selectedCalagem = [Calagem objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    // montar as variaávies
    NSString *strProprietario = [NSString stringWithFormat:@"Proprietário: %@", [selectedCalagem valueForKey:@"proprietario"]];
    NSString *strPropriedade  = [NSString stringWithFormat:@"Propriedade: %@", [selectedCalagem valueForKey:@"propriedade"]];
    NSString *strData         = [NSString stringWithFormat:@"Data: %@", [selectedCalagem valueForKey:@"data"]];
    NSString *strAmostra      = [NSString stringWithFormat:@"Amostra: %@", [selectedCalagem valueForKey:@"amostra"]];
    NSString *strClasseSolo   = [NSString stringWithFormat:@"Solo: %@", [selectedCalagem valueForKey:@"solo"]];
    NSString *strCultivo      = [NSString stringWithFormat:@"Cultivo: %@", [selectedCalagem valueForKey:@"cultivo"]];
    
    NSString * Proprietadade = [[selectedCalagem valueForKey:@"propriedade"] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString * Amostra       = [[selectedCalagem valueForKey:@"amostra"] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString * data          = [[selectedCalagem valueForKey:@"Data"] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    NSString * NomeArquivo = [NSString stringWithFormat:@"%@_%@_Amostra_%@.pdf", Proprietadade, data, Amostra];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // fazenda_itaguaba_05052014_amostra_AASASAS.pdf //
    
    NSString * ValorV2     = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"v2"]];
    NSString * ValorPrnt   = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"prnt"]];
    NSString * ValorK      = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"k"]];
    NSString * ValorCa     = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"ca"]];
    NSString * ValorHAL    = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"hal"]];
    NSString * ValorMg     = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"mg"]];
    NSString * ValorSB     = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"sb"]];
    NSString * ValorCTB    = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"ctcph"]];
    NSString * ValorV1     = [formatter stringForObjectValue:[selectedCalagem valueForKey:@"v1"]];
    NSString * ResultadoFinal = [NSString stringWithFormat:@"%@ (t/ha)", [formatter stringForObjectValue:[selectedCalagem valueForKey:@"resultado"]]];
    
    NSString * LegendaResultado = [selectedCalagem valueForKey:@"legendaResultado"];
    
    NSString * valorResultado = [selectedCalagem valueForKey:@"resultado"];
    
    double NumberResultado = [valorResultado doubleValue];

    double valorDivisao = NumberResultado/2;
    
    NSString* fileName = [self getPDFFileName:NomeArquivo];
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self textoDinamico:@"Relatório de Análise para Calagem" Fn:fonteNegrito Ft:tamanhoTituloPrincipal x:180 y:60];
    
    // Começa a desenhar o cabeçalho //
    [self textoDinamico:strProprietario Fn:fonteNegrito Ft:tamanhoCabecalho x:60 y:100];
    [self textoDinamico:strPropriedade  Fn:fonteNegrito Ft:tamanhoCabecalho x:60 y:120];
    
    [self textoDinamico:strData         Fn:fonteNormal  Ft:tamanhoCabecalho x:60 y:140];
    [self textoDinamico:strAmostra      Fn:fonteNormal  Ft:tamanhoCabecalho x:60 y:160];
    
    [self textoDinamico:strClasseSolo   Fn:fonteNormal  Ft:tamanhoCabecalho x:60 y:180];
    [self textoDinamico:strCultivo      Fn:fonteNormal  Ft:tamanhoCabecalho x:60 y:200];

    // Linha depois do cabeçalho ?
    CGPoint PrimeiraFrom = CGPointMake(50, 230);
    CGPoint PrimeiraTo = CGPointMake(560, 230);
    [self Linha:PrimeiraFrom toPoint:PrimeiraTo];
 
    // começo do corpo do relatório //
    [self textoDinamico:@"Resultados" Fn:fonteNegrito  Ft:tamanhoTitulo x:260 y:240];
    
    // Resultados //
    [self textoDinamico:@"k" Fn:fonteNormal  Ft:tamanhoCorpo x:60 y:linhaSupResultado];
    [self textoDinamico:[ValorK stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNegrito  Ft:tamanhoCorpo x:60 y:linhaInfrResultado];
    
    [self textoDinamico:@"Ca" Fn:fonteNormal  Ft:tamanhoCorpo x:110 y:linhaSupResultado];
    [self textoDinamico:[ValorCa   stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:110 y:linhaInfrResultado];
    
    [self textoDinamico:@"Mg" Fn:fonteNormal  Ft:tamanhoCorpo x:160 y:linhaSupResultado];
    [self textoDinamico:[ValorMg   stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:160 y:linhaInfrResultado];
    
    [self textoDinamico:@"H+Al" Fn:fonteNormal  Ft:tamanhoCorpo x:210 y:linhaSupResultado];
    [self textoDinamico:[ValorHAL stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:210 y:linhaInfrResultado];
    
    [self textoDinamico:@"CTC(pH7,0)" Fn:fonteNormal  Ft:tamanhoCorpo x:260 y:linhaSupResultado];
    [self textoDinamico:[ValorCTB  stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:260 y:linhaInfrResultado];
    
    [self textoDinamico:@"V1%" Fn:fonteNormal  Ft:tamanhoCorpo x:340 y:linhaSupResultado];
    [self textoDinamico:[ValorV1   stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:340 y:linhaInfrResultado];
    
    [self textoDinamico:@"V2%" Fn:fonteNormal  Ft:tamanhoCorpo x:390 y:linhaSupResultado];
    [self textoDinamico:[ValorV2   stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:390 y:linhaInfrResultado];
    
    [self textoDinamico:@"SB" Fn:fonteNormal  Ft:tamanhoCorpo x:440 y:linhaSupResultado];
    [self textoDinamico:[ValorSB   stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:440 y:linhaInfrResultado];
    
    [self textoDinamico:@"PRNT%" Fn:fonteNormal  Ft:tamanhoCorpo x:490 y:linhaSupResultado];
    [self textoDinamico:[ValorPrnt stringByReplacingOccurrencesOfString:@"." withString:@","] Fn:fonteNormal  Ft:tamanhoCorpo x:490 y:linhaInfrResultado];
    
    // Resultado final //
    [self textoDinamico:@"NC:" Fn:fonteNegrito Ft:tamanhoCabecalho x:100 y:310];
    [self textoDinamico:ResultadoFinal   Fn:fonteNegrito  Ft:tamanhoCabecalho x:125 y:310];
    
    [self textoDinamico:LegendaResultado Fn:fonteNegrito Ft:tamanhoCabecalho x:250 y:310];
 
    // Linha depois do cabeçalho
    CGPoint SegundaFrom = CGPointMake(50, 330);
    CGPoint SegundaTo = CGPointMake(560, 330);
    [self Linha:SegundaFrom toPoint:SegundaTo];
  
    // começo do corpo do relatório //
    [self textoDinamico:@"Recomendações" Fn:fonteNegrito Ft:tamanhoTitulo x:240 y:340];
    
    if (NumberResultado > 0) {
        [self textoDinamico:@"Aplicar no mínimo 2 meses de antecendência do próximo cultivo." Fn:fonteNormal Ft:tamanhoCabecalho x:60 y:370];
        if (NumberResultado < 5) {
            [self textoDinamico:[NSString stringWithFormat:@"Aplicar %@ antes da aração.", ResultadoFinal] Fn:fonteNormal Ft:tamanhoCabecalho x:60 y:390];
        }
    
        if (NumberResultado >= 5) {
            [self textoDinamico:[NSString stringWithFormat:@"Aplicar %.3f (t/ha) antes da aração e %.3f (t/ha) depois, incorporando com grade.", (valorDivisao), (valorDivisao)] Fn:fonteNormal Ft:tamanhoCabecalho x:60 y:390];
        }
        [self textoDinamico:@"Obs.: Quando for plantio direto, incorporar o calcário em superfície com uma grade leve." Fn:fonteNormal Ft:tamanhoCabecalho x:60 y:410];
    }
    
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Agronomo"];
    Agronomos = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    if ([Agronomos count] == 1){
        Agronomo = [Agronomos objectAtIndex:0];
        [self textoDinamico:[NSString stringWithFormat:@"%@ - CREA:%@", [Agronomo valueForKey:@"nome"], [Agronomo valueForKey:@"crea"]]     Fn:fonteNegrito Ft:tamanhoCorpo x:150 y:700];
    
        [self textoDinamico:[NSString stringWithFormat:@"Telefone:%@ - Celular:%@", [Agronomo valueForKey:@"telefone"], [Agronomo valueForKey:@"celular"]]  Fn:fonteNegrito Ft:tamanhoCorpo x:150 y:720];
        
        [self textoDinamico:[NSString stringWithFormat:@"Email: %@", [Agronomo valueForKey:@"email"]]   Fn:fonteNegrito Ft:tamanhoCorpo x:150 y:740];
        
    }
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
        mail.mailComposeDelegate= (id)self;
        [mail setSubject:[NSString stringWithFormat:@"Relatório de calagem %@ - %@ amostra %@ ", [selectedCalagem valueForKey:@"propriedade"], [selectedCalagem valueForKey:@"data"], [selectedCalagem valueForKey:@"amostra"]]];
        
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
