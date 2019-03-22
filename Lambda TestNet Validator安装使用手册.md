# Lambda Testnet Validator安装使用文档

* [配置要求](#运行环境配置要求)
* [节点安装部署](#节点安装部署)
* [账户的备份](#账户的备份)

## 运行环境配置要求

### 硬件配置
1. 处理器： 16 Core，2.0 GHz以上
2. 内存： 32 G
3. 硬盘： 4 TB

### 软件环境
1. 操作系统： CentOS Linux release 6.0 版本以上

### 网络环境
1. 网络配置： 公网IP 100MB带宽
2. 网络端口： 13656~13659,26660

## 节点安装部署
节点部署操作必须在当前系统账户拥有读写权限的目录下进行。执行 ``` tar xvf lambda_val.tar ``` 解压 Lambda Testnet Validator安装包后，进入目录，无需设置额外的配置项，直接进行 Lambda Validator 节点的部署操作。

### 创建初始账户
Lambda Validator节点需要以某个账户去启动才能正常运行，第一步需要创建一个初始账户。

执行：

1. ./lambda account new [name]
2. 输入密码，回车。能看到返回的账户地址即创建完成。

例如如下:
```bash
$ ./lambda account new Mike
Enter Password:
68015E294E1C323570DEFC06D0AFAE01A51DBAA9
```
`68015E294E1C323570DEFC06D0AFAE01A51DBAA9` 则是创建账户的地址

**注意** 通过该地址可以查看用户是否成功加入Validator 后续可以通过 ./lambda account list 命令，查询本机的账户信息

### 初始化Validator节点
创建完初始账户后，需要用该账户对节点进行初始化，初始化会用到 bootconfig.json 文件，该文件为共识网络的配置信息，无需修改，修改会导致节点运行失败。

执行：

1. ./lambda init bootconfig.json，成功初始化能看到以下日志输出到控制台

例如如下:
```bash
$ ./lambda init bootconfig.json
Generated private validator path /Users/robert/.lambda/config/priv_validator.json
Generated genesis file path /Users/robert/.lambda/config/genesis.json
lambda node initialize.
```
该命令会在 home 目录下生成一个 /.lambda 目录，/.lambda 下会有3个文件夹：

1. ./config —— 存储 Lambda Chain 相关的配置文件
2. ./data —— 存储Lambda Chain的数据
3. ./keys —— 存储节点的账户信息
 
**注意** 该目录下的文件跟测试网络的运行密切相关请妥善保管,不要随意进行操作。如果您担心账户信息数据丢失问题，请备份好./keys 目录下的所有文件或者使用我们的账户导出命令备份。

### 运行Validator节点
初始化完成后，执行 startup.sh 脚本运行节点，让节点参与到区块链的运行中。

执行：

1. ./startup.sh [name] [password]

例如如下：
```bash
$ ./startup.sh mike lambda
```

执行完 `startup.sh `脚本后，控制台不会有多余的输出，需要到节点日志中查看节点是否正常启动，日志输出在安装目录下的 `lambda.log` 文件中。如果日志输出如下，没有报错信息，则节点在同步区块，正常运行中。

```bash
D[21026-02-21|17:52:41.849] BeginBlock                                   module= height=4 hash=364511b2c2120639ca671f29a7c0fc62d35a2bdca2ef7c2cf43002d5622a75c8 logtype=trace tmhash=810e36d7302085d5aedbbd0bf4241eca691a07c522ad8dd416e9523617cc3522
D[21026-02-21|17:52:41.849] EndBlock                                     module= height=4 hash=364511b2c2120639ca671f29a7c0fc62d35a2bdca2ef7c2cf43002d5622a75c8 logtype=trace
I[21026-02-21|17:52:41.849] Executed block                               module=state height=5 validTxs=0 invalidTxs=0
D[21026-02-21|17:52:41.849] Commit                                       module= height=4 hash=364511b2c2120639ca671f29a7c0fc62d35a2bdca2ef7c2cf43002d5622a75c8 logtype=trace
I[21026-02-21|17:52:41.849] Committed state                              module=state height=5 txs=0 appHash=CC965044E34CA84C93C5783B056A391C1BA145B8963E8B8E218E68B1F5C199D9
D[21026-02-21|17:52:41.852] BeginBlock                                   module= height=5 hash=cc965044e34ca84c93c5783b056a391c1ba145b8963e8b8e218e68b1f5c199d9 logtype=trace tmhash=fce3b277eff3562127e06e21d87628e6e326d5999578c71db7fd7e8c87335283
D[21026-02-21|17:52:41.852] EndBlock                                     module= height=5 hash=cc965044e34ca84c93c5783b056a391c1ba145b8963e8b8e218e68b1f5c199d9 logtype=trace
I[21026-02-21|17:52:41.852] Executed block                               module=state height=6 validTxs=0 invalidTxs=0
```

如果您想参与成为Lambda 测试网络的`Validator` ，请等待区块同步完成在继续下面的操作。

### 节点申请成为 Validator
节点正常启动后，当同步到最新块高度时，可以将节点申请成为 validator，参与出块和奖励。成为 validator 需要质押100万测试网络的 lamb token，请在测试网启动前，按照开发团队要求提交测试网的公钥地址，方便打币进行后续的质押操作。

执行：

1. ./lambda validator add [name]
2. 输入密码，回车。这时会需要等待一会，进行出块确认，不要中断命令，会造成命令执行失败。

成功以后此时该节点已经成功申请以 “Mike”的身份加入到validator的网络中。
在等待2~3个区块高度后后，就能在 `Lambda Chain` 的[区块链浏览器](http://explorer.lambda.im/#/validator)中，查询到 “Mike” 对应的地址是否成功加入到 Validator 的集合中。

查看节点是否成功成为 Validator 并参与出块，可以通过 Lambda 官方测试网浏览器 Validator 列表页面查看，如果您节点对应列的 Latest Produced Block 不是显示 Syncing blocks 而是显示日期，则表示节点参与了出块。

**注意** 

1. 需要等待区块同步完成后，才能申请成为 Validator 参与共识，通过`lambda.log`可以查看当前块同步的高度。
2. 启动节点的账户，申请成为 Validator 的账户必须为同一个账户，否则共识网络不能正确地验证申请人的信息，从而导致申请 Validator 失败。
3. 若申请成为 Validator 时，提示``` failed to get local node information, please check if node is running ```，请检查节点是否正常运行，并能正常访问``` 127.0.0.1:13657/status ```接口。

## 账户的备份

### 命令行备份
使用`lambda`的`key`命令对账户进行`导入`和`导出`操作

导出执行：

1. ./lambda key export [name]
2. 输入正确的账户密码

在进行上述操作以后在当前目录下会生成`[name].keyinfo`，这个文件就是对这个账户的导出私钥加密后的信息。这个时候导出操作完成

导入执行:

1. ./lambda key import [name] ./[name].keyinfo
2. 输入正确的导出用户密码

进行上述操作后如果密码正确则操作完成，可以通过`account list`命令查看导入的账户的地址，相对应也可以进行转账等操作

**注意** 
上述的操作中的`[name]`是你要输入的用户名，且导入和导出的`[name]`不需要一致，但是必须要保证导入的设备上面没有存在同样的`[name]`

