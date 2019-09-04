//
//  ViewController.swift
//  DemoLessonSix
//
//  Created by VietPhan on 9/3/19.
//  Copyright © 2019 Phan Thanh Việt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewLoad: UIImageView!
    @IBOutlet weak var clickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textGCD()
    }
    
    func textGCD() {
        let queue = DispatchQueue(label: "queue")
        queue.sync {
            for i in 0..<5 {
                print("number_A: ", i)
            }
        }
        queue.async {
            for i in 10..<15 {
                print("number_B: ", i)
            }
        }
        for i in 20..<25 {
            print("number_C: ", i)
        }
    }
    @IBAction func clickButtonAction(_ sender: Any) {
        // chạy dưới backgroup
      
        let url = URL(string: "https://thuthuatnhanh.com/wp-content/uploads/2018/07/hinh-nen-4k-dep-cho-may-tinh-tivi-smartphone.jpg")
        let queue = DispatchQueue(label: "queue")
        queue.async {
            do {
                let data = try Data(contentsOf: url!)
                // trở về main thress để up load giao diện
                DispatchQueue.main.async {
                    self.imageViewLoad.image = UIImage(data: data)
                }
            } catch {}
        }
        
    }
}

