$(function(){

	$('#btn_invited').click(function(){
		var div = $('#div_invited');
		if (div.is(':hidden')) {
			$(this).find('strong:first').html('∨ ');
			$(this).find('strong:last').html('收起');
			div.show();
		} else {
			$(this).find('strong:first').html('＞');
			$(this).find('strong:last').html('展开');
			div.hide();
		}
	});
	if ($('#div_invited input').val()) {
		$('#btn_invited').click();
	}


	$('#checkcode').click(function(){
		$('input[name=code]').val('');
		$(this).attr('src',$(this).attr('_src') + "?m=" + new Date().getTime());
	}).click();

	$('#btnChangeCode').click(function(){
		$('#checkcode').click();
	});

	var input = $('#form_login').find('input');
	input.focus(function(){
		$(this).parent().addClass('enter-focus');
	}).blur(function(){
		$('#form_login span').hide();
		$(this).parent().removeClass('enter-focus');
	});

	var input = $('#form_login').find('input[name=code]');
	input.focus(function(){
		$(this).parent().parent().addClass('enter-focus');
	}).blur(function(){
		$('#form_login span').hide();
		$(this).parent().parent().removeClass('enter-focus');
	});

	$('#form_login').find('input').bind('keydown',function(e){
		if(e.keyCode==13){
			$('#btnAgreeBtn').click();
		}
	});

	// 禁止复制粘贴
	$("#form_login input[type=password]").bind("copy cut paste",function(e){
		return false;
	});

	var running = false;
	$('#btnAgreeBtn').click(function(){
		var url = $(this).attr('href');
		$.ajax({
			type: "POST",
			url: window.location.href,
			data: $('#form_login').serialize(),
			dataType: "json",
			beforeSend: function(){
				if (running) {
					return false;
				}
				running = true;
			},
			complete: function(){
				running = false;
			},
			error: function(request) {
				$('span[class=orange]:last').html("系统繁忙").show();
				$('#checkcode').click();
			},
			success: function(r) {
				if (r.status) {
					window.location.href = url;
				} else {
					var li = false;
					if (r.data.indexOf('手机号') > -1 || r.data.indexOf('邮箱') > -1) {
						li = $('#form_login').find('input[name=username]').parent();

					} else if (r.data.indexOf('密码') > -1) {
						li = $('#form_login').find('input[name=password]').parent();

					} else if (r.data.indexOf('验证码') > -1) {
						li = $('#form_login').find('input[name=code]').parent().parent();

					} else {
						li = $('#form_login').find('input[name=username]').parent();

					}
					li.addClass('enter-focus');
					li.find('span').html(r.data).show();
					$('#checkcode').click();

				}
			}
		});
		return false;
	});


});
