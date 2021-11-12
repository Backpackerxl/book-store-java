import { Comment } from './map-comment-reduce.js';
$(function () {
    const replayCompement = [{
        "id": 1,
        "name": "backpackerxl",
        "user_img": "/img/man.png",
        "content": "for every developer who loves javascript ,this book is very good !for every developer who loves javascript ,this book is very good !",
        "createTime": "2021-11-5",
        "product_id": 2,
        "parent_comment_id": null
    }, {
        "id": 2,
        "name": "alice",
        "user_img": "/img/elyse.png",
        "content": "for every developer who loves javascript ,this book is very good !",
        "createTime": "2021-11-5",
        "product_id": 2,
        "parent_comment_id": null
    }, {
        "id": 3,
        "name": "Tom",
        "user_img": "/img/man.png",
        "content": "this book is very good !",
        "createTime": "2021-11-6",
        "product_id": 2,
        "parent_comment_id": null
    }, {
        "id": 4,
        "name": "luck",
        "user_img": "/img/man.png",
        "content": "nice nice nice !",
        "createTime": "2021-11-2",
        "product_id": 2,
        "parent_comment_id": 1
    }, {
        "id": 5,
        "name": "judy",
        "user_img": "/img/elyse.png",
        "content": "very nice , yes yes !",
        "createTime": "2021-11-5",
        "product_id": 2,
        "parent_comment_id": 1
    }, {
        "id": 6,
        "name": "alice",
        "user_img": "/img/man.png",
        "content": "oh my god ! this very intertesing",
        "createTime": "2021-11-1",
        "product_id": 2,
        "parent_comment_id": 4
    }, {
        "id": 7,
        "name": "luck",
        "user_img": "/img/man.png",
        "content": "nice nice nice !",
        "createTime": "2021-11-2",
        "product_id": 2,
        "parent_comment_id": 6
    }, {
        "id": 8,
        "name": "judy",
        "user_img": "/img/elyse.png",
        "content": "very nice , yes yes !",
        "createTime": "2021-11-5",
        "product_id": 2,
        "parent_comment_id": 6
    }, {
        "id": 9,
        "name": "小白",
        "user_img": "/img/man.png",
        "content": "very nice , yes yes ,no,no,no!",
        "createTime": "2021-11-5",
        "product_id": 2,
        "parent_comment_id": 2
    }, {
        "id": 10,
        "name": "小明",
        "user_img": "/img/man.png",
        "content": "very nice , yes yes ,no,no,no!",
        "createTime": "2021-11-6",
        "product_id": 2,
        "parent_comment_id": 9
    }, {
        "id": 11,
        "name": "小红",
        "user_img": "/img/elyse.png",
        "content": "you are welcome",
        "createTime": "2021-11-7",
        "product_id": 2,
        "parent_comment_id": 3
    },
    {
        "id": 12,
        "name": "小朱",
        "user_img": "/img/elyse.png",
        "content": "you are welcome",
        "createTime": "2021-11-8",
        "product_id": 2,
        "parent_comment_id": 11
    }];
    /**
     * 显示回复模块
     * @param {*用户头像} img_user 
     * @param {*待回复人的姓名} index 
     * @param {*回复模块要显示的位置} position 
     */
    function showReplay(img_user, index, position) {
        const templ = `
                        <div id="replay-input">
                                <div class="add-compents">
                                    <div id="close-replay" class="user-img">
                                    <img src=${img_user}>
                                    </div>
                                    <textarea id="compents-input" placeholder="回复${replayCompement[index].name}" maxlength="1000"></textarea>
                                    <button>回复</button>
                                </div>
                        </div>`
        $('.compents #replay-input').remove();
        position.append(templ)
        $("#close-replay").click(function () {
            $('.compents-box #replay-input').slideUp(90,function(){
                $(this).remove();
            });
        })
    }
    /**
     * 用返回的评论模块的数据模型，来驱动评论信息的视图渲染
     */
    function showCompements() {
        new Comment(replayCompement).mapReduce().forEach(compemnet => {
            const templmaster = `<div class="compents-box">
                                    <div class="compents-img">
                                         <img src=${compemnet.user_img}>
                                    </div>
                                    <div class="compents-content">
                                         <p>${compemnet.name}</p>
                                         <p>${compemnet.content}</p>
                                         <p>
                                            <span><i class="fa fa-calendar-minus-o"></i>${compemnet.createTime}</span>
                                            ${compemnet.childrenComment.length > 0 ? `<b id="more-compents">— 展开${compemnet.childrenComment.length}条回复 <i class="fa fa-caret-down"></i></b>` : ''}
                                            <a data-index=${compemnet.id} id="reply-compents" href="javascript:;">回复</a>
                                         </p>
                                    </div>
                                    <div style="display: none;" id="child-compents">
                                        ${showChildCompement(compemnet.childrenComment, compemnet.id)}
                                    </div>
                                    </div>
                                </div>`
            $(".compents").append(templmaster)
        })
        /**
         * 回复按钮的点击事件
         */
        $(".compents #reply-compents, #child-compents #reply-compents-child").click(function (e) {
            const img_user = $("#img-user img").attr('src')
            const index = parseInt(e.target.dataset.index) - 1
            showReplay(img_user, index, $(this).parent().parent().parent())
        })
    }
    showCompements() //调用显示评论信息的函数，进行渲染评论信息视图
    /**
     * 
     * @param {*子级评论数组} childArray 
     * @param {*父级评论的id} selectIndex 
     * @returns 以文档碎片的形式返回一个子级评论的html元素的字符串
     */
    function showChildCompement(childArray, selectIndex) {
        let childFragment = ''
        childArray.forEach(comment => {
            const resname = comment.parent_comment_id === selectIndex ? "" : `@${replayCompement[comment.parent_comment_id - 1].name}`
            childFragment += `<div class="compents-box">
            <div class="compents-img">
                 <img src=${comment.user_img}>
            </div>
            <div class="compents-content">
                 <p>${comment.name} ${resname}</p>
                 <p>${comment.content}</p>
                 <p>
                 <span><i class="fa fa-calendar-minus-o"></i>${comment.createTime}</span>
                 <a data-index=${comment.id} id="reply-compents-child" href="javascript:;">回复</a>
                 </p>
            </div>
        </div>`
        })
        return childFragment;
    }
    /**
     * 显示或隐藏子级评论信息
     */
    $(".compents-box #more-compents").click(function () {
        const childnode = $(this).parent().parent().next();
        if(childnode.is(':hidden')){
            childnode.slideDown(200)
            const upInfo = $(this).html().replace('展开','收起').replace('fa-caret-down','fa-caret-up');
            $(this).html(upInfo);
        }else{
            childnode.slideUp(200)
            const downInfo = $(this).html().replace('收起','展开').replace('fa-caret-up','fa-caret-down');
            $(this).html(downInfo);
        }
    })
});

