//
//  MessagesViewController.m
//  MessagesExtension
//
//  Created by Tom on 16/8/1.
//  Copyright © 2016年 RookieTomWu. All rights reserved.
//

#import "MessagesViewController.h"
#import "StickerCollectionView.h"
#import "BrowserViewController.h"

@interface MessagesViewController ()
@property (weak, nonatomic) IBOutlet StickerCollectionView *collectionView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    __block typeof(self)weakSelf = self;
    self.collectionView.event1Block = ^{
        
        //发送文字
        [weakSelf.activeConversation insertText:@"Fuck the world if you are rich,otherwise fuck youself! --- 达则兼济天下，穷则独善其身！" completionHandler:^(NSError * _Nullable error) {
            //使用的时候的回调,做自己想做的事情
            if (error) {
                NSLog(@"文字发送--%@",error.localizedDescription);
            }
        }];
    };
    
    self.collectionView.event2Block = ^{
        
        //发送音频
        NSString *path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        [weakSelf.activeConversation insertAttachment:url withAlternateFilename:@"音乐" completionHandler:^(NSError * _Nullable error){
            if (error) {
                NSLog(@"音频发送--%@",error.localizedDescription);
            }
        }];
    };
    
    self.collectionView.event3Block = ^{
        
        //详细图片
        MSMessage *message = [[MSMessage alloc]init];
        MSMessageTemplateLayout *layout = [[MSMessageTemplateLayout alloc]init];
        layout.imageTitle = @"喵喵";
        layout.imageSubtitle = @"。。。。";
        layout.caption = @"喵";
        layout.subcaption = @"喵sub";
        layout.trailingCaption = @"汪";
        layout.trailingSubcaption = @"汪sub";
        NSString *path = [[NSBundle mainBundle]pathForResource:@"001" ofType:@"png"];
        layout.mediaFileURL = [NSURL fileURLWithPath:path];
        message.layout = layout;
        
        [weakSelf.activeConversation insertMessage:message completionHandler:^(NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"详情图文--%@",error.localizedDescription);
            }
        }];
    };
    
    self.collectionView.event4Block = ^{
        BrowserViewController *browserVC = [[BrowserViewController alloc] init];
        [self presentViewController:browserVC animated:YES completion:nil];
    };

}


#pragma mark - Conversation Handling

-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    // Use this method to configure the extension and restore previously stored state.
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the active to inactive state.
    // This will happen when the user dissmises the extension, changes to a different
    // conversation or quits Messages.
    
    // Use this method to release shared resources, save user data, invalidate timers,
    // and store enough state information to restore your extension to its current state
    // in case it is terminated later.
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when a message arrives that was generated by another instance of this
    // extension on a remote device.
    
    // Use this method to trigger UI updates in response to the message.
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the change in presentation style.
}

@end
