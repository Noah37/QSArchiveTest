iOS自动化打包脚本(shell)
====



**本脚本主要作用为代替人工打包app，导出ipa包并安装的过程，如果是AppStore方式，会自动上传AppStore，不需要手动管理。 如需使用自动安装ipa功能，需要进行一些额外的环境配置。**

-----------

打开autoarchive.sh脚本
=====

<img src="http://img.blog.csdn.net/20170401102400273?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />


主要配置如上图

**projectName为当前待打包工程的工名**



**下面有四种类型，分别代表打包使用的证书类型，此类型可添加，删除等。**

> + development 为开发证书打包
> + enterprise为企业证书打包
> + appstore为上传AppStore打包
> + adhoc为发布证书打包，发布证书一般用于安装在指定的设备上

 

_**四种类型的名称需要与当前工程的Scheme名称后缀一致。**_

**如何为当前工程添加多个Scheme呢，步骤如下**

***为工程添加多个target与Scheme***

+ 使用Xcode打开当前工程，点击工程，选择targets中的任意一个


+ 右键-> Duplicate,选择Duplicate Only，复制当前的target,并将复制好的target改名为QSArchiveTest_Enterprise,如图所示
<img src="http://img.blog.csdn.net/20170401102441596?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />
<img src="http://img.blog.csdn.net/20170401102503243?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />

+ 修改QSArchiveTestcopy-Info.plist名称为QSArchiveTest _Enterprise-Info.plist，点击工程，选择target QSArchiveTest_Enterprise,点击Build Settings ,搜索plist，将如图所示的QSArchiveTest copy-Info.plist名称修改为QSArchiveTest_Enterprise-Info.plist ，然后点击info,如果成功，则如图，若不成功，可能是复制文档中名称错误，请从工程文件中复制文件名。
    <center>
    <img src="http://img.blog.csdn.net/20170401102612675?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />
        <img src="http://img.blog.csdn.net/20170401102633722?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />
    </center>
	

+ 为当前target添加Scheme。点击当前Scheme,选择Manage Schemes, 删除QSArchiveTest copy，然后选择新建，选择当前已新建好的target，点击ok
    <center>
    <img src="http://img.blog.csdn.net/20170401102805794?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="30%" />
    </center>
    **以上步骤成功新建了一个名为QSArchiveTest_Enterprise的Scheme，此时，当前工程可以运行在QSArchiveTest_Enterprise Scheme上，接下来，我们可以按照以上步骤新建QSArchiveTest_Develoment ，QSArchiveTest_AppStore, QSArchiveTest_AdHoc等Schemes**
    <center>
    <img src="http://img.blog.csdn.net/20170401103014501?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="30%" height="30%" />
    </center>
	

**结果如图所示**
    <center>
    <img src="http://img.blog.csdn.net/20170401103110815?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />
    </center>

	
#### 为各个target配置不同的证书及mobileprovision，不同的配置将生成不同的product，也就是不同的app。下面以企业证书为例####

+ 点击工程，选择target->QSArchiveTest_Enterprise,点击general,将bundle identifier修改为com.xxxx.xxxx

+ 点击build settings,向下滑动到签名栏，先选择provisioning profile，然后选择证书，如图所示，配置完成后点击general，如果出现如下图所示，则配置成功。如果有警告或者错误提示，则检查上面的步骤是否正确。**
    <img src="http://img.blog.csdn.net/20170401103230443?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />

	<img src="http://img.blog.csdn.net/20170401103304912?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />


**重复以上步骤，配置target， QSArchiveTest_Development，QSArchiveTest_AppStore，QSArchiveTest_AdHoc，分别选择对应的证书及mobileprovision。**

### 添加导出设置plist文件###

+ 在当前项目的根目录下新建文件夹，名称为autobuild，进入autobuild，使用Xcode新建plist文件，名称为EnterpriseExportOptions.plist,将文件保存到autobuild文件夹中
    <img src="http://img.blog.csdn.net/20170401103433835?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />

