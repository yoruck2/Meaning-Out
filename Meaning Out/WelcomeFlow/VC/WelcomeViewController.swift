//
//  ViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/13/24.
//

import UIKit

import Then
import SnapKit



class WelcomeViewController: MeaningOutViewController, Configurable {
    
    let mainTitleLabel = UILabel().then {
        $0.text = "MeaningOut"
        $0.font = Font.mainTitle
        $0.textColor = .main
        $0.textAlignment = .center
    }
    
    let welcomeImageView = UIImageView().then {
        $0.image = UIImage(named: "launch")
        $0.contentMode = .scaleAspectFit
    }
    
    let startButton = LargeCapsuleButton(style: .start)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        startButton.delegate = self
        
        // 네트워크 test
        Network.requestSearchResult(query: "가방")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureHierachy() {
        view.addSubview(mainTitleLabel)
        view.addSubview(welcomeImageView)
        view.addSubview(startButton)
    }
    
    func configureLayout() {
        mainTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        welcomeImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mainTitleLabel).offset(140)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

extension WelcomeViewController: SendDataDelegate {
    
    func transfer(data: Any) {
        navigationController?.pushViewController(data as! UIViewController, animated: true)
    }
}
