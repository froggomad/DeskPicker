//
//  ViewController.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/20/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit

class NotAShoppingListVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var deskDealer = FurnitureDealer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        deskDealer.makeDesksNotWar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmailListSegue" {
            guard let destination = segue.destination as? ConfirmationVC else {return}
            destination.furnitureDealer = deskDealer
        }
    }
    
    //MARK: Helper Methods
    func youTouchedIt(cell: DeskCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        
        //if var/guard var seems to be making a new instance of cell - it unwraps and the value changes, but if I check it after the guard var/if var - the value hasn't changed in the cell referenced in the function. So I'm doing it the forceful way which is fine since I'm checking for nil
        if cell.desk != nil {
            cell.desk!.wasTouched = !cell.desk!.wasTouched
        }
        animateCell(cell: cell)
        deskDealer.touchIt(forDesk: deskDealer.desks[indexPath.item])
    }
    
    func animateCell(cell: DeskCell) {
        if cell.desk != nil {
            if cell.desk!.wasTouched {
                UIView.animate(withDuration: 0.5) {
                   cell.backgroundColor = .green
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                   cell.backgroundColor = .red
                }
            }
        }
    }

}

extension NotAShoppingListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DeskCell else {return}
        youTouchedIt(cell: cell)
    }
}

extension NotAShoppingListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        deskDealer.desks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DeskCell else {return UICollectionViewCell()}
        cell.desk = deskDealer.desks[indexPath.item]
        animateCell(cell: cell) //doesn't animate, but it does set the cell color
//        if cell.desk!.wasTouched { //assigned on line above
//            //Initially I was reloading the collectionView in the helper method that sets the Bool. This caused a visual bug since all of the cells would animate from green to red (and some back to green depending on the Bool value). Instead, I also animated in the helper method, and removed the reloadData call since it's no longer needed.
              //MARK: VISUAL BUG: can be resolved by moving code to helper method and not reloading tableView
//            UIView.animate(withDuration: 0.5) {
//                cell.backgroundColor = .red
//            }
//        } else {
//            UIView.animate(withDuration: 0.5) {
//                cell.backgroundColor = .green
//            }
//        }
        //cell.delegate = self
        return cell
    }
}
