//
//  ViewController.m
//  DroneMarin
//
//  Created by Hugo Bidois on 09/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import "SecondViewController.h"
#import "Waypoints.h"
#import "Modele.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize mapView;
CLLocationCoordinate2D dest[2];
bool firstDraw, secondDraw, stationnaire, priseImage;
NSMutableArray  *monTab;
Modele *modele;

- (void)viewDidLoad {
    [super viewDidLoad];
    monTab = [NSMutableArray array];
    mapView.delegate =(id)self;
    modele = [[Modele alloc]init];
    //Set map on a specific position and zoom
    
    CLLocationCoordinate2D userLocation = CLLocationCoordinate2DMake(46.134739, -1.150361);
    CLLocationDistance distance = 50*50;
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation, distance, distance)];
    priseImage = false;
    stationnaire = false;
    //Add onTap
     UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [mapView addGestureRecognizer:tgr];
}

//Function on tap
-(void)tapGestureHandler:(UITapGestureRecognizer *)tgr
{
    Waypoints *monWaypoint = [[Waypoints alloc]init];
    CGPoint touchPoint = [tgr locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    NSMutableArray *array = modele.getArray;
    bool delete = false;
    Waypoints *leWaypoint;
    int index = 0;
    for (Waypoints* waypoint in array) {
        CLLocationCoordinate2D coord = waypoint.getDest;
        float lat = touchMapCoordinate.latitude - coord.latitude;
        float lon = touchMapCoordinate.longitude - coord.longitude;
        if ((lat < 0.0001 && lat > -0.0001)) {
            delete = true;
            leWaypoint = waypoint;
            break;
        }
        index++;
    }
    //dialogbox
    UIAlertController *ui = [UIAlertController alertControllerWithTitle:@"Propriété du waypoint" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (delete) {
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Vitesse";
            textField.text = [NSString stringWithFormat:@"%f", leWaypoint.getVitesse];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        __weak typeof (self) weakSelf = self;
        //checkbox prise d'image
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
            [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
            [checkbox setTag:1];
            [checkbox addTarget:weakSelf action:@selector(buttonPressedPriseImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [checkbox.imageView setContentMode:UIViewContentModeScaleAspectFit];
            if (leWaypoint.getIsPrimeImage) {
                [checkbox setSelected:true];
            } else {
                [checkbox setSelected:false];
            }
            [checkbox.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
            [checkbox setAdjustsImageWhenHighlighted:TRUE];
            
            [textField setClearButtonMode:UITextFieldViewModeAlways];
            [textField setRightViewMode:UITextFieldViewModeAlways];
            [textField setRightView:checkbox];
            
            [textField setTag:-1];
            [textField setText:@"Prise d'image"];
        }];
        
        //checkbox point stationnaire
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
            [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
            [checkbox setTag:1];
            [checkbox addTarget:weakSelf action:@selector(buttonPressedStationnaire:) forControlEvents:UIControlEventTouchUpInside];
            if (leWaypoint.getIsStationnaire) {
                [checkbox setSelected:true];
            } else {
                [checkbox setSelected:false];
            }
            [checkbox.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
            [checkbox setAdjustsImageWhenHighlighted:TRUE];
            
            [textField setClearButtonMode:UITextFieldViewModeAlways];
            [textField setRightViewMode:UITextFieldViewModeAlways];
            [textField setRightView:checkbox];
            
            [textField setTag:-1];
            [textField setText:@"Point stationnaire"];
        }];
        
        UIAlertAction *deleteButton = [UIAlertAction actionWithTitle:@"Supprimer" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [mapView removeAnnotation:leWaypoint.getAnnot];
            [modele deleteWaypoint:leWaypoint];
            [self reDraw];
        }];
        
        UIAlertAction *annulerButton = [UIAlertAction actionWithTitle:@"Annuler" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
        }];
        
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //A l'appuie du boutton ok
            //Récupération de la vitesse
            NSArray *textFields = ui.textFields;
            UITextField *vitesseTextField = textFields[0];
            NSString *vitesseString = vitesseTextField.text;
            
            //Init waypoint
            [leWaypoint setVitesse:[vitesseString floatValue]];
            [leWaypoint setIsPrimeImage:priseImage];
            [leWaypoint setIsStationnaire:stationnaire];
        }];
        [ui addAction:okButton];
        [ui addAction:deleteButton];
        [ui addAction:annulerButton];
    } else {
        //textfield vitesse
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Vitesse";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        __weak typeof (self) weakSelf = self;
        //checkbox prise d'image
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
            [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
            [checkbox setTag:1];
            [checkbox addTarget:weakSelf action:@selector(buttonPressedPriseImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [checkbox.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
            [checkbox setAdjustsImageWhenHighlighted:TRUE];
            
            [textField setClearButtonMode:UITextFieldViewModeAlways];
            [textField setRightViewMode:UITextFieldViewModeAlways];
            [textField setRightView:checkbox];
            
            [textField setTag:-1];
            [textField setText:@"Prise d'image"];
        }];
        
        //checkbox point stationnaire
        [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
            [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
            [checkbox setTag:1];
            [checkbox addTarget:weakSelf action:@selector(buttonPressedStationnaire:) forControlEvents:UIControlEventTouchUpInside];
            
            [checkbox.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
            [checkbox setImage:[UIImage imageNamed:@"checkbox_unchecked.png"] forState:UIControlStateNormal];
            [checkbox setAdjustsImageWhenHighlighted:TRUE];
            
            [textField setClearButtonMode:UITextFieldViewModeAlways];
            [textField setRightViewMode:UITextFieldViewModeAlways];
            [textField setRightView:checkbox];
            
            [textField setTag:-1];
            [textField setText:@"Point stationnaire"];
        }];
        
        UIAlertAction *annulerButton = [UIAlertAction actionWithTitle:@"Annuler" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //A l'appuie du boutton ok
            MKPointAnnotation *point1 = [[MKPointAnnotation alloc]init];
            point1.coordinate = touchMapCoordinate;
            [mapView addAnnotation:point1];
            
            //Récupération de la vitesse
            NSArray *textFields = ui.textFields;
            UITextField *vitesseTextField = textFields[0];
            NSString *vitesseString = vitesseTextField.text;
            
            //Init waypoint
            [monWaypoint setVitesse:[vitesseString floatValue]];
            [monWaypoint setIsPrimeImage:priseImage];
            [monWaypoint setIsStationnaire:stationnaire];
            [monWaypoint setDest:touchMapCoordinate];
            [monWaypoint setAnnot:point1];
            [modele addWaypoint:monWaypoint];
            
            if ([modele getNbWaypoints] > 1) {
                [self draw];
            }
        }];
        
        [ui addAction:annulerButton];
        [ui addAction:okButton];
    }
    
    [self presentViewController:ui animated:YES completion:nil];
}

//On click on checkbock is prise image
-(void)buttonPressedPriseImage:(UIButton*)sender{
    if (sender.selected) {
        priseImage = false;
        [sender setSelected:FALSE];
    } else {
        priseImage = true;
        [sender setSelected:TRUE];
    }
}

-(void)reDraw {
    NSMutableArray *array = modele.getArray;
    for (MKPolyline * polyline in array) {
        [mapView removeOverlay:polyline];
    }
}

//On click on checkbox is stationnaire
-(void)buttonPressedStationnaire:(UIButton*)sender{
    if (sender.selected) {
        stationnaire = false;
        [sender setSelected:FALSE];
    } else {
        stationnaire = true;
        [sender setSelected:TRUE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Function to draw the line between waypoints
-(void)draw {
    int count = (int)[modele getNbWaypoints]-1;
    
    Waypoints *firstDest = [modele getWaypointAtIndex:(count-1)];
    
    Waypoints *secondDest = [modele getWaypointAtIndex:count];
    dest[0] = firstDest.getDest;
    dest[1] = secondDest.getDest;
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:dest count:2];
    [modele addPoyline:polyline];
    [self.mapView addOverlay:polyline];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor redColor]];
        [renderer setLineWidth:3.0];
        return renderer;
    }
    return nil;
}

@end
