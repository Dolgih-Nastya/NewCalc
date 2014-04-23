//
//  NCCalcViewController.m
//  NewCalculator1
//
//  Created by Анастасия Долгих on 4/23/14.
//  Copyright (c) 2014 Anastasia. All rights reserved.
//

#import "NCCalcViewController.h"

@interface NCCalcViewController ()
//@property(nonatomic, strong) IBOutlet UIView *view;
@property BOOL isCalcOn;
@property BOOL isEngCalcOn; // otherwise ingenering calculator is on
@property (nonatomic, strong) IBOutlet UISegmentedControl *normalCalcSigns;
@property (nonatomic, strong) IBOutlet UISegmentedControl *engCalcSigns;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UILabel *resLabel;
@property NSString* firstNumber;
@property NSString* secondNumber;
@property NSString* result;
@property Sign sign;
@property BOOL isFirstNumberFilled;

@end

@implementation NCCalcViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)OnOffSwitchClick:(UISwitch*) sender
{
    self.isCalcOn = sender.on;
    [self refreshControls];
}

- (IBAction)EngNormalSwitchClick:(UISwitch*)sender
{
    self.isEngCalcOn = sender.on;
    [self refreshControls];
}

- (void)refreshControls
{
    if (!self.isCalcOn)
    {
        self.normalCalcSigns.enabled = NO;
        self.engCalcSigns.enabled = NO;
    }
    else if (!self.isEngCalcOn)
    {
        self.normalCalcSigns.enabled = YES;
        self.engCalcSigns.enabled = NO;
    }
    else
    {
        self.normalCalcSigns.enabled = YES;
        self.engCalcSigns.enabled = YES;
    }
}

- (IBAction)lengthSliderDidEndSliding:(UISlider*)sender
{
    double f = sender.value;
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:f/255 green:214./255 blue:200./255 alpha:1.0]];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textField.inputAccessoryView = keyboardDoneButtonView;
    return YES;
}

- (IBAction)doneClicked:(id)sender
{

    if (!self.isFirstNumberFilled)
    {
       self.firstNumber = self.textField.text;
       self.isFirstNumberFilled= YES;
    } else
    {
        self.secondNumber = self.textField.text;
    }
    self.result = [self.result stringByAppendingString:self.textField.text];
    self.resLabel.text = self.result;
    self.textField.text=@"";
    [self.view endEditing:YES];
}

- (IBAction)isButtonClick:(id)sender
{
    double value = [self Calculate];
    if (value == NAN)
    {
        self.result=@"Error";
    }else
    {
        self.result= [self.result stringByAppendingString:[NSString stringWithFormat:@"= %lf", value ]];
    }
    self.resLabel.text = self.result;
}

- (IBAction)SignButtonClick:(UISegmentedControl*)sender
{
    self.sign =  [sender tag] - 1000;
    NSString *sign = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.result = [self.result stringByAppendingString:sign];
    self.resLabel.text = self.result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isFirstNumberFilled = NO;
    self.firstNumber = @"";
    self.secondNumber = @"";
    self.result = @"";
    //self.isEngCalcOn = YES;
    //self.isCalcOn = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (double) Calculate
{
    double num1 = [self.firstNumber doubleValue];
    double num2 = [self.secondNumber doubleValue];
    switch (self.sign)
    {
        case plus:
        {
            return num1+num2;
            break;
        }
        case minus:
        {
            return num1-num2;
            break;
        }
        case multiply:
        {
            return num1*num2;
            break;
        }
        case divide:
        {
            if (num2!=0)
            {
              return num1/num2;
            } else
            {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Divide by zero" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show ];
                return NAN;
            }
            
            break;
        }
        case _sqrt:
        {
            return sqrt(num1);
            break;
        }
        case _sin:
        {
            return sin(num1);
            break;
        }
        case _cos:
        {
            return cos(num1);
            break;
        }
        case percent:
        {
            return 0; // TODO
            break;
        }
        default:
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect sign" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show ];
            return NAN;
        }
            
    }
}

@end
