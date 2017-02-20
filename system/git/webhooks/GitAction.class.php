<?php
// 本类主要用于跟git交互的webhook

class GitAction extends HCommonAction {

	//拉取接口
    public function pull()
    {

        $password = a123456789 ;


        //验证POST传送的密码，密码正确则执行git命令
        if($_POST['password'] == $password){

        //进入网站目录，执行拉取master的命令
        shell_exec("cd  /web/wwwtestcom/default ; git pull origin master 2>&1 | tee -a /tmp/mylog 2>/dev/null >/dev/null &");

        //打印命令执行成功的暗号
        echo "天佑中华是毛片！";

        }

    }
}
