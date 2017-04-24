$(function(){

	var input = $('#form_login').find('input[name=username],input[name=password],input[name=code]');
	input.focus(function(){
		$(this).parent().addClass('enter-focus');

	}).blur(function(){
		$(this).parent().removeClass('enter-focus');
		$('#dd_error_msg').hide();

	}).bind('keydown',function(e){
		if(e.keyCode==13){
			$('#btnSubmitLogin').click();
		}
	});

	// 禁止复制粘贴
	$("#form_login input[name=password]").bind("copy cut paste",function(e){
		return false;
	});

	// 验证码
	$('#yzm_refresh').click(function(){
		$(this).attr('src', $(this).attr('src2') + "?m=" +(new Date).getTime());
		$('#txtCode').val('');
	}).click();

	// 点击登录
	var running = false;
	$('#btnSubmitLogin').click(function(){
		var url = $('#form_login').attr('action');
		var forward = $(this).attr('href');
		$.ajax({
			type: "POST",
			url: url,
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
				$('#dd_error_msg').html("<i class='passport-icon transparent-png'></i>系统繁忙").show();
			},
			success: function(r) {
				if (r.status) {
					if ( typeof(r.data.check)!= "undefined"  ) {
						top.location.href = r.data.check;
					} else {
						$('#dd_error_msg').html("登录成功！").show();
						if ( forward.indexOf('#') > 0 ) {
							if (window.parent) {
								window.parent.location.reload();
							} else {
								window.location.reload();
							}
						} else {
							if (window.parent) {
								window.parent.location.href = forward;
							} else {
								window.location.href = forward;
							}
						}
					}
				} else {
					$('#dd_error_msg').html('<i class="passport-icon transparent-png"></i>'+r.data).show();
					$('#yzm_refresh').click();
				}
			}
		});
		return false;
	});

	$('#wechatoauth').click(function(){
		$('#wxLogin').show();

		var a = {
			id: "p_code",
			appid: $("#WxAppID").val(),
			scope: "snsapi_login",
			redirect_uri: escape(document.location.protocol + "//"+document.domain+"/user/oauth.do?which=wechat_open"),
			state: $("#state").val(),
			style: "",
			href: document.location.protocol + "//ycdn.2i3.cn/web/css/user.login.css"
		};

        var d = document.location.protocol + "//open.weixin.qq.com/connect/qrconnect?appid=" + a.appid + "&scope=" + a.scope + "&redirect_uri=" + a.redirect_uri + "&state=" + a.state + "&login_type=jssdk";
        d += a.style ? "&style=" + a.style : "";
		d += a.href ? "&href=" + a.href : "";

		var c = document.createElement("iframe");
		c.src = d;
		c.frameBorder = "0";
		c.allowTransparency = "true";
		c.scrolling = "no";
		c.width = "300px";
		c.height = "400px";

		var e = document.getElementById(a.id);
		e.innerHTML = "";
		e.appendChild(c);

	});
	$('#a_return').click (function () {
		$('#wxLogin').hide();
	});

});
