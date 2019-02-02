<?php
$errRequestFunction = "Error as a function call requests"; //错误的功能调用请求
$errRequestFile = "Request the wrong file called"; //"错误的文件调用请求"
$errFileType = "The wrong file type"; //"错误的文件类型！"
$errUpfile = "File upload failed, please check the upload directory and directory read and write permissions set"; //"文件上传失败，请检查上传目录设置和目录读写权限"
$uploadExceed = "The uploaded file can not exceed"; //"上传的文件不能超过"
$config = array ();
$config ['type'] = array ("flash", "img" ); //上传允许type值
$config ['img'] = array ("jpg", "bmp", "gif" ); //img允许后缀
$config ['flash'] = array ("flv", "swf" ); //flash允许后缀
$config ['flash_size'] = 2000; //上传flash大小上限 单位：KB
$config ['img_size'] = 5000; //上传img大小上限 单位：KB
$config ['message'] = "上传成功!"; //上传成功后显示的消息，若为空则不显示上传成功
$config ['name'] = mktime (); //上传后的文件命名规则 这里以unix时间戳来命名
$config ['flash_dir'] = $_SERVER['DOCUMENT_ROOT']."/HNUST/upload"; //上传flash文件地址 采用绝对地址 方便upload.php文件放在站内的任何位置后面不加"/",上传的文件将放在网站根目录下的upload文件夹下
$config ['img_dir'] = $_SERVER['DOCUMENT_ROOT']."/HNUST/upload"; //上传img文件地址 采用绝对地址 采用绝对地址 方便upload.php文件放在站内的任何位置后面不加"/"，上传的文件将放在网站根目录下的upload文件夹下
$config ['site_url'] = "http://localhost:8080/HNUST"; //网站的网址这与图片上传后的地址有关 最后不加"/" 可留空
//没有文件夹时则创建
isDirAll($config ['flash_dir']);
isDirAll($config ['img_dir']);
//文件上传
uploadfile ();
function uploadfile() {
    global $config;
    //判断是否是非法调用
    if (empty ( $_GET ['CKEditorFuncNum'] ))
        mkhtml ( 1, "", $errRequestFunction );
    $fn = $_GET ['CKEditorFuncNum'];
    if (! in_array ( $_GET ['type'], $config ['type'] ))
        mkhtml ( 1, "", $errRequestFile );
    $type = $_GET ['type'];
    if (is_uploaded_file ( $_FILES ['upload'] ['tmp_name'] )) {
        //判断上传文件是否允许
        $filearr = pathinfo ( $_FILES ['upload'] ['name'] );
        $filetype = $filearr ["extension"];
        if (! in_array ( $filetype, $config [$type] ))
            mkhtml ( $fn, "", $errFileType );
            //判断文件大小是否符合要求
        if ($_FILES ['upload'] ['size'] > $config [$type . "_size"] * 1024)
            mkhtml ( $fn, "", $uploadExceed . $config [$type . "_size"] . "KB！" );
        $file_abso = $config [$type . "_dir"] . "/" . $config ['name'] . "." . $filetype;
        $file_host = $file_abso;
        $file_path = "/upload/" . $config ['name'] . "." . $filetype;//这里的/upload/根据你上传文件的目录进行调整
        if (move_uploaded_file ( $_FILES ['upload'] ['tmp_name'], $file_host )) {
            mkhtml ( $fn, $config ['site_url'] . $file_path, $config ['message'] );
        } else {
            mkhtml ( $fn, "", $errUpfile . $file_host );
        }
    }
}
//输出js调用
function mkhtml($fn, $fileurl, $message) {
    $str = '<script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(' . $fn . ', '' . $fileurl . '', '' . $message . '');</script>';
    exit ( $str );
}
 
function isDirAll($dir) {
    if (! is_dir ( $dir )) {
        $dirArr = explode ( "/", $dir );
        $mkDir = "";
        for($i = 0; $i < count ( $dirArr ); $i ++) {
            if ($dirArr [$i] != "") {
                $mkDir .= '/' . $dirArr [$i];
                isMkDir ( $mkDir );
            }
        }
    }
}
 
function isMkDir($dir = "") {
    if (! is_dir ( $dir )) {
        @mkdir ( $dir, 0777 );
    }
}
?>