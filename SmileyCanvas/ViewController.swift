//
//  ViewController.swift
//  SmileyCanvas
//
//  Created by Bianca Curutan on 11/2/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    var faceOriginalCenter: CGPoint!
    

    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenOpen = self.trayView.center
        trayCenterWhenClosed = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + 190)
        
        // TEST trayView.center = trayCenterWhenClosed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.location(in: trayView)
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = self.trayView.center
        } else if sender.state == .changed {
            print("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + sender.translation(in: trayView).y)
            
        } else if sender.state == .ended {
            print("Gesture ended at: \(point)")
            if sender.velocity(in: trayView).y > 0 { // moving down
                trayView.center = trayCenterWhenClosed
            } else { // moving up
                trayView.center = trayCenterWhenOpen
            }
        }
    }
    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began {
            faceOriginalCenter = sender.view?.center
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.frame.size = CGSize(width: 75.0, height: 75.0)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + sender.translation(in: newlyCreatedFace).x, y: 347 + faceOriginalCenter.y + sender.translation(in: newlyCreatedFace).y)
            
        } else if sender.state == .ended {

        }
    }
    

}

