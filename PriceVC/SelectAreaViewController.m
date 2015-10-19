//
//  SelectAreaViewController.m
//  ZhuanXB
//
//  Created by 康冬 on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "SelectAreaViewController.h"
//#import "HZAreaPickerView.h"
#import "FMDBTools.h"

@interface SelectAreaViewController ()
<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

{
    NSString *_areaCodeString;
    NSString *_areaNameString;
    NSMutableArray * _allNameArr;
    NSMutableDictionary *_allNameDic;
    
    BOOL _isClickPickerView;
    
    FMDBTools * tools;
}
@property (nonatomic,retain) NSArray * provinceArr;
@property (nonatomic,retain) NSArray * cityArr;
@property (nonatomic,retain) NSArray * countryArr;

//@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地区选择";
    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);;
    // Do any additional setup after loading the view.
    
    
//    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
//    backView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:backView];
    
    //地区控件
//    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
//    [self.locatePicker showInView:backView];
//    
//    
//    _ProVinceString = self.locatePicker.locate.state;
//    _CityString = self.locatePicker.locate.city;
//    _CountryString = self.locatePicker.locate.district;
//    
//    NSLog(@"%@,%@,%@",_ProVinceString,_CityString,_CountryString);
    
    _allNameArr = [[NSMutableArray alloc] initWithCapacity:0];
    _allNameDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    
    tools = [[FMDBTools alloc]init];
    [FMDBTools createDB];
    //省
    self.provinceArr  =[FMDBTools getProvinceFromChina];
    //    NSLog(@"%@",self.provinceArr);
    //市
    self.cityArr = [FMDBTools getCityFromChina:@"1"];
    //    NSLog(@"%@",self.cityArr);
    //区
    self.countryArr = [FMDBTools getCityFromChina:@"2"];
    //    NSLog(@"%@",self.countryArr);
    
    UIPickerView * pick = [[UIPickerView alloc]initWithFrame:CGRectMake(20, 0, 320, 300)];
    pick.showsSelectionIndicator=YES;
    pick.delegate = self;
    pick.dataSource = self;
    [self.view addSubview:pick];


    //添加确定按钮
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(10, pick.frame.origin.y+pick.frame.size.height+30, self.view.frame.size.width-20, 82/2);
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"时间选择确定按钮.png"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
}
-(void)getArea:(void (^)(NSString *,NSString*))myBlock
{
    if (self) {
        _backBlock = myBlock;
    }
}

-(void)sureBtnClick
{
    if (_isClickPickerView) {
        
    }else
    {
        _areaCodeString = [[self.countryArr objectAtIndex:0] objectForKey:@"barrio_code"];
    }
    _allNameArr = [FMDBTools getallNameFromChina:_areaCodeString];
    NSLog(@"%@",_allNameArr);
    _allNameDic = [_allNameArr objectAtIndex:0];
    _areaNameString = [NSString stringWithFormat:@"%@-%@-%@", [_allNameDic objectForKey:@"province"], [_allNameDic objectForKey:@"parent_name"], [_allNameDic objectForKey:@"name"]];
    NSLog(@"%@-----%@",_areaCodeString,_areaNameString);
    _backBlock(_areaCodeString,_areaNameString);
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component == 0)
    {
        return self.provinceArr.count;
        
    }else if (component == 1)
    {
        return self.cityArr.count;
    }
    else if (component == 2)
    {
        return self.countryArr.count;
    }
    
    return 5;
}
-(NSString * )pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        NSDictionary * dic = self.provinceArr[row];
        return [dic objectForKey:@"name"];
    }
    else if (component == 1)
    {
        NSDictionary * dic = self.cityArr[row];
        return [dic objectForKey:@"name"];
    }
    else if (component == 2)
    {
        NSDictionary * dic = self.countryArr[row];
        return [dic objectForKey:@"name"];
    }
    
    return @"sss";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _isClickPickerView = TRUE;
    
    if (component == 0)
    {
        //        获取当前选择省份的ids
        NSDictionary * dic = self.provinceArr[row];
        
        NSLog(@"%@",dic);
        
        //        获取当前选择市的ids
        self.cityArr = [FMDBTools getCityFromChina:[dic objectForKey:@"id"]];
        
        NSLog(@"%@",self.cityArr);
        
        [pickerView reloadComponent:1];
        
        
        //      获取当前选择区县的ids
        
        NSDictionary * cityDic = self.cityArr[0];
        self.countryArr = [FMDBTools getCityFromChina:[cityDic objectForKey:@"id"]];
        
        NSLog(@"%@",self.countryArr);
        if (self.countryArr.count==0) {
            
            _areaCodeString = [[self.cityArr objectAtIndex:0] objectForKey:@"barrio_code"];
            NSLog(@"%@",_areaCodeString);
        }else
        {
            _areaCodeString = [[self.countryArr objectAtIndex:0] objectForKey:@"barrio_code"];
            NSLog(@"%@",_areaCodeString);
        }
        
        [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    else if (component == 1)
    {
        
        NSDictionary * cityDic = self.cityArr[row];
        
        
        self.countryArr = [FMDBTools getCityFromChina:[cityDic objectForKey:@"id"]];
//        NSLog(@"%@",self.countryArr);
        if (self.countryArr.count==0) {
            
        }else
        {
            _areaCodeString = [[self.countryArr objectAtIndex:0] objectForKey:@"barrio_code"];
            NSLog(@"%@",_areaCodeString);
   
        }
        
        
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
    }
    else if (component == 2)
    {
        NSDictionary * countryDic = self.countryArr[row];
        NSLog(@"%@",self.countryArr);
        
        _areaCodeString = [countryDic objectForKey:@"barrio_code"];
        NSLog(@"%@",_areaCodeString);
        
        
    }
    
}


//#pragma mark - HZAreaPicker delegate
//-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
//{
//    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
//        _ProVinceString = picker.locate.state;
//        _CityString = picker.locate.city;
//        _CountryString = picker.locate.district;
//        
//        NSLog(@"%@,%@,%@",_ProVinceString,_CityString,_CountryString);
//    } else{
//        
//        
//    }
//}
//
//-(void)cancelLocatePicker
//{
//    [self.locatePicker cancelPicker];
//    self.locatePicker.delegate = nil;
//    self.locatePicker = nil;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
