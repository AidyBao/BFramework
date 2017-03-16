//
//  FMDBTestViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/14.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "WHC_FMDBTestViewController.h"
#import "WHC_ModelSqlite.h"
#import "Person.h"

@interface WHC_FMDBTestViewController ()
@property (nonatomic, weak)IBOutlet UILabel * detailLabel;
@property (nonatomic, weak)IBOutlet UIImageView * imageView;
@end

@implementation WHC_FMDBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailLabel.text = @"开发者:WHC(吴海超)\n\n专业的数据存储解决方案\n\n由于本开源库主要针对数据存储解决方案所以没有UI演示上面的图片是从sqlite里读取的\n\n测试者可以通过ViewController里测试用例进行断点查看\n\n觉得不错请给予star支持,你们的支持是对WHC最大的鼓励,谢谢";
    
    [WHCSqlite removeAllModel];
    
    /// 1.存储单个模型对象到数据库演示代码
    Person * person = [Person new];
    person.name = @"吴海超";
    person.age = 25;
    person.height = 180.0;
    person.weight = 140.0;
    person.isDeveloper = YES;
    person.sex = 'm';
    person.zz = @(100);
    person.type = @"android";
    
    /// 测试继承属性存储
    person.typeName = @"人";
    person.eat = YES;
    
    /// 测试NSArray属性存储
    Car * tempCar = [Car new];
    tempCar.name = @"宝马";
    tempCar.brand = @"林肯";
    person.array = @[@"1",@"2"];
    person.carArray = @[tempCar];
    
    /// 测试NSDictionary属性存储
    person.dict = @{@"1":@"2"};
    person.dictCar = @{@"car": tempCar};
    
    /// 存储图片
    person.data = UIImagePNGRepresentation([UIImage imageNamed:@"image"]);
    
    person.car = [Car new];
    person.car.name = @"撼路者";
    person.car.brand = @"大路虎";
    
    person.school = [School new];
    person.school.name = @"北京大学";
    person.school.personCount = 5000;
    person.school.city = [City new];
    person.school.city.name = @"北京";
    person.school.city.personCount = 1000;
    
    /// 线程安全测试
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        person.name = @"武汉";
        [WHCSqlite insert:person];
        NSLog(@"线程1.存储单个模型对象到数据库演示代码");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        person.name = @"北京";
        [WHCSqlite insert:person];
        NSLog(@"线程2.存储单个模型对象到数据库演示代码");
    });
    
    [WHCSqlite insert:person];
    NSLog(@"线程3.存储单个模型对象到数据库演示代码");
    
    /// 1.1查询上面存储的模型对象
    // where 参数为空查询所有, 查询语法和sql 语句一样
    NSArray * personArray = [WHCSqlite query:[Person class]
                                       where:@"name = '吴海超' and car.name = '宝马' or school.city.name = '北京'"];
    [personArray enumerateObjectsUsingBlock:^(Person *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"第%lu条数据",(unsigned long)idx);
        NSLog(@"name = %@",person.name);
        NSLog(@"age = %lu",person.age);
        NSLog(@"height = %f",person.height);
        NSLog(@"weight = %f",person.weight);
        NSLog(@"isDeveloper = %d",person.isDeveloper);
        NSLog(@"sex = %c",person.sex);
        NSLog(@"---------------------------------");
        self.imageView.image = [UIImage imageWithData:person.data];
    }];
    
    /// 2.批量存储模型对象到数据库演示代码
    
    NSArray * persons = [self makeArrayPerson];
    [WHCSqlite inserts:persons];
    NSLog(@"2.批量存储模型对象到数据库演示代码");
    
    /// 2.1 查询上面存储的模型对象演示代码
    
    personArray = [WHCSqlite query:[Person class]
                             where:nil];
    [personArray enumerateObjectsUsingBlock:^(Person *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"第%lu条数据",(unsigned long)idx);
        NSLog(@"name = %@",person.name);
        NSLog(@"age = %lu",person.age);
        NSLog(@"height = %f",person.height);
        NSLog(@"weight = %f",person.weight);
        NSLog(@"isDeveloper = %d",person.isDeveloper);
        NSLog(@"sex = %c",person.sex);
        NSLog(@"---------------------------------");
    }];
    
    /// 2.2 新增查询排序api(查询结果按age字段进行递减排序)
    personArray = [WHCSqlite query:[Person class] order:@"by age desc"];
    
    /// 2.2 条件查询存储的模型对象演示代码
    
    personArray = [WHCSqlite query:[Person class]
                             where:@"age > 30"];
    [personArray enumerateObjectsUsingBlock:^(Person *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"第%lu条数据",(unsigned long)idx);
        NSLog(@"name = %@",person.name);
        NSLog(@"age = %lu",person.age);
        NSLog(@"height = %f",person.height);
        NSLog(@"weight = %f",person.weight);
        NSLog(@"isDeveloper = %d",person.isDeveloper);
        NSLog(@"sex = %c",person.sex);
        NSLog(@"---------------------------------");
    }];
    
    /// 3.修改存储模型对象演示代码
    
    [WHCSqlite update:person
                where:@"name = '吴超1000' OR age >= 1000"];
    NSLog(@"修改批量模型对象成功");
    
    /// 3.1 查询刚刚修改是否成功示例代码
    
    personArray = [WHCSqlite query:[Person class]
                             where:@"age = 25 AND name = '吴海超'"];
    [personArray enumerateObjectsUsingBlock:^(Person *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"第%lu条数据",(unsigned long)idx);
        NSLog(@"name = %@",person.name);
        NSLog(@"age = %lu",person.age);
        NSLog(@"height = %f",person.height);
        NSLog(@"weight = %f",person.weight);
        NSLog(@"isDeveloper = %d",person.isDeveloper);
        NSLog(@"sex = %c",person.sex);
        NSLog(@"---------------------------------");
    }];
    
    /// 4.删除存储模型对象演示代码
    /*注 where 为空时则表示清空数据库*/
    [WHCSqlite delete:[Person class]
                where:@"age = 25 AND name = '吴海超'"];
    NSLog(@"删除批量模型对象成功");
    
    /// 4.1 查询刚刚删除是否成功示例代码
    personArray = [WHCSqlite query:[Person class] where:nil];
    [personArray enumerateObjectsUsingBlock:^(Person *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"第%lu条数据",(unsigned long)idx);
        NSLog(@"name = %@",person.name);
        NSLog(@"age = %lu",person.age);
        NSLog(@"height = %f",person.height);
        NSLog(@"weight = %f",person.weight);
        NSLog(@"isDeveloper = %d",person.isDeveloper);
        NSLog(@"sex = %c",person.sex);
        NSLog(@"---------------------------------");
    }];
    
    //    /// 5.1 清空数据库
    //    [WHCSqlite clear:[Person class]];
    //
    //    /// 9.1 获取数据库版本号
    //    NSString * version = [WHCSqlite versionWithModel:[Person class]];
    //    NSLog(@"version = %@",version);
    //
    //    /// 6.1 删除数据库
    //    [WHCSqlite removeModel:[Person class]];
    //
    //    /// 7.1删除本地所有数据库
    //    [WHCSqlite removeAllModel];
    
    /// 8.1 获取数据库本地路径
    NSString * path = [WHCSqlite localPathWithModel:[Person class]];
    NSLog(@"localPath = %@",path);
    
}

- (NSArray *)makeArrayPerson {
    NSMutableArray * personArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        Person * person = [Person new];
        person.name = [NSString stringWithFormat:@"吴海超--%d",i];
        person.age = 25 + i;
        person.height = 180.0 + i;
        person.weight = 140.0 + i;
        person.isDeveloper = YES;
        person.sex = 'm';
        person.type = @"ios";
        person.zz = @(i + 100);
        
        person.data = UIImagePNGRepresentation([UIImage imageNamed:@"image"]);
        
        person.car = [Car new];
        person.car.name = [NSString stringWithFormat:@"撼路者--%d",i];
        person.car.brand = [NSString stringWithFormat:@"大路虎--%d",i];
        
        person.school = [School new];
        person.school.personCount = 5000 + i;
        person.school.name = [NSString stringWithFormat:@"北京大学--%d",i];
        person.school.city = [City new];
        person.school.city.name = [NSString stringWithFormat:@"北京--%d",i];
        person.school.city.personCount = 1000 + i;
        [personArray addObject:person];
    }
    return personArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
