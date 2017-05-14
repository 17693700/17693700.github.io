<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Product extends Controller
{
    public function product_category()
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

    public function product_category_del(){
        $cat_id = $_POST['cat_id'];

        $m = Db::name('t_goods_catalog');
        $data = $m->where('parent_id='.$cat_id)->find();

        if($data){
            echo "该分类下面有子分类，不允许删除";
        }else{
            $res = $m->delete($cat_id);
            if($res){
                echo 1;
            }
        }
    }

    //获取分类数据
    public function product_category_ajax()
    {
        $m = Db::name('t_goods_catalog');
        $data=$m->field('cat_id,path,cat_name')->select();

        echo json_encode($data);
    }

    public function product_add()
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

        $m2 = Db::name('t_goods_thread');
        $goods = $m2->select();
        $this->assign('goods',$goods);
        
        return $this->fetch();
    }

    public function goods_add(){
        $data = array();
        $data['goods_name'] = input('goods_name');
        $data['cat_id'] = input('cat_id');
        $data['order_id'] = input('order_id');
        $data['price'] = input('price');
        $data['service'] = input('service');
        $data['summary'] = input('summary');
        $data['content'] = input('editorValue');
        $data['thumbnail'] = '';
        $data['popularity'] = 0;
        $data['sales'] = 0;
        $data['addtime'] = date('Y-m-d h:i:s');

        $m = Db::name('t_goods_thread');
        $res = $m->insert($data);

        if($res){
            $this->success('添加商品成功！','product_add','',2);
        }else{
            $this->error('添加失败！','product_add','',2);
        }

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

    public function product_edit(){
        $goods_id = input('goods_id');
        $cat_id = input('cat_id');

        $db = Db::name('t_goods_thread');
        $goods = $db->find($goods_id);

        $this->assign('goods',$goods);
        $this->assign('cat_id',$cat_id);


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

    public function goods_edit(){
        $goods_id = input('goods_id');
        
        $data = array();
        $data['goods_name'] = input('goods_name');
        $data['cat_id'] = input('cat_id');
        $data['order_id'] = input('order_id');
        $data['price'] = input('price');
        $data['service'] = input('service');
        $data['summary'] = input('summary');
        $data['content'] = input('editorValue');
        $data['thumbnail'] = '';
        $data['popularity'] = 0;
        $data['sales'] = 0;
        $data['addtime'] = date('Y-m-d h:i:s');

        $m = Db::name('t_goods_thread');
        $res = $m->where("goods_id=".$goods_id)->update($data);

        if($res){
            $this->success('修改商品成功！','product_list','',2);
        }else{
            $this->error('修改失败！','product_list','',2);
        }

    }



   
}
