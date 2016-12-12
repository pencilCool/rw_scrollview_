//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by tangyuhua on 2016/12/12.
//  Copyright © 2016年 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
  var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
  var currentIndex: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dataSource = self;
    
    // 1
    if let viewController = viewPhotoCommentController(index: currentIndex ?? 0) {
      let viewControllers = [viewController]
      // 2
      setViewControllers(
        viewControllers,
        direction: .forward,
        animated: false,
        completion: nil
      )
    }
  }
  
  func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    if let storyboard = storyboard,
      let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController")
        as? PhotoCommentViewController {
      page.photoName = photos[index]
      page.photoIndex = index
      return page
    }
    return nil
  }
}


//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
  // 1
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound else { return nil }
      index = index! + 1
      guard index != photos.count else {return nil}
      return viewPhotoCommentController(index: index!)
    }
    return nil
  }
  
  
  // 2
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {

  
  if let viewController = viewController as? PhotoCommentViewController {
    var index = viewController.photoIndex
    guard index != NSNotFound && index != 0 else { return nil }
    index = index! - 1
    return viewPhotoCommentController(index: index!)
  }
  return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}

