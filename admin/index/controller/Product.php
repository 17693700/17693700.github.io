<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Product extends Controller
{
    public function product_category()
    {
        $m = Db::name('t_goods_catalog')->where('cat_id',2)->find();
        var_dump($m);

        echo Db::table('t_goods_catalog')->where('cat_id',1)->value('cat_name');

        return $this->fetch();
    }

    public function product_add()
    {
        return $this->fetch();
    }

    public function product_brand()
    {
        return $this->fetch();
    }

    public function product_category_add()
    {
        return $this->fetch();
    }

    public function product_list()
    {
        return $this->fetch();
    }
   
}
