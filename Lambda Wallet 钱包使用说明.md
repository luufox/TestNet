# Lambda Wallet 钱包使用说明
版本 0.1.1 一个钱包支持一个账号，新建账号之前的账号配置文件会被覆盖，请注意备份账号配置文件，避免账号信息丢失

![avatar](img/wallethome@2x.png)

* [创建账号](#创建账号)
* [导入账号](#导入账号)
* [钱包首页说明](#钱包首页说明)
* [转账](#转账)
* [导出账号配置文件](#导出账号配置文件)
* [更换钱包链接的Validator节点](#更换钱包链接的Validator节点)

## 创建账号
点击登录页面 create wallet  进入创建钱包的页面

输入钱包名称，密码，确认钱包密码，点击 create 按钮，

![avatar](img/create@2x.png)

点击 Create按钮后，进入助记次页面


这里需要记录下这些助记次，以后恢复钱包用，点击next step进入下一页

![avatar](img/word@2x.png)

在确认助记次的页面，按照刚才记录助记次的顺序，点击页面上的单词

![avatar](img/select@2x.png)

点击完成后的页面

![avatar](img/selectall@2x.png)

点击 Export Keystore File  打开保存钱包私钥的配置文件lambda.keyinfo所在的文件夹

![avatar](img/file@2x.png)

通过lambda.keyinfo可以再次导入钱包

通过钱包创建账号到此完成

## 导入账号
导入挖矿程序创建的账号或钱包创建的账号

点击首页 import wallet  进入导入账号的页面

![avatar](img/import@2x.png)

点击 choose wallet files 选择 账号的配置文件

配置文件后缀为 keyinfo,例如钱包创建的配置文件为lambda.keyinfo

输入创建钱包时候的密码，再输入新的钱包的名称，点击 import ,即可导入钱包

## 钱包首页说明
新创建的账号，余额为0，也没有交易记录

![avatar](img/home@2x.png)

顶部是导航菜单，点击设置按钮进入设置页面，点击账号地址可以复制账号

底部是钱包链接的validator  节点的信息，包含节点的地址，区块的高度，出块时间

账号有了 交易记录的效果图

![avatar](img/home2@2x.png)


## 转账
点击首页的 transfer 按钮 ，弹出转账对话框，填写转账的地址和金额

![avatar](img/send@2x.png)

点击submit，弹出输入钱包密码的对话框，输入钱包密码，

![avatar](img/pasword@2x.png)

点击submit，等待10s左右转账完成,转账成功效果如下

![avatar](img/ok@2x.png)

点击view detail 查看转账详情

![avatar](img/view@2x.png)

## 导出账号配置文件

在设置页面点击 Keystore File Backup,即可查看账号配置文件

![avatar](img/set@2x.png)

## 更换钱包链接的Validator节点
在设置页面点击 Switch Validator 进入 查看Validator信息的页面

![avatar](img/info@2x.png)

在输入框里面更改节点的url 地址，点击 submit，切换成功后提示信息如下 

![avatar](img/ok2@2x.png)


