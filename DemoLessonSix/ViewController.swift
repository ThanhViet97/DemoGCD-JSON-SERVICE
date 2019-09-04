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
//        textGCD()
//        testDispatchQueueGroup()
        testDispatchSemaphore()
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
    
    // MARK: - Test DispatchQueueGroup
    func testDispatchQueueGroup()  {
        //tạo 2 hàng đợi
        let queue1 = DispatchQueue.global()
        let queue2 = DispatchQueue.global()
        //tạo 1 group
        let group = DispatchGroup()
        //add task vào queue1
        queue1.async(group: group, qos: .background, flags: .enforceQoS) {
            for _ in 0..<3 {
                print("queue1")
            }
        }
        //add task vào queue2
        queue2.async(group: group, qos: .background, flags: .enforceQoS) {
            for _ in 0..<4 {
                print("queue2")
            }
        }
        
        //Làm 1 vài việc
        print("1")
        print("1")
        print("1")
        
        //đợi những tác vụ trong group xong xuôi
        group.wait()
        
        //group xong thì làm tiếp việc khác
        print("2")
    }
    
    @IBAction func clickButtonAction(_ sender: Any) {
        // chạy dưới backgroup
      
        let url = URL(string: "https://thuthuatnhanh.com/wp-content/uploads/2018/07/hinh-nen-4k-dep-cho-may-tinh-tivi-smartphone.jpg")!
//        let queue = DispatchQueue(label: "queue")
//        queue.async {
//            do {
//                let data = try Data(contentsOf: url!)
//                // trở về main thress để up load giao diện
//                DispatchQueue.main.async {
//                    self.imageViewLoad.image = UIImage(data: data)
//                }
//            } catch {}
//        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dowloadGreoup = DispatchGroup()
            dowloadGreoup.enter()
            do{
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageViewLoad.image = UIImage(data: data)
                }
                dowloadGreoup.leave()
                dowloadGreoup.wait()
                
            } catch {}
            DispatchQueue.main.async {
                self.displayAlert()
            }
        }
    }
    func displayAlert(){
        let alert = UIAlertController(title: "Download", message: "The image downloads successful.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - DispatchSemaphore
    func testDispatchSemaphore() {
        func lema(completionHandler: (() -> Void)?) {
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                for i in 0..<3 {
                    print(i)
                }
                completionHandler?()
            }
        }
        print("start")
        //tạo một semaphore có value là 0
        let sema = DispatchSemaphore(value: 0)
        lema {
            print("Send sema")
            sema.signal()
        }
        sema.wait()
        print("end")
    }
    
}


