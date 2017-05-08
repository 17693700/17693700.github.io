<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Product extends Controller
{
    public function product_category()
    {

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
        $m = Db::name('t_goods_catalog');
        $data=$m->select();

        $new_data = array();
        
        foreach($data as $key=>$val){
            $str = '';

            if($val['level'] > 1){
                for($i=1;$i<$val['level'];$i++){
                    $str .= '—';
                }

                $val['cat_name'] = $str.$val['cat_name'];
            }

            $new_data[$key] = $val;
        }

        $this->assign('data',$new_data);

        return $this->fetch();
    }

    public function product_list()
    {
        return $this->fetch();
    }


    public function category_add(){
        $data               = array();
        $data['parent_id']  = $_POST['parent_id'];
        $data['cat_name']       = $_POST['cat_name'];

        if($data['cat_name'] != ''){
            $m = Db::name('t_goods_catalog');
            $parent_data = $m->where('cat_id='.$data['parent_id'])->select();

            $data['level']      = $parent_data[0]['level'] + 1;

            $res = $m->insert($data);
            if($res){
                echo "<script>alert('添加成功！');parent.location.href='product_category'</script>";
            }else{
                echo "<script>alert('添加失败！');parent.location.href='product_category'</script>";
            }
        }else{
            echo "<script>alert('添加失败，内容不能为空！');parent.location.href='product_category'</script>";
        }
        
        

    }
   
}
