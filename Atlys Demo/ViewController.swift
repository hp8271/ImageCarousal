//
//  ViewController.swift
//  Atlys Demo
//
//  Created by Harsh Pranay on 07/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clickMeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedText = NSMutableAttributedString(
            string: "Click Me To see the Carousal",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )

        attributedText.addAttributes(
            [
                .font: UIFont.boldSystemFont(ofSize: 22)
            ],
            range: NSRange(location: 0, length: attributedText.length) // "Click Me" is 8 characters long
        )
        self.clickMeButton.setAttributedTitle( attributedText, for: .normal)
        self.clickMeButton.backgroundColor = .lightGray
        self.clickMeButton.layer.borderColor = UIColor.black.cgColor
        self.clickMeButton.layer.borderWidth = 1
        self.clickMeButton.layer.cornerRadius = 8
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let viewModel = CarousalViewModel()
        let carousel = CarouselViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(carousel, animated: false)
    }

    deinit {
        print("Main ViewController deinitialised")
    }
}

