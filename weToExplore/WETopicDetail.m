//
//  WETopicCellDetail.m
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WETopicDetail.h"

//{
//    "id" : 295993,
//    "title" : "炒股到那家开户好？",
//    "url" : "http://www.v2ex.com/t/295993",
//    "content" : "宝宝在帝都当农民工，突然觉得的乏味了，日常无聊的很，所以想着，买买股票玩话（三分钟热度那种）\u000D\u000A以前有过一个证券公司的帐户，但是……，反正彼时那绑的银行卡都注销了，至于帐户，宝宝发 4 一定还在脑子的某个角落里，一定的。\u000D\u000A刚刚看了一圈，好像是可以一个人在多家证券公司开户了，但是发现原来有这么多的证券公司，倒底选那家好呐？\u000D\u000A\u000D\u000A宝宝的需求是，也就放几 K 在里面玩玩，赔光为止。\u000D\u000A话说，几 K 能不能炒外汇？\u000D\u000A听说这个好玩的很，就是不知道作为屌丝的宝宝能玩的起不。",
//    "content_rendered" : "宝宝在帝都当农民工，突然觉得的乏味了，日常无聊的很，所以想着，买买股票玩话（三分钟热度那种）\u000D\u003Cbr /\u003E以前有过一个证券公司的帐户，但是……，反正彼时那绑的银行卡都注销了，至于帐户，宝宝发 4 一定还在脑子的某个角落里，一定的。\u000D\u003Cbr /\u003E刚刚看了一圈，好像是可以一个人在多家证券公司开户了，但是发现原来有这么多的证券公司，倒底选那家好呐？\u000D\u003Cbr /\u003E\u000D\u003Cbr /\u003E宝宝的需求是，也就放几 K 在里面玩玩，赔光为止。\u000D\u003Cbr /\u003E话说，几 K 能不能炒外汇？\u000D\u003Cbr /\u003E听说这个好玩的很，就是不知道作为屌丝的宝宝能玩的起不。",
//    "replies" : 2,
//    "member" : {
//        "id" : 2089,
//        "username" : "wolfan",
//        "tagline" : "新疆新疆新疆人家想到新疆娶个妹纸~！",
//        "avatar_mini" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_mini.png?m=1415852720",
//        "avatar_normal" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_normal.png?m=1415852720",
//        "avatar_large" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_large.png?m=1415852720"
//    },
//    "node" : {
//        "id" : 12,
//        "name" : "qna",
//        "title" : "问与答",
//        "title_alternative" : "Questions and Answers",
//        "url" : "http://www.v2ex.com/go/qna",
//        "topics" : 73432,
//        "avatar_mini" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_mini.png?m=1469612548",
//        "avatar_normal" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_normal.png?m=1469612548",
//        "avatar_large" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_large.png?m=1469612548"
//    },
//    "created" : 1469859999,
//    "last_modified" : 1469859999,
//    "last_touched" : 1469861192
//},

@implementation WETopicDetail

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    self.topicID = [dic objectForKey:@"id"];
    self.topicTitle = [dic objectForKey:@"title"];
    self.topicContent = [dic objectForKey:@"content"];
    self.topicReplies = [dic objectForKey:@"replies"];
    self.memberInfo = [dic objectForKey:@"member"];
    self.nodeInfo = [dic objectForKey:@"node"];
    self.createTime = [dic objectForKey:@"created"];
    self.replyTime = [dic objectForKey:@"last_touched"];
    
    return self;
}

@end
