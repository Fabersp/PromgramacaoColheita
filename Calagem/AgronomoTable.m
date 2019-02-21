//
//  AgronomoTable.m
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 25/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import "AgronomoTable.h"
#import "AgronomoNovoTable.h"

#import "GADBannerView.h"
#import "GADRequest.h"
#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-6439752646521747/3360842512"
#define simulador @"377d635157683106a48cd155a9d9bb8a"

@interface AgronomoTable ()

@end

@implementation AgronomoTable

@synthesize Agronomos;



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

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //***** botão esquerdo ***** ///
    //UIBarButtonItem *editButton = self.editButtonItem;
    //editButton.title = @"Editar";
    //editButton.tintColor = [UIColor whiteColor];
    //[editButton setTarget:self];
    //[editButton setAction:@selector(toggleEdit)];
    //self.navigationItem.leftBarButtonItem = editButton;
    
    // ***** Botão direito **** //    
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

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    // [AgronomoTableViewController setEditing:editing animated:animated];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSManagedObjectContext * moc = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Agronomo"];
    Agronomos = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    [self.tableView reloadData];
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
    return Agronomos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIndentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    
    NSManagedObject * Agronomo = [Agronomos objectAtIndex:indexPath.row];
    [cell.textLabel setText:[Agronomo valueForKey:@"nome"]];
    [cell.detailTextLabel setText:[Agronomo valueForKey:@"celular"]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext * context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[Agronomos objectAtIndex:indexPath.row]];
    }
    
    NSError * error = nil;
    if (![context save:&error]) {
        NSLog(@"Não foi possível deletar!");
        return;
    }
    
    [Agronomos removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"UpdateAgronomo"]) {
        NSManagedObject * selectedCar = [Agronomos objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        AgronomoNovoTable * destViewController = segue.destinationViewController;
        destViewController.Agronomo = selectedCar;
        destViewController.title = @"Editar";
    }
}

@end
