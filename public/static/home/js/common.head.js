if( window.self != window.top ) {
	window.top.location = window.self.location ;
}
var easyDialog  = new function(){
    this.dialogObj = null;
    /**
     * 创建遮罩层
     * @return { Object } 遮罩层
     */
    this.createOverlay = function(){
        var overlay = $("<div name='overlay' style='margin:0;padding:0;border:none;width:100%;height:2000px;background:#333;opacity:0.6; -moz-opacity: 0.6;filter:alpha(opacity=60);z-index:98;position:fixed;_position:absolute;top:0;left:0;'></div>");
        overlay.attr("id","overlay");
        return overlay;
    };
    /**
     * @param { Object } DOM元素
     */
    this.setPosition = function(dialogBoxObj){
        var  dialogBox = $(dialogBoxObj);
        var margin_top= -dialogBox.height()/2+"px";
        var margin_left  = -dialogBox.width()/2+"px";
        dialogBox.css({"marginLeft":margin_left,"marginTop":margin_top,"_position":"absolute","_marginLeft":margin_left,"_marginTop":margin_top,"_top":"50%","_left":"50%"});
        dialogBox.addClass("com_tan");
    };
    this.open = function(obj){

        var item = obj.container;
        var overlay = $("#overlay");
        // 如果页面中已经缓存遮罩层，直接显示
        if(overlay.length<=0){
            overlay = this.createOverlay();
            $("body").append(overlay);
        }
        var tar = $("#"+item);

        dialogObj = tar;
        tar.css({"border":"none","z-index":99})
        this.setPosition(tar);
        overlay.show();
        tar.show();
    };
    // 关掉某个弹窗
    this.close = function(){
        $("div[name='overlay']").hide();
        $("div.overlay").hide();
        $(dialogObj).hide();
    };
};


YG = {
	config:{
		lottery_ticket_check_time: 10000, // 倒计时揭晓 时时彩通信故障重试时间
		lottery_check_time: 1000, // 倒计时揭晓 检查开奖结果的间隔时间
		lottery_refresh_time_index: 5000, // [首页]页面每次读取最新开奖的间隔时间
		lottery_refresh_time_result: 5000, // [最新揭晓]页面每次读取最新开奖的间隔时间
		lottery_interval_time: 23,// 毫秒倒计时更新器的间隔时间
		shopping_time: 2000,// 正在云购 更新时间
		end: 0
	},

	_api_one: {},

	// 多个请求只生效一个，完成后下次请求才有效
	api_one: function(action, params ,callback){
		if (this._api_one[action]) {
			return;
		}

		this.api(action, params ,callback);
	},

	_api_cached: {},

	// 带缓存
	api_cached: function(action, params ,callback){
		if (!params) {
			params = {};
		}
		if (!callback) {
			callback = function(){};
		}
		if (typeof(params)=='function') {
			callback = params;
			params = {};
		}
		params['action'] = action;

		var key = $.param(params);
		if (this._api_cached[key]) {
			return callback(this._api_cached[key]);
		}

		$.ajax({
			type: "GET",
			url: '/api.do',
			dataType: 'json',
			cache: false,
			data: params,
			success: function(r){
				YG._api_cached[key] = r;
				callback(r);
			},
			complete: function(){
				delete YG._api_one[action];
			},
			beforeSend: function(){
				YG._api_one[action] = 1;
			}
		});
	},

	api: function(action, params ,callback){
		if (!params) {
			params = {};
		}
		if (!callback) {
			callback = function(){};
		}
		if (typeof(params)=='function') {
			callback = params;
			params = {};
		}
		params['action'] = action;

		$.ajax({
			type: "GET",
			url: '/api.do',
			dataType: 'json',
			cache: false,
			data: params,
			success: callback,
			complete: function(){
				delete YG._api_one[action];
			},
			beforeSend: function(){
				YG._api_one[action] = 1;
			}
		});
	},

	_events_data: {},
	_events_callback: {},
	get: function(key, callback){
		if (!callback) {
			return this._events_data[key];
		}
		if (typeof(this._events_data[key]) == 'undefined') {
			if ( typeof(this._events_callback[key]) == 'undefined' ) {
				this._events_callback[key] = new Array();
			}
			this._events_callback[key].push(callback);
		} else {
			callback(this._events_data[key]);
		}
	},
	set: function(key, data){
		this._events_data[key] = data;
		if (this._events_callback[key]) {
			var callback;
			while (callback = this._events_callback[key].shift()) {
				callback(data);
			}
		}
	},
	popLogin: {
		show : function() {
			var a = "<iframe name='fastLoginFrame' id='fastLoginFrame' frameborder='0' src='about:blank' style='width:390px;height:423px;padding:0px;overflow:auto;'></iframe>";
			$.PageDialog(a, {
				title: "",
				W: 390,
				H: 423
			});
			var b = $("#fastLoginFrame");
			b.ready(function() {
				var url = $('.m-toolbar-login-btn').attr('login-iframe');
				b.attr("src", url + "?forward=" + escape(location.href))
			});
			return b;
		},
		hide : function() {
			$.PageDialog.close()
		}
	}
};


