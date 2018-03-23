//
//  ViewController.m
//  DroneMarin
//
//  Created by Hugo Bidois on 09/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView;
CLLocationCoordinate2D dest[2];
bool firstDraw, secondDraw;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapView.delegate =(id)self;
    
    //Set map on a specific position and zoom
    CLLocationCoordinate2D userLocation = CLLocationCoordinate2DMake(46.134739, -1.150361);
    CLLocationDistance distance = 50*50;
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation, distance, distance)];
    firstDraw = true;
    secondDraw = true;
    
    //Add onTap
     UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [mapView addGestureRecognizer:tgr];
}

//Function on tap
-(void)tapGestureHandler:(UITapGestureRecognizer *)tgr
{
    CGPoint touchPoint = [tgr locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    
    
    
    UIAlertController *ui = [UIAlertController alertControllerWithTitle:@"Propriété du waypoint" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Vitesse";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //A l'appuie du boutton ok
        MKPointAnnotation *point1 = [[MKPointAnnotation alloc]init];
        point1.coordinate = touchMapCoordinate;
        [mapView addAnnotation:point1];
        if (firstDraw) {
            dest[0] = touchMapCoordinate;
            firstDraw = false;
        } else if (secondDraw) {
            dest[1] = touchMapCoordinate;
            secondDraw = false;
            [self draw];
        } else {
            dest[0] = dest[1];
            dest[1] = touchMapCoordinate;
            [self draw];
        }
        
        //Récupération de la vitesse
        NSArray *textFields = ui.textFields;
        UITextField *vitesseTextField = textFields[0];
        NSString *vitesse = vitesseTextField.text;
        
    }];
    
    __weak typeof (self) weakSelf = self;
    [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
        [checkbox setTag:1];
        [checkbox addTarget:weakSelf action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    [ui addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkbox setFrame:CGRectMake(2, 2, 18, 18)];
        [checkbox setTag:1];
        [checkbox addTarget:weakSelf action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    [ui addAction:annulerButton];
    [ui addAction:okButton];
    
    [self presentViewController:ui animated:YES completion:nil];
}

-(void)buttonPressed:(UIButton*)sender{
    if (sender.selected) {
        [sender setSelected:FALSE];
    } else {
        [sender setSelected:TRUE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Function to draw the line between waypoints
-(void)draw {
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:dest count:2];
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
