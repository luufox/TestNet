# Lambda Miner安装使用文档

* [配置要求](#运行环境配置要求)
  - [软件环境](#软件环境)
  - [网络环境](#网络环境)
* [矿工注意事项](#矿工注意事项)
* [节点安装部署](#节点安装部署)
  - [初始化](#初始化)
  - [新建账户](#新建账户)
  - [矿工初始化](#初始化矿工配置)
* [账户备份](#账户备份)
  - [手动备份](#手动备份)
  - [命令行备份](#命令行备份)
* [矿工操作](#矿工操作)
  - [矿工注册](#矿工注册)
  - [矿工质押](#矿工质押)
  - [矿工反质押](#矿工反质押)
  - [矿工质押查询](#矿工质押查询)
  - [发起卖单](#发起卖单)
  - [撤回卖单](#撤回卖单)
  - [卖单查询](#卖单查询)
* [运行](#运行Lambda存储节点)

## 运行环境配置要求

### 软件环境
1. 操作系统： CentOS Linux release 6.0 版本以上

### 网络环境
1. 网络配置： 公网IP
2. 网络端口： 13666 13670

## 矿工注意事项
1. 确定质押空间数(TB)和钱包地址并且发送给相应的Validator
2. 等待Validator收集完毕并且提交给官方，等待官方根据质押空间数进行打币
3. 打币完成后可以启动矿工节点，这里必须要用提供的钱包地址的账户来启动矿工节点
4. 矿工进行质押操作，质押的空间大小必须和提供的空间大小相符，质押完成后可以看到对应操作的命令行输出结果
5. 矿工在质押操作的时候，绑定的Validator必须是你质押的Validator的地址，如果绑定错会出现异常从而影响收益
6. 矿工在质押完成后要进行挂卖单操作，卖单参数官方建议是每次卖单的空间数为`1(GB)`，价格为`1(LAMB/GB/Day)`，命令行输入例如如下`./lambda miner ask new [name] 1 1`。如果不按照推荐操作可能会导致订单匹配出现异常从而影响收益
7. 手册中提到的所有地址都为Lambda的钱包地址
8. Miner和Validator不能在同一台机器上运行
9. 一定要确保要求的指定端口开放且调用了miner init命令，不然会导致文件存储失败影响收益

## 节点安装部署
节点部署操作必须在当前系统账户拥有读写权限的目录下进行。执行 tar -zxvf lambda_miner_x.x.x.tar.gz 解压 Lambda Miner，进入目录，无需设置额外的配置项，直接进行Lambda存储节点的部署操作

### 初始化
创建完初始账户后，需要用该账户对节点进行初始化，初始化会用到 bootconfig.json 文件，该文件为共识网络的配置信息，无需修改，修改会导致节点运行失败。

执行：

1. ./lambda init bootconfig.json
2. 回车。成功初始化能看到以下日志输出到控制台。

例如如下:
```bash
$ ./lambda init bootconfig.json
Enter Password:
Generated private validator path /Users/robert/.lambda/config/priv_validator.json
Generated genesis file path /Users/robert/.lambda/config/genesis.json
lambda node initialize.
```
该命令会在 home 目录下生成一个 /.lambda 目录，/.lambda 下会有3个文件夹：

1. ./config —— 存储 Lambda Chain 相关的配置文件
2. ./data —— 存储Lambda Chain的数据
3. ./keys —— 存储节点的账户信息
 
**注意** 该目录下的文件跟测试网络的运行密切相关请妥善保管,不要随意进行操作。如果您担心账户信息数据丢失问题，请备份好./keys 目录下的所有文件或者使用我们的账户导出命令备份。

### 新建账户
Lambda存储节点需要以某个账户去启动才能正常运行，第一步需要创建一个初始账户。

执行：

1. ./lambda account new [name]
2. 输入密码，回车。能看到返回的账户地址即创建完成。

例如如下:
```bash
$ ./lambda account new Mike
Enter Password:
68015E294E1C323570DEFC06D0AFAE01A51DBAA9
```
`2255469F7BFADAE830F3FF4A84EC0EF6A72BAF99` 则是创建账户的地址

**注意** 后续可以通过 ./lambda account list 命令，查询本机的账户信息

### 已有账户
1. 在之前已有账户设备启动则不需要账户导入操作，直接执行clean.sh脚本，在执行完脚本后直接进行初始化Lambda节点和后续操作。
2. 在新设备上启动，要先导入备份的账户信息，再进行初始化Lambda节点和后续操作。

### 初始化矿工配置
在创建完账户和初始化lambda节点后要初始化矿工的配置以作为矿工存储用户的订单

执行：

1. ./lambda miner init
2. 回车。成功后看到命令行有如下输出

```bash
./bin/lambda miner init
Configuration saved to: /Users/robert/.lambda/storj/Storagenode/config.yaml
```
生成的配置文件存储到storj/Storagenode目录下，这里可以执行`miner config`对配置文件进行编译。

**注意** 
1. lambda/storj文件夹非常重要，请不要删除或者进行移动操作，在成为矿工后，用户存储的文件分片也会存储到该文件夹下。
2. 如果想要自定义存储路径，请修改bootconfig.json中的 `storage_path` 字段（请使用绝对路径），如果该字段为空或者路径不存在，将使用lambda的默认配置路径（$HOME/.lambda），修改完成后，重新执行 `./lambda miner init` 命令。


## 账户备份

### 手动备份
要备份当前设备创建的账户和公私钥主要是要保存当前用户的根目录下的lambda文件夹中的keys文件夹。该文件夹保存着你创建的别名对应的公私钥。

执行：

1. cd ~/.lambda/
2. 备份当前目录下的keys文件夹

**注意** 对keys进行备份进行妥善保存，如果丢失了，则创建的账户的私钥无法找回，对应也会带来资产损失。

对账户进行迁移，只需要在一台新设备上，把keys文件夹拷贝到对应的目录下（用户的lambda目录下） ，再重新调用初始化Validator节点的命令，调用完成后，直接启动节点进行同步或者调用命令进行对应的交易操作等。

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

## 矿工操作
我们要先质押成为矿工再提供对应的存储服务。这里需要注意的是，矿工节点是一个轻节点，只提供存储服务和与主链进行数据交互，不参与任何共识行为。

### 矿工质押
用户质押指定的空间和一定的token成为矿工

执行：

1. ./lambda miner pledge new [name] [storage capacity(TB)] [address(validator)]
2. 输入密码，回车。这时会需要等待一会，进行出块确认，不要中断命令，会造成命令执行失败。

成功以后可以看到命令输出显示质押成功，这里需要注意的是在测试网阶段，我们的质押空间最小单位是TB，质押的价格为3000LAMB/TB，在发起质押之前请保证账户有足够的余额进行质押操作。在质押的时候需要提供一个有效的validator地址进行绑定，只有绑定后的矿工才能收到出块的奖励。
在质押成功后可以运行存储节点来提供对应的存储服务。

### 矿工反质押
矿工撤回质押空间退出矿工

执行：

1. ./lambda miner pledge delete [name]
2. 输入密码，回车。出块等待。

### 矿工质押查询
矿工查询自己的质押信息

执行：

1. ./lambda miner pledge status [name]
2. 回车。

### 发起卖单
矿工在质押空间后可以发起卖单去匹配对应的订单

执行：

1. ./lambda miner ask new [name] [price(LAMB/GB/day)] [storage capacity(GB)]
2. 输入密码，回车。等待出块完成。

**注意** 
1. 发起卖单，必须要在质押之后
2. 当前的价格单位为LAMB/GB/Day，这里支持的最小单位为，这里的报价绝对你是否可以从匹配市场匹配用户的订单
3. 不需要指定PublicIp，程序会根据peerId进行寻址，如果PublicIp有变化，重新启动miner程序即可

### 撤回卖单
矿工撤回已经挂起的卖单

执行：
1. ./lambda miner ask delete [name] [askid]
2. 输入密码，回车。等待出块完成

**注意**
1. 这里的askid为你质押生成的卖单id，可以通过卖单查询的接口查询矿工挂起的所有卖单并且对选择的卖单进行撤单操作

### 卖单查询
查询矿工发起的卖单信息

执行：
1. ./lambda miner ask list [name]
2. 输入密码，回车。
这里会返回矿工挂起的所有卖单的askid

## 运行Lambda存储节点
初始化完成后，执行 startup.sh 脚本运行节点，让矿工节点启动。

执行：

1. ./startup.sh [name]  密码
2. 回车

例如如下：
```bash
$ ./startup.sh mike  密码
```

执行完 `startup.sh `脚本后输出如下。

```bash
bin/lambda miner run ling
Enter Password: 
D[19036-03-19|15:53:28.067] lambda storage                               module=lambda storage action="storage node start"
D[19036-03-19|15:53:28.068] lambda storage                               module=lambda storage action="running on port :13666"
D[19036-03-19|15:53:28.132] lambda storage                               module=lambda storage task="notify task start"
E[19036-03-19|15:53:28.772] lambda storage                               module=lambda storage Query_MatchOrderListByAddress="no match order list for this account"
```

