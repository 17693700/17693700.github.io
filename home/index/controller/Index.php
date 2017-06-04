<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Index extends Controller
{
    public function index()
    {
        $yjfl = $this->yjfl();
        $goods_data = $this->getGoods($yjfl);

        $this->assign('catalog',$yjfl);
        $this->assign('goods_data',$goods_data);
        
        return $this->fetch();
    }

    public function lists()
    {
        $cat_id = input('id');

        $ejfl = Db::name('t_goods_catalog')->where('level>=2 and parent_id='.$cat_id)->select();
        foreach($ejfl as $val){
            $cat_id .= ','.$val['cat_id'];
        }

        $db = Db::name('t_goods_thread');
        $goods = $db->where('cat_id in('.$cat_id.')')->select();             

        $res = $this->yjfl();

        $this->assign('catalog',$res);
        $this->assign('goods',$goods);

        return $this->fetch();
    }

    public function article()
    {
        $goods_id = $_GET['id'];

        $db = Db::name('t_goods_catalog');
        $res = $db->where('level=1')->select();

        $goods = Db::name('t_goods_thread')->where('goods_id='.$goods_id)->find();

        $this->assign('goods',$goods);
        $this->assign('catalog',$res);

        return $this->fetch();
    }

    public function yjfl()
    {   
        $m = Db::name('t_goods_catalog');
        $res = $m->where('level=1')->select();

        return $res;
    }

    public function getGoods($goods_data){
        
        foreach($goods_data as $key=>$val){
            $cat_id = $val['cat_id'];
            
            $ejfl = Db::name('t_goods_catalog')->where('level>=2 and parent_id='.$val['cat_id'])->select();
            foreach($ejfl as $v){
                $cat_id .= ','.$v['cat_id'];
            }

            $db = Db::name('t_goods_thread');
            $goods = $db->where('cat_id in('.$cat_id.')')->limit('4')->select(); 

            $goods_data[$key]['items'] = $goods;

            
        }

        return $goods_data;
    }

   
}
