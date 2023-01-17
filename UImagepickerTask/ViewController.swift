//
//  ViewController.swift
//  UImagepickerTask
//
//  Created by Jenith on 17/01/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController,PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage{
                    self.imageArray.append(image)
                }
                DispatchQueue.main.async {
                    self.myCollection1.reloadData()
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    var imageArray = [UIImage]()
    @IBOutlet weak var myCollection1: UICollectionView!
    @IBAction func addPressed(_ sender: UIButton) {
  
        var config = PHPickerConfiguration()
        config.selectionLimit = 2
        let VC = PHPickerViewController(configuration: config)
        VC.delegate = self
        self.present(VC, animated: true)
        
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onecell", for: indexPath) as? oneCollectionViewCell
            else{
            return UICollectionViewCell()
        }
        cell.cellimage.image = imageArray[indexPath.row]
        return cell
}


}