+ 为EnterpriseExportOptions.plist添加键值对，使用Xcode打开刚才新建的plist文件，为其添加如下键值对
    ![这里写图片描述](http://img.blog.csdn.net/20170401103553134?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

**method为必选项，有四种选项，分别为**[app-store](), [ad-hoc](), [enterprise](), [development]()。

*各个plist的键值对如下*

**AppStoreExportOptions.plist：**

>  method＝**app-store**，uploadBitcode＝YES，uploadSymbols＝YES

**EnterpriseExportOptions.plist：**

> method＝**enterprise**，compileBitcode＝NO

**DevelopmentExportOptions.plist：**

> method＝**development**，compileBitcode＝NO

**DevelopmentExportOptions.plist：**

> method＝**ad-hoc**，compileBitcode＝NO

**获取不同的target对应的证书名称及mobileprovision的uuid，以下以企业证书为例**

+ 点击工程，选择target-> QSArchiveTest_Enterprise，点击build settings,滑动到Signing，点击Provisioning Profile(Deprecated)栏，选择other，拷贝uuid，替换autoarchive.sh脚本中的enterpriseProvisioningProfile变量值，如图所示
	![这里写图片描述](http://img.blog.csdn.net/20170401103816605?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

	![这里写图片描述](http://img.blog.csdn.net/20170401103901182?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

	

+ 点击Code Signing Identity,选择other，拷贝证书名，替换autoarchive.sh中的** enterpriseCodeSignIdentity变量值，如图所示
    ![这里写图片描述](http://img.blog.csdn.net/20170401103935466?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
  
	![这里写图片描述](http://img.blog.csdn.net/20170401104035046?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

**重复以上步骤，分别获取证书名称及provisionfile的 uuid，替换autoarchive.sh中的CodeSignIdentity，ProvisioningProfile对应变量的值，结果如图所示。此处未有adhoc证书，因此置为空**
    <center>
    <img src="http://img.blog.csdn.net/20170401104112777?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />
    </center>

**如需使用上传至AppStore功能，需在脚本中设置Apple ID如图，将自己的Apple ID以及密码替换即可**
    <center>
    <img src="http://img.blog.csdn.net/20170401104147808?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />
    </center>

**至此，已完成了自动化脚本执行所需要的配置，可以开始使用脚本进行打包了。**

### 使用autoarchive.sh进行打包，以企业证书包为例###

**打开命令行，cd到当前工程的根目录，使用如下命令执行脚本**

`./autoarchive.sh –t Enterprise`

**若有错误提示，使用如下命令解决**

`chmod +x autoarchive.sh`

**再次执行脚本，等待打包过程结束，如果当前连接了设备，请先将设备上的应用删除，脚本打包完成后将会自动将ipa包安装到设备中（如需成功安装ipa到设备，需要查看下文-脚本详解，按照其中的步骤安装相应的工具）。成功如下图所示，如失败，请查看错误提示，并参照错误提示检查前面的步骤。打包完成后会自动打开当前ipa包所在目录，如未打开，请拷贝exportPath路径，打开Finder，使用快捷键 Command + shilf + g，打开ipa包路径。**
    <img src="http://img.blog.csdn.net/20170401104227309?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />
    <img src="http://img.blog.csdn.net/20170401104246184?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="50%" height="50%" />

## 脚本详解##

**本脚本包括以下几个方法**

+ clean方法，作用为clean工程，日志将会输出到log.txt中，使用xcodebuild命令执行，关于xcodebuild命令的详细情况请使用xcodebuild –help了解，如无法使用xcodebuild，请检查mac使用安装了Xcode，如已安装，请检查是否设置Xcode为当前命令行工具，检查方法如图
    ![这里写图片描述](http://img.blog.csdn.net/20170401104337145?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

    ![这里写图片描述](http://img.blog.csdn.net/20170401104404137?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

+ archive方法，archive方法主要为打包QSArchiveTest.xcarchive所用
    ![这里写图片描述](http://img.blog.csdn.net/20170401104440756?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

+ export方法，此方法为导出ipa包，导出路径自定义

	![这里写图片描述](http://img.blog.csdn.net/20170401104506741?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

+ **install方法，该方法生效需要安装**ideviceinstaller，libimobiledevice两个工具。两个工具可以使用homebrew进行安装。这两个工具用于安装ipa或者管理iOS设备应用，查看当前连接设备的信息等。****
    ![这里写图片描述](http://img.blog.csdn.net/20170401104534710?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

###安装homebrew

​ **homebrew为macOS不可或缺的套件管理器，$brew install wget**

**安装方式如下**

**打开终端，拷贝以下脚本,回车，等待安装结束**

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

#### 安装ideviceinstaller以及libimobiledevice。

安装如下命令逐个执行，前两条用于卸载，如果已安装，但是改工具使用不正常，即可使用命令卸载

> brew uninstall ideviceinstaller
>
> brew uninstall libimobiledevice
>
> brew install --HEAD libimobiledevice
>
> brew link --overwrite libimobiledevice
>
> brew install ideviceinstaller
>
> brew link --overwrite ideviceinstaller

**安装完成后使用，查看当前是否有iOS设备连接**

`idevice_id –l`

**查看帮助信息**

`ideviceinstaler –h `

**将ipa包安装至iOS设备**

`ideviceinstaller -i ipaPath`

**ipaPath为需要安装的ipa的路径**

**如果出现以下错误**

`couldnot connect to lockdownd. exiting.`

可以使用指令解决

`sudochmod -R 777 /var/db/lockdown/`

**或者永久的解决办法为重新进行ideviceinstaller安装过程**

**ideviceinstaller工具的功能还有很多，此处不再详细解释，可自行探索**

+ upload方法，该方法用于上传ipa至AppStore，只有在AppStore模式下才会执行。Upload方法用到了Xcode自带的工具Application Loader altool，与手动上传方法一致。altool位于Application Loader中，三个参数ipaPath,appleId,applepassword,ipaPath为ipa包导出的路径，applied为开发者帐号，applepassword为开发者帐号的密码
    ![这里写图片描述](http://img.blog.csdn.net/20170401104608341?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDQ1ODgwOA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
