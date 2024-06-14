//
//  ViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/13/24.
//

import UIKit

import Then
import SnapKit



class WelcomeViewController: UIViewController, Configurable {

    let mainTitleLabel = UILabel().then {
        $0.text = "MeaningOut"
        $0.font = Font.mainTitle
        $0.textColor = Color.mainColor
        $0.textAlignment = .center
    }
    
    let welcomeImageView = UIImageView().then {
        $0.image = UIImage(named: "launch")
        $0.contentMode = .scaleAspectFit
    }
    
    let startButton = LargeCapsuleButton(style: .start)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierachy()
        configureLayout()
        startButton.delegate = self
        
        // 네트워크 test
        Network.requestSearchResult(query: "가방")
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureHierachy() {
        view.addSubview(mainTitleLabel)
        view.addSubview(welcomeImageView)
        view.addSubview(startButton)
    }
    
    func configureLayout() {
        mainTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        welcomeImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mainTitleLabel).offset(50)
        }
        startButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}


extension WelcomeViewController: ButtonDelegate {
    
    func transfer(data: UIViewController) {
        print(#function)
        navigationController?.pushViewController(data, animated: true)
    }
}
