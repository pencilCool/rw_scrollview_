//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by tangyuhua on 2016/12/12.
//  Copyright © 2016年 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  public var photoName: String!
  public var photoIndex: Int!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    if let photoName = photoName {
      self.imageView.image = UIImage(named: photoName)
    }
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(PhotoCommentViewController.keyboardWillShow(notification:)),
      name: NSNotification.Name.UIKeyboardWillShow,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(PhotoCommentViewController.keyboardWillHide(notification:)),
      name: NSNotification.Name.UIKeyboardWillHide,
      object: nil
    )
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.cgRectValue
    let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboardShow(show: true, notification: notification)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboardShow(show: false, notification: notification)
  }
  
  
  @IBAction func hideKeyboard(sender: AnyObject) {
    nameTextField.endEditing(true)
  }

  @IBAction func openZoomingController(sender: AnyObject) {
    self.performSegue(withIdentifier: "zooming", sender: nil)
  }
 
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let id = segue.identifier,
      let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController {
      if id == "zooming" {
        zoomedPhotoViewController.photoName = photoName
      }
    }
 
  }

}
