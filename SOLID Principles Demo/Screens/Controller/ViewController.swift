//
//  ViewController.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 12/29/20.
//

import UIKit

class ViewController: UIViewController {
    var service:NetworkCleint!
    var fetcher: ParserJsonSerialization!
    var tapGesture: UITapGestureRecognizer!
    
    let strUrl = "https://jsonplaceholder.typicode.com/posts"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapPhotoDetails(_:)))
//        self.service = NetworkCleint()
//        self.service.requestAPI(URLRequest(url: URL(string: strUrl)!))
        
    }
    
    @objc func tapPhotoDetails(_ sender: UITapGestureRecognizer) {
        print("Tap Tap!!")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetcher = ParserJsonSerialization(networkManager: NetworkManager())
        /*
        self.fetcher.parser(forType: Splash.self) { result in
            switch result {
            case .success(let splash):
                guard let photos = splash.images else { return }
                print("photos count = \(photos.count)")
            case .failure(let error):
                print("error - \(error.localizedDescription)")
            }
        }
        */
        self.fetcher.parser(query: "House") { result in
            switch result {
            
            case .success(let obctData):
                print("Success \(obctData)")
            case .failure(let error):
                print("error - \(error.localizedDescription)")
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewsDemo()
    }
    
    func viewsDemo() {
        self.view.backgroundColor = .systemGray4
        
        let redView = UIView()
        redView.backgroundColor = .red
        let greenView = UIView()
        greenView.backgroundColor = .green
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let blackView = UIView()
        blackView.backgroundColor = .black
        let clearView = UIView()
        clearView.backgroundColor = .clear
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        
        let pet1ImageView = UIImageView(image: UIImage(named: "pic1"))
        let pet2ImageView = UIImageView(image: UIImage(named: "pic2"))
        let pet3ImageView = UIImageView(image: UIImage(named: "pic3"))
        let pet4ImageView = UIImageView(image: UIImage(named: "pic4"))
      
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 5, y: 14.5, width: 200, height: 21)
        nameLabel.text = "My Favorite pets"
        nameLabel.textColor = .black
        whiteView.addSubview(nameLabel)
        
        let nameLabelIntro = UILabel()
        nameLabelIntro.text = "Comment"
        nameLabelIntro.textColor = .black
        nameLabelIntro.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        nameLabelIntro.font =  UIFont(name: nameLabelIntro.font.fontName, size: 20)
        clearView.addSubview(nameLabelIntro)


      
        [redView, greenView, blueView, blackView, clearView, whiteView].forEach { view.addSubview($0)}
        
        greenView.anchorEqualWidthHeigh(to: redView)
                
        
        whiteView.layer.cornerRadius = 15.0
        redView.addSubview(pet1ImageView)
        greenView.addSubview(pet2ImageView)
        blueView.addSubview(pet3ImageView)
        blackView.addSubview(pet4ImageView)
        
        pet1ImageView.anchor(top: redView.topAnchor, leading: redView.leadingAnchor, trailing: redView.trailingAnchor, botton: redView.bottomAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        pet2ImageView.anchor(top: greenView.topAnchor, leading: greenView.leadingAnchor, trailing: greenView.trailingAnchor, botton: greenView.bottomAnchor)
        pet3ImageView.anchor(top: blueView.topAnchor, leading: blueView.leadingAnchor, trailing: blueView.trailingAnchor, botton: blueView.bottomAnchor)
        
        pet4ImageView.anchor(top: blackView.topAnchor, leading: blackView.leadingAnchor, trailing: blackView.trailingAnchor, botton: blackView.bottomAnchor)
        
        redView.anchor(top: view.safeAreaLayoutGuide.topAnchor,trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12), size: CGSize(width: 100, height: 100))
        greenView.anchor(top: redView.bottomAnchor,trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 12))
        
        blueView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: redView.leadingAnchor, botton: greenView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        
        blackView.anchor(top: blueView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10),size: CGSize(width: 0, height: 300))
        
        clearView.anchor(top: blackView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10),size: CGSize(width: 0, height: 30))
        
        whiteView.anchor(top: clearView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10),size: CGSize(width: 0, height: 50))
        
    }
}

extension UIView {
    func anchorEqualWidthHeigh(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true;
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, botton: NSLayoutYAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size:CGSize = .zero) {
       
        //Enables outo layout
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let botton = botton {
            bottomAnchor.constraint(equalTo: botton, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

