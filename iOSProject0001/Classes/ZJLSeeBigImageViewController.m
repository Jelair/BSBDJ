//
//  ZJLSeeBigImageViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 16/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLSeeBigImageViewController.h"
#import "ZJLTopic.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface ZJLSeeBigImageViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation ZJLSeeBigImageViewController

static NSString * const ZJLAssetCollectionTitle = @"bsbdj";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    //添加视图到最里层
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            return;
        }
        
        self.saveBtn.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    if (imageView.height >= scrollView.height) {
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    } else{
        imageView.centerY = scrollView.height * 0.5;
    }
    
    self.imageView = imageView;
    
    //缩放比例
    CGFloat scale = self.topic.width / imageView.width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    //UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {
        [SVProgressHUD showErrorWithStatus:@"因为系统原因，无法访问相册"];
    }else if(status == PHAuthorizationStatusDenied){
        ZJLLog(@"提醒用户去【设置-隐私-照片-xxx】打开访问开关");
    }else if(status == PHAuthorizationStatusAuthorized){
        [self saveImage];
    }else if(status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage{
    
    __block NSString *assetLocalIdentifer = nil;
    //保存图片到相机胶卷中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //创建图片的请求
        assetLocalIdentifer = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存失败"];
            return;
        }
        
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        
        if (createdAssetCollection == nil) {
            [self showError:@"创建相薄失败"];
            return;
        };
        //添加图片到新建相薄中
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifer] options:nil].lastObject;
            //添加图片到相薄的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            //添加图片到相薄
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存失败"];
            } else{
                [self showSuccess:@"保存成功"];
            }
        }];
    }];
}



/**
 获得相薄

 @return PHAssetCollection
 */
- (PHAssetCollection *)createdAssetCollection{
    //从已存在相薄中查找这个应用对应的相薄
    PHFetchResult<PHAssetCollection *> *assetCollections =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:ZJLAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    //错误信息
    NSError *error = nil;
    
    //没有找到对应相薄，创建新的相薄
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //创建相薄的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ZJLAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        return nil;
    }
    
    //返回刚才创建的相薄
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:error];
    });
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
//    } else{
//        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
//    }
//}

#pragma mark - <UIScrollViewDelegate>
/* 返回一个scrollView的子控件进行缩放 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


@end