$(function(){

	$('#zqjf_box_btn').click(function(){
		easyDialog.open({container: 'zqjf_box'});
		return false;
	});

	$('#zqjf_box a.zqjf-box-close').click(function(){
		easyDialog.close();
		return false;
	});

	// 顶部搜索
	$('#btnHSearch').click(function(){
		var key = $('#goods_search input[name=key]').val();
		if ( key.length == 0 ) {
			$('#goods_search input[name=key]').val($(this).attr('data-key'));
			key = $('#goods_search input[name=key]').val();
		}
		if ( key.length  > 0 ) {
			$('#goods_search').submit();
		}
		return false;
	});
	//加入收藏
	$("#btnTFavorite").click(function(){
		var title = $(this).attr('title');
		var url = $(this).attr('href');
		var ctrl=(navigator.userAgent.toLowerCase()).indexOf('mac')!=-1?'Command/Cmd': 'CTRL';
		if(document.all){
			window.external.addFavorite(url,title);
		}else if(window.sidebar){
			window.sidebar.addPanel(title,url, "");
		}else{
			$.PageDialog.alert('您可以通过快捷键' + ctrl + ' + D 加入到收藏夹');
		}
	});

	// 顶部分类导航
	$("#divGoodsSort").hover(function(){
		$("#divSortList").show();
	},function(){
		$("#divSortList").hide();
	});

	// 获取登录信息
	YG.api('member_info',function(r){
		YG.set('member_info', r.data);
	});

	// 更新昵称、头像
	YG.get('member_info', function(member){
		if (member) {
			$('#pro-view-8-niackname').find('.m-toolbar-nickname').text(member.nickname);
			$('#pro-view-8-niackname').show();
			$('.m-toolbar-myDuobao').find('a[type=login]').hide();
			$('.m-toolbar-myDuobao').find('a[type=register]').hide();
		} else {
			$('.m-toolbar-myDuobao').find('a[type=login]').show();
			$('.m-toolbar-myDuobao').find('a[type=register]').show();
		}
	});
	$('#ulTopRight a[type=login]').click(function(){
		YG.popLogin.show();
		return false;
	});
	$('#ulTopRight a[type=logout],#ulTopRight a[type=register]').click(function(){
		window.location.href=$(this).attr('href') + "?forward=" + escape(location.href);
		return false;
	});

	$('#rightTool li').hover(function(){
		$(this).addClass('cart-hover');
	},function(){
		$(this).removeClass('cart-hover');
	});

	$('#ulRToolList .f-back-to a').click(function(){ $('html, body').animate({scrollTop:0},200); });

	// 刷新购物车
	$.refreshCart = function(){
		var num = 0;
		for (var k in cart) {
			num=num+cart[k];
		}
		$('#pro-view-11').html(''+num);
	};
	// 加入购物车
	$.addCart = function(shopid, num){
		num = parseInt(num);
		if (!num || num<1) {
			num = 1;
		}
		if (cart[shopid]) {
			cart[shopid] = parseInt(cart[shopid]) + num;
		} else {
			cart[shopid] = num;
		}
		$.cookie('cart', cart, {path: '/' });
		$.refreshCart();
	};
	// 设置购物车
	$.setCart = function(_cart){
		if (!_cart) {
			_cart = {};
		}
		cart = _cart;
		$.cookie('cart', cart, {path: '/' });
		$.refreshCart();
	};
	// 调整购物车
	$.updateCart = function(shopid, num){
		num = parseInt(num);
		if (!num || num<1) {
			num=1;
		}
		cart[shopid] = num;
		$.cookie('cart', cart, {path: '/' });
		$.refreshCart();
	};
	// 删除购物车
	$.deleteCart = function(shopid){
		delete cart[shopid];
		console.log(cart);
		$.cookie('cart', cart, {path: '/' });
		$.refreshCart();
	};
	// 读取购物车
	$.cookie.json = true;
	var cart = $.cookie('cart');
	if (!cart) {
		cart = {};
	}
	$.refreshCart();

	// 顶部消息
	(function(){
		var notice = $('#banner-notice');
		if (notice.size()==0) {
			return;
		}
		var md5 = notice.attr('data-md5');
		var obj = notice.html();

		if (!obj || $.cookie('banner-notice') == md5) {
			return;
		}

		obj = $(obj);
		$('body').before(obj);
		obj.find('a.close').click(function(){
			$.cookie('banner-notice', md5, {path: '/' });
			obj.remove();
		});
	})();


	// 百度分享
	with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='//bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];


	$.loadimg = function(selector, now){
		var imgs;
		if (selector) {
			imgs = selector.find("img[data-src]");
		} else {
			imgs = $("img[data-src]");
		}
		if (imgs.size() == 0) {
			return;
		}

        var d = function() {
            return Math.max(document.documentElement.scrollTop, document.body.scrollTop)
        };
        var a = function() {
            return document.documentElement.clientHeight + d() + 100
        };
        var f = d();
        var g = f;
        var h = function() {
            imgs.each(function() {
				var i = $(this).attr("data-src");
                if (i && $(this).parent().offset().top <= a()) {
                    var src = $(this).attr("src");
                    $(this).attr("data-error", src).attr("src", i).removeAttr("data-src").show();
                }
            }).error(function(){
				 var src = $(this).attr("data-error");
				 if (src) {
					$(this).removeAttr("data-error").attr("src", src);
				 }
			});
        };
        $(window).bind("scroll", function() {
            g = d();
            if (g - f > 50) {
                f = g;
                h();
            }
        });
        h();

		return;
		if ( !$ || !$.fn || !$.fn.lazyload ) {
			return
		}
		var imgs;
		if (selector) {
			imgs = selector.find("img[data-src]");
		} else {
			imgs = $("img[data-src]");
		}
		if (imgs.size() == 0) {
			return;
		}
		if (now) {
			imgs.each(function(j) {
				var the = $(this);
				var src = the.attr("data-src");
				if (src) {
					the.removeAttr("data-src").attr("src", src).show();
				}
			});
		} else {
			imgs.lazyload({
				data_attribute:"src",
				skip_invisible:false,
				threshold:100,
				effect: "fadeIn"
			});
		}
	};

	$.loadimg();


	$('#m-copyright-logo a').click(function(){
		var url = $(this).attr('href');
		if (url.indexOf('.yunaq.') != -1 || url.indexOf('/ lz/') != -1 || url.indexOf('.360.') != -1) {

		} else if (url.indexOf('/lz/') == -1) {
			return false;

		} else {
			url = url.replace('/lz/', '/ lz/');
			$(this).attr('href', url);
		}
	});
});


