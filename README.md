# 炫酷的滑动条 · UISlider 自定义轨道

一个纯 UIKit 实现的 UISlider 换肤示例（Objective-C，2015 年工程）。

![UISlider 拖动演示](https://ghproxy.net/https://raw.githubusercontent.com/812602984/UISlider/master/docs/uislider-demo.gif)

> 上方演示为按源码中真实布局参数（`CGRectMake(20, 220, 屏宽 - 40, 25)`）绘制的示意图，非真机截图。若图片未能加载（部分网络会拦截 GitHub 图片域名），可直接打开仓库内 `docs/uislider-demo.gif` 查看。

## 实现思路

UISlider 默认轨道是一条细线。想做出「图片填充的进度条」效果，核心做法是**把滑块自带的轨道藏起来，改用两个 UIImageView 在下面铺底**：

1. `minimumImageView` 与 slider 尺寸完全一致，用 `slider_minimum.png` 通过 `colorWithPatternImage` 平铺，作为整条轨道的底图。
2. `maximumImageView` 叠在其上，初始宽度 10，`tag` 设为 `kClearImageViewTag`，用 `slider_maximum.png` 平铺，表示「已选中」部分。
3. slider 自身的 `setMinimumTrackImage:` / `setMaximumTrackImage:` 都设为全透明的 `clear.png`，让系统轨道不再遮挡底图。
4. 监听 `UIControlEventValueChanged`，在回调里把 `maximumImageView` 的宽度改为 `slider.frame.size.width * slider.value`，进度便随滑块同步变化。

由于进度层宽度由 `value` 直接换算，换一套 PNG 图样就能换一套皮肤，不需要改动控件逻辑。

## 关键代码

```objc
- (void)sliderAction:(UISlider *)slider {
    UIImageView *imageView = (id)[self.view viewWithTag:kClearImageViewTag];
    imageView.frame = CGRectMake(imageView.frame.origin.x,
                                 imageView.frame.origin.y,
                                 slider.frame.size.width * slider.value,
                                 imageView.frame.size.height);
}
```

## 目录结构

```
炫酷的滑动条Slider/
└── 炫酷的滑动条Slider/
    ├── RootViewController.m    // 核心实现
    ├── slider_minimum.png      // 未选中轨道图样
    ├── slider_maximum.png      // 已选中进度图样
    └── clear.png               // 透明轨道（盖掉系统默认轨道）
docs/
└── uislider-demo.gif           // 演示动图
```

## 运行须知

- 工程为 2015 年的 MRC 写法（手动 `release` 释放对象），在新版 Xcode 中运行需在 Build Settings 中关闭 ARC，或自行改写为 ARC。
- 轨道素材尺寸很小（`slider_minimum.png` / `slider_maximum.png` 均为 9×23），依赖 `colorWithPatternImage` 平铺放大，请勿直接替换为大尺寸图片，否则轨道会被撑变形。

## 作者

psw · [GitHub](https://github.com/812602984)
