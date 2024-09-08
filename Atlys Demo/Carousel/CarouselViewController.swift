//
//  CarouselViewController.swift
//  Atlys Demo
//
//  Created by Harsh Pranay on 07/09/24.
//

import UIKit
class CarouselViewController: UIViewController {

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()

    var imageViews: [UIImageView] = []

    var viewModel: CarousalViewModel

    init(viewModel: CarousalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrolView()

        setupImageViews()

        setupPageControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Set initial scroll position to center the first image
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.contentOffset.x = self.calculateTargetOffset(forImageIndex: self.viewModel.images.count/2)
            self.zoomImageFor(self.viewModel.images.count/2)
        }
    }

    deinit {
        print("CarouselViewController Deinit Called")
    }

    private func setupScrolView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 350),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.images.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }

    private func setupImageViews() {
        var previousView: UIView?
        var totalContentWidth: CGFloat = 0

        for (_, imageName) in viewModel.images.enumerated() {
            let imageView = UIImageView(image: UIImage.getImage(for: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 30
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(imageView)
            imageViews.append(imageView)

            let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: viewModel.centerImageWidth)
            let heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) // 1:1 aspect ratio

            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint,
                imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])

            // Set leading/trailing constraints
            if let prevView = previousView {
                imageView.leadingAnchor.constraint(equalTo: prevView.trailingAnchor, constant: 20).isActive = true
            } else {
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
            }

            previousView = imageView
            totalContentWidth += viewModel.centerImageWidth + 20
        }

        if let lastView = previousView {
            lastView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        }

        scrollView.contentSize = CGSize(width: totalContentWidth, height: 350)
    }

    private func zoomImageFor(_ index: Int) {
        for (i, imageView) in imageViews.enumerated() {
            if i == index {
                UIView.animate(withDuration: 0.3) {
                    imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1) // Zoomed in by 10%
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    imageView.transform = CGAffineTransform.identity // Reset to original size
                }
            }
        }
    }

    private func calculateTargetOffset(forImageIndex index: Int) -> CGFloat {
        let pageWidth = viewModel.centerImageWidth + 20
        return CGFloat(index) * pageWidth - (viewModel.deviceWidth / 2) + (viewModel.centerImageWidth / 2)
    }

}

// MARK: - UIScrollViewDelegate Method
extension CarouselViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerOffset = scrollView.contentOffset.x + (viewModel.deviceWidth / 2)
        let pageWidth = viewModel.centerImageWidth + 20
        let currentPage = Int(centerOffset / pageWidth)

        pageControl.currentPage = currentPage
        zoomImageFor(currentPage)
    }
}
