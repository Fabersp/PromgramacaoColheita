//
//  CalagemCellTableViewCell.h
//  Calagem
//
//  Created by Fabricio Aguiar de Padua on 30/05/14.
//  Copyright (c) 2014 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalagemCell : UITableViewCell {
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *LbProprietario;
@property (weak, nonatomic) IBOutlet UILabel *Propriedade;
@property (weak, nonatomic) IBOutlet UILabel *DataPlantio;
@property (weak, nonatomic) IBOutlet UILabel *DataColheita;
@property (weak, nonatomic) IBOutlet UILabel *Lote;
@property (weak, nonatomic) IBOutlet UILabel *Variedade;

@end
