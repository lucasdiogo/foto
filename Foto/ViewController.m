//
//  ViewController.m
//  Foto
//
//  Created by XCODE on 30/06/17.
//  Copyright © 2017 XCODE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation ViewController{
    BOOL newMedia;
    CGFloat escalaInicial;
    CGFloat outraEscala;
    CGPoint translacao;
    CGPoint deslocamento;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    escalaInicial = self.imageView.transform.a;
    outraEscala = self.imageView.frame.size.width / self.logoImageView.frame.size.width;
    
    deslocamento = CGPointZero;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)capturar:(id)sender {
    UIImagePickerController * imagePicker = [UIImagePickerController new];
    
    imagePicker.delegate = self;
    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        newMedia = YES;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:imagePicker animated: YES completion: nil];
}

#pragma mark - Camera

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    [self dismissViewControllerAnimated:YES completion: nil];
    
    self.imageView.image = image;
}

- (IBAction)redimensionar:(UIPinchGestureRecognizer *)sender {
    CGFloat novaEscala = escalaInicial * sender.scale;
    
    if([sender state] == UIGestureRecognizerStateEnded){
        escalaInicial = novaEscala;
        
        outraEscala = sender.view.frame.size.width / self.imageView.frame.size.width;
    }
    else{
        if(sender.view){
            CGAffineTransform transform =CGAffineTransformMakeScale(novaEscala, novaEscala);
            
            sender.view.transform = transform;
        }
    }
}

- (IBAction)arrastar:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.logoImageView];
    
    if(sender.view) {
        sender.view.center = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y + translation.y);
        
//        deslocamento = CGPointMake(deslocamento.x + translacao.x, deslocamento.y + translacao.y);
        
    }
    
    [sender setTranslation:CGPointZero inView: self.imageView];
    
    translacao = translation;
}

@end
