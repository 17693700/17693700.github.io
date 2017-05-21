<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Index extends Common
{
    public function index(){
    	$m = Db::name('auth_group_access');
    	$group_id = $m->where("uid=".session('user')['id']."")->value('group_id');

    	$g = Db::name('auth_group');
    	$admin_name = $m->where("id=$group_id")->value('title');

    	$this->assign('admin_name',$admin_name);

        return $this->fetch();
    }

    public function welcome(){
        return  $this->fetch();
    }
   
}
