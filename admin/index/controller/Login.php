<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Login extends Controller
{
    public function login(){
        return $this->fetch();
    }

    public function login_decide(){
    	$username = input('username');
    	$password = input('password');
    	 
    	$m = Db::name('admin_user');

    	$res = $m->where("admin_name='".$username."' and password=".$password."")->find();
    	if($res){
    		session('user',$res);

    		$this->success('登录成功！','index/index/index');
    	}else{
    		$this->error('登录失败！请检查您的账号或密码。');
    	}
    }

    public function auth_error(){
        $this->error('没有权限！','index/index/welcome');
    }

   
}
