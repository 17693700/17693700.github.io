<?php
namespace app\index\controller;

use think\Controller;
use \org\Upload;

class Index extends Controller
{
    public function index(){
        return $this->fetch();
    }

    public function welcome(){
        return  $this->fetch();
    }

    public function goods_images_add(){
    	var_dump($_FILES);die;

    	$upload = new think\Upload();
    	$upload->maxSize = 3145728;
    	$upload->exts = array('jpg','gif','png','jpeg');
    	$upload->savePath = './Public/Uploads/';

    	//上传文件
    	$info = $upload->upload();

    	if(!$info){  //上传失败显示错误信息
    		$this->error($upload->getError());
    	}else{	//上传成功
    		$this->success('上传成功！');
    	}
    }
   
}
