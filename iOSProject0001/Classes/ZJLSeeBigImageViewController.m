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
    
    
    
    __block NSString *assetCollectionLocalIdentifer = nil;
    __block NSString *assetLocalIdentifer = nil;
    //保存图片到相机胶卷中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //创建图片的请求
        assetLocalIdentifer = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            ZJLLog(@"保存图片到相机胶卷中失败");
            return;
        }
        
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];;
        if (createdAssetCollection) {//相薄存在
            
            //添加图片到新建相薄中
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifer] options:nil].lastObject;
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                [request addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                    ZJLLog(@"添加图片失败");
                    return;
                } else{
                    
                }
            }];
            
        }else{//相薄不存在
            
            // 创建相薄
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                assetCollectionLocalIdentifer = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ZJLAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                    ZJLLog(@"创建相薄失败");
                    return;
                }
                
                //添加图片到新建相薄中
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifer] options:nil].lastObject;
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifer] options:nil].lastObject;
                    
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success == NO) {
                        ZJLLog(@"添加图片失败");
                        return;
                    } else{
                        
                    }
                }];
                
            }];
        }
        
        
        
    }];
    
    
}

- (PHAssetCollection *)createdAssetCollection{
    PHFetchResult<PHAssetCollection *> *assetCollections =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:ZJLAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    return nil;
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
