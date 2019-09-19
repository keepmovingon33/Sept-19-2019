//
//  ViewController.swift
//  Sept-19-2019
//
//  Created by K Y on 9/19/19.
//  Copyright © 2019 K Y. All rights reserved.
//
extension UIView {
    func setupToFill(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}


extension Notification.Name {
    static let postYourName: Notification.Name = .init(rawValue: "post your name")
}

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var alertButton: UIButton!
    
    let name: String
    
    required init?(coder aDecoder: NSCoder) {
        name = String(Int.random(in: 0...1000))
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.backgroundColor = .blue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Go to next", for: .normal)
        alertButton.backgroundColor = .red
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.setTitle("Fire Alert", for: .normal)
        alertButton.addTarget(self,
                              action: #selector(fireAlert),
                              for: .touchUpInside)
        nextButton.addTarget(self,
                              action: #selector(makeNewVC),
                              for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        addSelfAsObserver()
    }
    
    // 1. register self onto NotificationCenter
    //    for some notificationName
    func addSelfAsObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveMessage),
                                               name: .postYourName,
                                               object: nil)
    }

    // 2. when I receive the notification,
    //    perform some task
    @objc func didReceiveMessage() {
        print(name)
    }

    // 3. Have some object POST the notification
    @objc func fireAlert() {
        NotificationCenter.default.post(Notification(name: .postYourName))
    }

    @objc func makeNewVC() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!
        present(vc, animated: true, completion: nil)
    }
}

