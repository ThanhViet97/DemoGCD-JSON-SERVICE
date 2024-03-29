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
    @IBOutlet weak var dowloadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var operationImage: UIImageView!
    
    let queue = DispatchQueue(label: "queue")
     let url = URL(string: "https://thuthuatnhanh.com/wp-content/uploads/2018/07/hinh-nen-4k-dep-cho-may-tinh-tivi-smartphone.jpg")!
    
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
    
// MARK: - IB_Action
    @IBAction func clickButtonAction(_ sender: Any) {
        // chạy dưới backgroup
      
       
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
                let data = try Data(contentsOf: self.url)
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
    
    @IBAction func dowloadAction(_ sender: AnyObject) {
        // 1. initialize NSOperationQueue instance
        let queue = OperationQueue()
        // 2. initialize NSBlockOperation instance - subClass of NSOperation
        let operation1 = BlockOperation(block: {
            // 3. add NSOperation to main queue
            let urlImage1 = "https://thuthuatnhanh.com/wp-content/uploads/2018/07/hinh-nen-4k-dep-cho-may-tinh-tivi-smartphone.jpg"
            self.downloadImageWithURL(url: urlImage1)
        })
        // 4. add completion block to operation
        operation1.completionBlock = {
            print("Operation 1 completed")
        }
        // 5. add NSOperation to NSOperationQueue
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {

            let urlImage2 = "https://motosaigon.vn/wp-content/uploads/2016/05/Vespa-Sprint-150-2-3248-1388134397.jpg"
            self.downloadImageWithURL(url: urlImage2)
        })
        
        // 6. add dependency: operation 2 depend on operation 1
        operation2.addDependency(operation1)
        operation2.completionBlock = {
            print("Operation 2 completed")
        }
        queue.addOperation(operation2)
        
        let operation3 = BlockOperation(block: {
            let urlImage3 = "https://file.xemaycugiare.com/2016/05/24/ca6b5c6a82498-97e1.jpg"
            self.downloadImageWithURL(url: urlImage3)
        })
        operation3.completionBlock = {
            print("Operation 3 completed")
        }
        queue.addOperation(operation3)
        let operation4 = BlockOperation(block: {
            let urlImage4 = "http://tiepthitieudung.com/upload_images/images/2016/07/13/lu%20udng/vespa.jpg"
            self.downloadImageWithURL(url: urlImage4)
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed")
        }
        queue.addOperation(operation4)
    }
  
// MARK: - method
    // download image function
    func downloadImageWithURL(url:String) {
        do{
            let urls = URL(string:url)!
            let data = try Data(contentsOf: urls)
            OperationQueue.main.addOperation({
                self.operationImage.image = UIImage(data: data)
            })
        } catch {}
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
    @IBAction func cancelAction(_ sender: AnyObject) {
        
        let jsonUrdString = "https://api.github.com/users/google/repos"
        guard let url = URL(string: jsonUrdString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, respont, erroi) in
            
            guard let data = data else { return }
//
//            let dataAsString = String(data: data,encoding: .utf8)
//            print(dataAsString)
            do {
                let githubData = try JSONDecoder().decode([GithubData].self, from: data)
                

                print(githubData[1].owner!.id!)
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }.resume()
        
//        let myData = dataJsion(id: 1, node_id: "note", name: "Viet", full_name: "Phan Thanh Viet")
//        print(myData)
        
    }
    
    
}


