- [教程链接](https://www.raywenderlich.com/122139/uiscrollview-tutorial)
加了一个scrollview之后就能滚动看全照片啦。
如果你想让图片fit 设备。或者想放大缩小图片

添加属性：



```

@IBOutlet weak var scrollView: UIScrollView! 

@IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!

@IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!

@IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!

@IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!

```

视图连线到到vc 是deletate。

vc 到 视图是IBOutlet 属性



vc 中的constraint 也可以和IB 中 autolayout 的进行关联。



告诉scrollview 哪一个视图放大缩小



```

extension ZoomedPhotoViewController: UIScrollViewDelegate {

  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {

    return imageView

  }

}

```



缩放的比率的最大值是1.因为再大就模糊了。

最小缩放比率是这么求的：



```

private func updateMinZoomScaleForSize(size: CGSize) {

  let widthScale = size.width / imageView.bounds.width

  let heightScale = size.height / imageView.bounds.height

  let minScale = min(widthScale, heightScale)  

 

  scrollView.minimumZoomScale = minScale 

 

  scrollView.zoomScale = minScale

}

```



run 发现缩放不可用了。其实是上面的代理方法在 swift3 中已经失效啦。

改成：



```



extension ZoomedPhotoViewController: UIScrollViewDelegate {

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {

    return imageView;

  }

  

}

```

__总结一个坑：option的代理方法失效导致的失败__



现在还有几个问题：



- 图片不居中

- 竖屏到横屏切换的过程中不resize



scrollViewDidZoom 中调用更新约束的方法

被调用的方法是private的，不能再externsion中 调用呀。



###小结

根据内容来调整布局，在viewdidlayoutsubview中调用方法比较好。

调用的方法中需要调用layoutIfNeeded



###next

“Adjust Scroll View Insets checkbox in the Attributes inspector. Be sure to set this property to false if you want to take charge of adjusting a scroll view’s contentInset and scrollIndicatorInsets yourself.”



摘录来自: Matt Neuburg. “Programming iOS 10”。 iBooks. 



在autolayout 中定义scrollview的contentsize的方法。

在scrollview中添加一个子视图，然后设置视图的高度，将视图的宽度设置成与 view 等宽。



获取键盘高的办法：



	notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue



将NSValue 变成 frame 的办法



	keyboardFrame = value.CGRectValue()



调整contentInset的时候还需要同时调整滑动指示器

	

	  scrollView.contentInset.bottom += adjustmentHeight

	  scrollView.scrollIndicatorInsets.bottom += adjustmentHeight

	  

####Tap Gesture Recognizer

这一个还能想uiview 一样拖出来用。



将tap gesture 放到 view 上面，手势就和view 绑定了。然后在tap gesture 对象的connect inspection中找到action就可以啦



####添加UIPageControl

UIPageViewController has the ability to automatically provide a UIPageControl









	

	














