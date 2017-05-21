<?php
namespace app\index\controller;

use think\Controller;
use think\Db;
use \org\Auth;

class User extends Controller
{
    public function index(){
        return $this->fetch();
    }

    public function role_list(){
    	$m = Db::name('auth_group');
    	$res = $m->select();

    	$this->assign('res',$res);
    	return $this->fetch();
    }

    public function role_add(){
    	$m = Db::name('auth_rule');
    	$query_rows = $m->select();

    	$this->assign('query_rows',$query_rows);
    	
    	return $this->fetch();
    }

    public function role_append(){
    	$data = array();
    	$data['title'] = input('role_name');
		$data['rules'] = implode(",", $_POST['permission_check']);
		$data['status'] = 1;

		$m=Db::name('auth_group');

		$result=$m->insert($data);

		if($result){
		    return $this->success("成功","role_list",1);
		}else{
		    return $this->error("失败");
		}
    }

    public function permission_list(){
    	$m = Db::name('auth_rule');
    	$query_rows = $m->select();

    	$this->assign('query_rows',$query_rows);

    	return $this->fetch();
    }

    public function permission_add(){
    	return $this->fetch();
    }

    public function permission_append(){
    	$name  = input('permission_name');
    	$url   = input('permission_url');

    	$m = Db::name('auth_rule');

    	$data = array();

    	$data['name'] = $url;
    	$data['title'] = $name;
    	$data['type'] = 1;
    	$data['status'] = 1;
    	$data['condition'] = '';

    	$res = $m->insert($data);

    	if($res){
    		$this->success('添加成功！','permission_list',1);
    	}else{
    		$this->error('添加失败！','permission_add',1);
    	}
    }

    public function admin_list(){
    	$m = Db::name('admin_user');
    	$query_rows = $m->select();

    	$this->assign('query_rows',$query_rows);

    	return $this->fetch();
    }

    public function admin_add(){
    	$m = Db::name('auth_group');

    	$group = $m->where('status=1')->order('id desc')->select();

    	$this->assign('group',$group);

    	return $this->fetch();
    }

    public function admin_append(){
    	$adminName  = input('adminName');
    	$password   = input('password');
    	$group_id   = input('group_id');

    	$m = Db::name('admin_user');
    	$data = array();
    	$data['admin_name'] = $adminName;
    	$data['password'] = $password;

    	$name = $m->where('admin_name="'.$data['admin_name'].'"')->find();

    	if(!$name){
    		$res = $m->insert($data);

    		$new_user = $m->where('admin_name="'.$data['admin_name'].'"')->find();

	    	$g = Db::name('auth_group_access');
	    	$g_data = array();
	    	$g_data['uid'] = $new_user['id'];
	    	$g_data['group_id'] = $group_id;

	    	$res2 = $g->insert($g_data);

	    	if($res && $res2){
	    		$this->success('添加成功！','admin_list',1);
	    	}else{
	    		$this->error('添加失败！','admin_add',1);
	    	}

    	}else{
    		$this->error('很抱歉，该用户名已存在！');
    	}
    	
    }


}
