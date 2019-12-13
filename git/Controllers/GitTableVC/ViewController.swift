//
//  ViewController.swift
//  git
//
//  Created by mostfa on 12/9/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import UIKit
import Lottie
import SkeletonView
class ViewController: UIViewController,Storyboarded  {
    private var fullDataSource = [GitItem]()
    weak var coordinator: MainCoordinator?
    private var finishedDragging = false
    private var paginationDatSource = [GitItem]()
    @IBOutlet weak var gitTable: UITableView!
    @IBOutlet weak var loadingView: AnimationView!
 
    //MARK:LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
         
   
        GetDataModel()
        setupTable()
        animationSetup()

    }
    //MARK: ANIMATION SETUP
    func animationSetup() {
        UIView.animate(withDuration: 1) {
           let radarAnimation = Animation.named("rader")
            self.loadingView.animation = radarAnimation
            self.loadingView.loopMode = .loop
            self.loadingView.play()
            self.loadingView.alpha = 1
        }
      

    }
    //MARK:Table setup
    private func updateTable() {
        //UPDATING UI IN MAIN THREAD
        DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
            self.gitTable.reloadData()

        }
    }
   

  
    private func setupTable() {
        gitTable.dataSource = self
        gitTable.delegate = self
        
        
    }

    //MARK: Fetch data model
    private func GetDataModel() {
        GitDataDownloader.shared.downloadRepos(for: "AFNetworking") { (items, error) in
            if error == .noConnection {
               //TODO: ADD NO Connection alert
                
            }
            
            guard error == nil else {return}
            self.removeLoading()
            self.fullDataSource = items!
            self.paginationDatSource = Array(items![0...6])
            self.updateTable()
        }

    }

}


//MARK:Tableview datasource
extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paginationDatSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitCell") as! GitItemTableViewCell
        let repo = paginationDatSource[indexPath.row]
        
        cell.configureForRepo(with: repo.name, description: repo.description ?? "No description", forkNumber: repo.forksCount,date: repo.formattedDate(),language: repo.language)
    
        cell.backImage.loadImage(urlString: repo.owner?.avatarUrl)
        
        return cell
   }
  
}


//MARK: Tableview delegate
extension ViewController:UITableViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        finishedDragging = true
    }
    
    /// SINCE THE API WE USED PROVIDE US THE FULL LIST OF REPOS,WILL USE THIS FUNCTION FROM DELEGATE TO ADD DATA TO CURRENT DATA SOURCE *AS* IF WE ARE FETCHING IT FROM THE INTERNET.
    /*
     By adding four items each time we reach the end of talbe view,also, we need to check that we won't exceed the index of the Full DataSource.
     finishedDragging is used to preform updates *only* when the end of the table is reached.
     */
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.paginationDatSource.count - 1 && finishedDragging  {

            if paginationDatSource.count < fullDataSource.count {

                let currentIndex = paginationDatSource.count  //current last item
                var lastOne = currentIndex + 4 //index of the last item in next fetch
                
                //CHECK THE LIMIT OF FULLDATASOURCE
                while(lastOne > self.fullDataSource.count-1) {
                    lastOne = lastOne-1
                    
                }
                
                paginationDatSource.append(contentsOf: Array(fullDataSource[currentIndex...lastOne]))
                //updating datasource
                DispatchQueueHelper.delay(bySeconds: 0.4) {
                      tableView.setContentOffset(CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y + 150), animated: true)
                
                self.updateTable()
                self.finishedDragging = false
                }
            }
    }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tell the coordinator to present safari controller with the url
        self.coordinator?.presentGitRepo(url: paginationDatSource[indexPath.row].htmlUrl)
    }

    
}


extension ViewController {
    private func removeLoading() {
          DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
              UIView.animate(withDuration: 0.1) {
                self.loadingView.alpha = 0
                self.loadingView.stop()
                       
                   }
          }
          
      }
    
}
