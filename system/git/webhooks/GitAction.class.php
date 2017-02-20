<?php
// 本类主要用于跟git交互的webhook

class GitAction extends HCommonAction {

	//拉取接口
    public function pull(){
        //进入网站目录，执行拉取master的命令
        shell_exec("cd  /web/www_test_com/default ; git pull origin master 2>&1 | tee -a /tmp/mylog 2>/dev/null >/dev/null &");
        echo "天佑中华是毛片！";

    }
}
