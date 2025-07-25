# WheelLR - 滚轮左右键

一个 AutoHotkey 脚本，通过鼠标滚轮模拟键盘左右键输入，实现快捷调整视频进度或文本光标。当按住指定鼠标键（**默认为右键**）并滚动滚轮时，不再是上下滚动页面，而是模拟按下`←`和`→`键。

这在以下场景中非常实用：
*   **视频播放**: 在B站、YouTube等网页或本地播放器中，无需精确点击进度条，即可快捷地快进/快退。
*   **文本编辑**: 在代码或文字中，可以以单个字符为单位，精确地移动光标位置。

---

## 🚀 下载与使用 (Download & Use)

### 方式一：直接运行 (推荐)
适合绝大多数没有安装 AutoHotkey 的用户。

1.  前往本项目的 **[Releases 页面](https://github.com/chixi4/WheelLR/releases)**。
2.  下载最新版本的 `WheelLR.exe` 文件。
3.  双击运行即可！你会在系统托盘看到 AutoHotkey 的图标。

### 方式二：使用源脚本
适合已安装 AutoHotkey 并希望自定义脚本的用户。

1.  确保你已安装 [AutoHotkey](https://www.autohotkey.com/) (推荐 v2.0+)。
2.  下载本项目的 `.ahk` 源代码。
3.  双击 `WheelLR.ahk` 文件运行。

---

## ✨ 功能与操作

- **如何操作**: 按住**鼠标右键**（不要移动），然后向上滚动滚轮发送`←`，向下滚动滚轮发送`→`。
- **智能拖拽检测**: 普通的鼠标拖拽操作不会受影响。
- **无缝点击**: 普通的右键单击不受任何干扰。
- **清晰反馈**: 触发功能时，会有短暂的箭头（←/→）提示。
- **安全退出**: 先按 `Alt + G`，然后在一秒内按 `D` 即可退出脚本。

## 🔧 自定义配置
如果你使用 `.ahk` 源码运行，可以修改文件开头的配置：

```ahk
; ===================================================================
;                         User Configuration
; ===================================================================
global triggerKey  := "RButton" ; 触发键 (可选: "LButton", "RButton", "MButton")
global dragThreshold := 5      ; 拖拽检测的阈值 (像素)，数值越小越灵敏
; ===================================================================
