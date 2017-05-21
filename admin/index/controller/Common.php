<?php
namespace app\index\controller;

use think\Controller;
use think\Auth;

class Common extends Controller
{
    //当任何函数加载的时候都会调用此函数，类似于构造函数
    public function _initialize(){
         $uid = session('user')['id'];
         if(empty($uid)){
            $this->error('您还没有登录','index/login/login');
         }

         $AUTH = new \think\Auth();

         $request = \think\Request::instance();

        if(!$AUTH->check($request->module().'/'.$request->controller().'/'.$request->action(), session('user')['id'])){
            

            echo "<script>window.parent.location.href='".url('index/login/auth_error')."'</script>";
        }

    }

   
}
