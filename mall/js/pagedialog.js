(function(a) {
	a.PageDialog = function(c, q) {
		var g = {
			W: 710,
			H: 480,
			obj: null,
			oL: 0,
			oT: 0,
			close: true,
			autoClose: false,
			autoTime: 1500,
			title: "",
			BSize: 4,
			BColor: "#b4b4b4",
			BShow: true,
			cover: false,
			ready: function(e) {},
			submit: function() {}
		};
		var e = {
			obj: null,
			oL: 0,
			oT: 0,
			close: true,
			autoClose: false,
			autoTime: 1500,
			title: "",
			BSize: 4,
			BColor: "#b4b4b4",
			BShow: true,
			cover: false,
			ready: function(e) {},
			submit: function() {}
		};
		q = q || e;
		a.extend(g, q);
		var h = $("#pageDialog");
		var l = $("#pageDialogBG");
		var n = $("#pageDialogBorder");
		var i = $("#pageDialogMain");
		var o = $("#pageDialogClose");
		var b = a(window);
		if (g.obj != null) {
			if (g.obj.length < 1) {
				g.obj = null
			}
		}
		var f = function() {
			b.unbind("resize");
			i.empty();
			n.hide();
			l.hide();
			h.hide();
			g.submit()
		};
		if (g.title != "") {
			o.addClass("pageDialogClose2")
		}
		o.unbind().bind("click", f);
		if (!g.close) {
			o.hide()
		} else {
			o.show()
		}

		if (g.cover) {
			i = $(c);
			h.html(i);
		} else {
			c = '<div class="content">' + c + "</div>";
			if (g.title != "") {
				c = '<div class="title">' + g.title + "</div>" + c
			}
			i.html(c);
		}
		i.css({
				width: g.W + "px",
				height: g.H + "px"
		});
		n.css({
			opacity: 0.1,
			width: (h.width() + (g.BSize * 2 + 2)) + "px",
			height: (h.height() + (g.BSize * 2 + 2)) + "px"
		});
		if (g.obj != null) {
			var m = g.obj.offset();
			var d = m.left + g.oL;
			var p = m.top + g.obj.height() + g.oT;
			h.css({
				left: d,
				top: p
			});
			n.css({
				left: d - g.BSize,
				top: p - g.BSize
			})
		}
		var j = function() {
			var r = document.body.scrollWidth;
			if (b.width() > r) {
				r = b.width()
			} else {}
			l.css({
				opacity: 0.3,
				width: r + "px",
				height: a(document).height() > b.height() ? a(document).height() : b.height() + "px"
			})
		};

		var k = function() {
			j();
			if (g.obj != null) {
				return
			}
			var u = b.scrollTop();
			var s = b.scrollLeft();
			var t = (l.height() - g.H) / 2 + u;
			var r = (b.width() - g.W) / 2 + s;
			if (t < g.BSize) {
				t = g.BSize
			}
			if (r < g.BSize) {
				r = g.BSize
			}

			n.css("top", '30%');
			n.css("left", r - g.BSize);
			h.css("top", '30%');
			h.css("left", r);
		};
		k();
		b.resize(k);
		b.scroll(j);
		l.show();
		if (g.BShow) {
			n.show()
		}
		h.show();
		if (g.autoClose) {
			window.setTimeout(function() {
				a.PageDialog.close()
			},
			g.autoTime)
		}
		h.ready = g.ready(i);

		a.PageDialog.close = f;
	};

	a.PageDialog.showConfirm = function(e, b) {
		var c = '<div class="PopMsgC"><s></s>' + e + '</div><div class="PopMsgbtn"><a href="javascript:;" id="btnMsgOK" class="orangebut">确认</a>&nbsp;&nbsp;<a href="javascript:;" id="btnMsgCancel" class="cancelBtn">取消</a></div>';
		var d = function() {
			a("#btnMsgCancel").click(function() {
				a.PageDialog.close();
				return false;
			});
			a("#btnMsgOK").click(function() {
				a.PageDialog.close();
				b();
				return false;
			})
		};
		a.PageDialog(c, {
			title: "提示",
			W: 282,
			H: 146,
			ready: d
		})
	};

	a.PageDialog.confirm = function(txt, submit, cancel) {
		var c = '<div class="PageDialogAlert">' + txt + '</div><div class="PageDialogAlertBtn"><a href="javascript:;" id="btnMsgOK">确认</a>&nbsp;&nbsp;<a href="javascript:;" id="btnMsgCancel" class="cancelBtn">取消</a></div>';
		var d = function() {
			var keyup = function(e){
				if (e.which == 13 || e.which == 32) {
					a("#btnMsgOK").click();
					return false;
				} else if (e.which == 27) {
					a("#btnMsgCancel").click();
					return false;
				}
			};
			$(document).keyup(keyup);

			var the = $('#pageDialogMain');
			var div = the.find('.PageDialogAlert');
			the.height(the.height()+(div.height()-21));

			a("#btnMsgCancel").click(function() {
				$(document).unbind('keyup', keyup);
				a.PageDialog.close();
				if (cancel) {
					cancel();
				}
				return false;
			});
			a("#btnMsgOK").click(function() {
				$(document).unbind('keyup', keyup);
				a.PageDialog.close();
				if (submit) {
					submit();
				}
				return false;
			}).focus();
		};
		a.PageDialog(c, {
			title: "提示",
			W: 282,
			H: 146,
			ready: d
		})
	};

	a.PageDialog.alert = function(txt, callback, autoclose, css) {
		if ( typeof(callback)=='number' ) {
			if ( typeof(autoclose)=='function' ) {
				var tmp = autoclose;
				autoclose = callback;
				callback = tmp;
			} else {
				autoclose = callback;
				callback = undefined;
			}
		} else if ( typeof(autoclose)=='object' ) {
			css = autoclose;
			autoclose = false;
		}
		var c = '<div class="PageDialogAlert">' + txt + '</div><div class="PageDialogAlertBtn"><a href="javascript:;" id="btnMsgOK">确认</a></div>';
		a.PageDialog(c, {
			title: "提示",
			W: 282,
			H: 146,
			ready: function() {
				var keyup = function(e){
					if (e.which == 13 || e.which == 32 || e.which == 27) {
						a("#btnMsgOK").click();
						return false;
					}
				};

				var the = $('#pageDialogMain');
				var div = the.find('.PageDialogAlert');
				the.height(the.height()+(div.height()-21));
				if (css) {
					the.css(css);
				}
				$(document).keyup(keyup);

				a("#btnMsgOK").click(function() {
					$(document).unbind('keyup', keyup);
					a.PageDialog.close();
					return false;
				}).focus();
				if (autoclose) {
					setTimeout(function(){
						a("#btnMsgOK").click();
					}, autoclose);
				}
			},
			submit: function(){
				if (typeof(callback) == 'function') {
					callback();
				}
			}
		});
	};

})(jQuery);


