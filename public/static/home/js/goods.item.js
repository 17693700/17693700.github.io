$(function(){
	//商品大图
	$("ul.w-gallery-thumbnail-list li").mouseenter(function(){
		var big = $(this).find('img').attr('src-big');
		$('div.w-gallery-picture img').attr('src', big);

		var len = $(this).index() * 86 + 32;
		$('i.ico').animate({left:len +"px"}, 50);

		$('ul.w-gallery-thumbnail-list li').removeClass('w-gallery-thumbnail-item-selected');
		$(this).addClass('w-gallery-thumbnail-item-selected');
	});
	$('ul.w-gallery-thumbnail-list li:first').mouseenter();

	// 点击数量
	var numRuner = false;
	var numInput = $('#buyNumbers input.w-number-input');
	$('#buyNumbers a.w-number-btn').click(function(){
		var plus = $(this).hasClass('w-number-btn-plus');
		var num = parseInt(numInput.val());
		if (plus) {
			num++;
		} else {
			num-- ;
		}
		numInput.val(num+"");
		numInput.blur();
		return false;
	}).mousedown(function(){
		var the = $(this);
		var i=0;
		if (numRuner) {
			clearTimeout(numRuner);
		}
		numRuner = setInterval(function(){
			if (++i>3) {
				the.click();
			}
		}, 80);

	}).mouseup(function(){
		if (numRuner) {
			clearTimeout(numRuner);
			numRuner = false;
		}
	});
	numInput.blur(function(){
		var num = parseInt(numInput.val());
		if (!num) {
			num=1;
		}
		if (num<0) {
			num=1;
		}
		numInput.val(num+"");
	}).focus(function(){
		if (numRuner) {
			clearTimeout(numRuner);
			numRuner = false;
		}
	});

	var goods_sid = $('#data-goods_sid').val();

	// 立即云购
	$('#quickBuy').click(function(){
		var num = parseInt(numInput.val());
		$.addCart(goods_sid, num);
		window.location.href=$('.w-miniCart a[class=w-miniCart-btn]').attr('href');
		return false;
	});

	// 加入购物车
	$('#addToCart').click(function(){
		var num = parseInt(numInput.val());
		$.addCart(goods_sid, num);

		return false;
	});

})