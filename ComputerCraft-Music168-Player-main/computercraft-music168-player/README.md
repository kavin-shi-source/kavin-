# ComputerCraft 网易云音乐播放器


## 📌 简介

本程序是一个基于 **ComputerCraft**（Minecraft 模组）的网易云音乐播放器，使用 **Lua** 编写，调用了第三方网易云 API、DFPWM 音频转码 API，结合 [Basalt GUI库](https://github.com/PyPyl/Basalt) 构建图形界面，支持搜索/播放网易云音乐，并支持歌单播放、歌词同步等功能。

此版本支持中文音乐名称显示（搜索出来的列表），但搜索只能使用英文或中文拼音

支持歌词显示，且会根据显示大小变更文字分辨率，但在默认的终端使用会显示不全，所以此功能建议使用屏幕显示（monitor 方向 music168.lua）

此软件使用触控交互，所以不支持石头电脑
---

### 🖼️ 展示图

#### 🔍 中文搜索展示
支持中文音乐名称显示（搜索建议使用拼音或英文）
![中文搜索展示](https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/READMEImage/%E4%B8%AD%E6%96%87%E6%90%9C%E7%B4%A2%E5%B1%95%E7%A4%BA.png)

#### 📄 播放列表展示
点击播放后可查看当前播放列表并切换歌曲
![播放列表展示](https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/READMEImage/%E6%92%AD%E6%94%BE%E5%88%97%E8%A1%A8%E5%B1%95%E7%A4%BA.png)

#### 📂 歌单搜索展示
支持通过歌单 ID 搜索并播放整个歌单
![歌单搜索展示](https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/READMEImage/%E6%AD%8C%E5%8D%95%E6%90%9C%E7%B4%A2%E5%B1%95%E7%A4%BA.png)

#### 🎙️ 歌词展示
播放时可同步显示歌词
![歌词展示](https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/READMEImage/%E6%AD%8C%E8%AF%8D%E5%B1%95%E7%A4%BA.png)

#### 🖥️ 屏幕显示歌词展示（适配大屏显示）
适用于使用 Monitor（monitor）外设播放时的歌词同步显示
![屏幕显示歌词展示](https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/READMEImage/%E5%B1%8F%E5%B9%95%E6%98%BE%E7%A4%BA%E6%AD%8C%E8%AF%8D%E5%B1%95%E7%A4%BA.png)

---

## 🚀 安装方法

在 Minecraft 中安装好 [ComputerCraft](https://www.mcmod.cn/class/1681.html) 模组后在电脑终端：

```bash
wget https://git.liulikeji.cn/xingluo/ComputerCraft-Music168-Player/raw/branch/main/music168.lua
```

运行：

```bash
music168
```

即可启动播放器。
并自动补全运行库

---

## 🛠️ 使用方法

### 🔍 搜索音乐

1. 在顶部输入框中输入歌曲名（拼音或英文均可，空格隔开）或网易云音乐 ID（需要多试几次）。
2. 点击输入框右侧的 `Q` 按钮开始搜索。
3. 下方列表中点击歌曲即可播放。

### 📂 歌单播放

1. 底部菜单栏点击 `{G}` 按钮，进入歌单搜索界面。
2. 输入歌单 ID（可通过复制粘贴）并点击 `Q` 搜索。
3. 点击歌单中的音乐可播放。

### 🎵 播放控制

- 点击播放界面中的按钮可控制播放暂停。
- 点击 `T` 可打开播放列表，点击列表内歌曲切换歌曲。
- 点击播放界面左上角的 `V` 退出播放界面到搜索。
- 通过点击下方播放栏回到播放页面
- 点击进度条可以切换播放进度


### 多通道音频

- 默认为全部单通道播放，如使用双声道音频请按以下操作

编辑文件 speaker_groups.cfg
```bash
edit speaker_groups.cfg
```
在内部写入例如：
```json
{
    main = {}, --混合通道扬声器列表
    left = {"speaker_0","speaker_1"}, --左声道扬声器列表
    right = {"speaker_5","speaker_6"} --右声道扬声器列表
}
```
这里的"speaker_0","speaker_1"等数量不限制，但多了会导致音频不同步或超出最大上限
"speaker_0","speaker_1"等为扬声器名称，如果使用网线链接则是打开时聊天栏的名称，如果直接放在旁边则为方向名例如（top,left,right）


---

## 📦 使用技术栈

- **语言**：Lua
- **GUI 库**：[Basalt GUI](https://git.liulikeji.cn/GitHub/Basalt)
- **网易云 API**：[liulikeji.cn](http://music168.liulikeji.cn:15843/)
- **DFPWM 音频转码接口**：[GMapiServer-ffmpeg](https://git.liulikeji.cn/xingluo/GMapiServer/)
- **歌词支持**：通过 `MusicLyrics.lua` 加载歌词
- **播放和格式转换**：通过`speakerlib.lua` 转换格式和处理播放

---

## ⚠️ 注意事项

- 本程序为半成品，部分按钮仅作装饰。
- 若播放无声音，请检查播放界面左下角时间是否为 `00:00`，如果长时间无变化，请稍等或重试。
- 因为网络延迟或 API 崩溃，可能导致播放失败。
- 播放效果依赖于 ComputerCraft 中的 **speaker** 外设（扬声器）。

---

## 🗂️ 更新历史

- **新增歌单播放功能**
- 修复部分播放逻辑与 UI 显示错误

- **新增中文音乐名，歌词显示，多通道音频**
- 使用了新版GMApi接口

---


## 🛑 声明

> 本项目仅供学习交流使用，API 来源于第三方网易云api，音乐内容的版权属于原权利人。请勿用于商业用途。

---

## 🧑‍💻 项目作者

项目为个人开发，目前处于“咕咕咕”状态，更新不确定。

---

## 📬 反馈与支持

如有建议或问题，请联系项目原作者。

---

> 祝你享受愉快的音乐时光 🎶  
在 ComputerCraft 世界中聆听你的网易云音乐❤
