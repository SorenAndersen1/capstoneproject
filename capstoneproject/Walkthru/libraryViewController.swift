//
//  libraryViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//

import UIKit
private let reuseIdentifier = "LibraryCollectionCell"
class libraryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {
    let numWalkThrus = 3
    let nameLabels = ["Air Filter Replacement: 2007 Kia Rondo", "Setup Cadoo Deluxe Edition", "Making A PB&J"]
    let descrLabels = [" Replace a tired air filter for your 2007 Kia Rondo! No tools nessecary, only new air filter.", "I First time playing cadoo? No problem! This guide instructs you on how to setup Cadoo Deluxe Edition.", "Instruction Description: Make a delicious peanut butter and jelly sandwich. Requires: Plate, Bread, Jelly, and peanut butter."]
    let imageArr = [UIImage(named: "1StarRating"), UIImage(named: "1StarRating"), UIImage(named: "3StarRating"),UIImage(named: "4StarRating"), UIImage(named: "5StarRating")]
    let currentLibrary = ["airFilter", "cadoo", "pbj"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numWalkThrus
    }

    @IBAction func oneStarPressedButton(sender: UIButton, forEvent event: UIEvent){
        var currentCells = libraryCollectionView.visibleCells as! [LibraryCollectionCell]

        currentCells.swapAt(0,1)

        currentCells[sender.tag].ratingImage.image = UIImage(named: "1StarRating")
    }
    @IBSegueAction func createSegue(_ coder: NSCoder) -> CreateViewController? {
        return CreateViewController(coder: coder)
    }
    @IBAction func twoStarPressedButton(sender: UIButton, forEvent event: UIEvent){
        var currentCells = libraryCollectionView.visibleCells as! [LibraryCollectionCell]

        currentCells.swapAt(0,1)
        currentCells[sender.tag].ratingImage.image = UIImage(named: "2StarRating")
    }
    @IBAction func threeStarPressedButton(sender: UIButton, forEvent event: UIEvent){
        var currentCells = libraryCollectionView.visibleCells as! [LibraryCollectionCell]

        currentCells.swapAt(0,1)
        currentCells[sender.tag].ratingImage.image = UIImage(named: "3StarRating")
    }
    @IBAction func fourStarPressedButton(sender: UIButton, forEvent event: UIEvent){
        var currentCells = libraryCollectionView.visibleCells as! [LibraryCollectionCell]

        currentCells.swapAt(0,1)
        currentCells[sender.tag].ratingImage.image = UIImage(named: "4StarRating")
    }
    @IBAction func fiveStarPressedButton(sender: UIButton, forEvent event: UIEvent){
        var currentCells = libraryCollectionView.visibleCells as! [LibraryCollectionCell]

        currentCells.swapAt(0,1)
        currentCells[sender.tag].ratingImage.image = UIImage(named: "5StarRating")
    }
    
    @IBAction func instructSelect(sender: UIButton, forEvent event: UIEvent){

        performSegue(withIdentifier: "arSegue",
                   sender: sender)
    }

    @IBSegueAction func arSegue(_ coder: NSCoder) -> ArViewController? {
        return ArViewController(coder: coder)
    }
    @IBOutlet var libraryCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionCell", for: indexPath) as! LibraryCollectionCell
        cell.starRating = indexPath.row
        cell.fiveStarButton.tag = indexPath.row
        cell.fourStarButton.tag = indexPath.row
        cell.threeStarButton.tag = indexPath.row
        cell.twoStarButton.tag = indexPath.row
        cell.oneStarButton.tag = indexPath.row
        cell.oneStarButton.addTarget(self, action: #selector(oneStarPressedButton), for: .touchUpInside)
        cell.twoStarButton.addTarget(self, action: #selector(twoStarPressedButton), for: .touchUpInside)
        cell.threeStarButton.addTarget(self, action: #selector(threeStarPressedButton), for: .touchUpInside)
        cell.fourStarButton.addTarget(self, action: #selector(fourStarPressedButton), for: .touchUpInside)
        cell.fiveStarButton.addTarget(self, action: #selector(fiveStarPressedButton), for: .touchUpInside)
        cell.nameLabel.text = "\(indexPath.row + 1). " + nameLabels[indexPath.row]
        cell.descrLabel.text = "Instruction Description: " + descrLabels[indexPath.row]
        cell.instructSelectButton.addTarget(self, action: #selector(instructSelect), for: .touchUpInside)
        cell.instructSelectButton.tag = indexPath.row
        cell.ratingImage.image = imageArr[cell.starRating]
        return cell
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArViewController {
            if let senderButton = sender as? UIButton{
                print(senderButton.tag)

                vc.hardCodeType = currentLibrary[senderButton.tag]
            }
        }
    }
}
            
