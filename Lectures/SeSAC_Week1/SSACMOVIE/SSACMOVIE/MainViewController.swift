//
//  MainViewController.swift
//  SSACMOVIE
//
//  Created by JD_MacMini on 2021/09/29.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var leftMovieButton: UIButton!
    @IBOutlet var middleMovieButton: UIButton!
    @IBOutlet var rightMovieButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonConfig()
        imageSetup()
    }
    
    func buttonConfig() {
        // playButton config
        playButton.layer.cornerRadius = 5
        playButton.setBackgroundImage(UIImage(named: "play_highlighted"), for: .highlighted)
        
        // movieButton config
        for button in [leftMovieButton, middleMovieButton, rightMovieButton] {
            button!.layer.borderWidth = 2
            button!.layer.borderColor = UIColor.systemGray3.cgColor
            button!.layer.masksToBounds = true
            button!.layer.cornerRadius = button!.frame.width * 0.5
        }
    }
    
    func imageSetup() {
        var randomNumbers: [Int] = []
        
        while randomNumbers.count < 4 {
            let randomNumber = Int.random(in: 1 ... 10)
            if randomNumbers.contains(randomNumber) {
                continue
            }
            else {
                randomNumbers.append(randomNumber)
            }
        }
        
        mainImageView.image = UIImage(named: "poster\(randomNumbers[0])")
        leftMovieButton.setImage(UIImage(named: "poster\(randomNumbers[1])"), for: .normal)
        middleMovieButton.setImage(UIImage(named: "poster\(randomNumbers[2])"), for: .normal)
        rightMovieButton.setImage(UIImage(named: "poster\(randomNumbers[3])"), for: .normal)
    }
    
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        imageSetup()
    }
}
