//
//  VC2.swift
//  OpenAPI
//
//  Created by 최정민 on 2021/03/03.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

let apiKey = "b39aeb1e660919371efad86125f1a70d"

class VC2: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        let tableView_Nib = UINib(nibName: "TableViewCell", bundle: nil)
        
        tableView.register(tableView_Nib, forCellReuseIdentifier: "cell1")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("First : viewWillDisappear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("First : viewDidDisappear")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("First : viewWillDisappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("First : viewDidDisappear")
        
    }

}


extension VC2: UITableViewDataSource{
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCell else  {
            return UITableViewCell()
        }
 
        print(indexPath.row)
        
//        cell.Title.text =
        
        
       return cell
    }
    
 
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//        self.performSegue(withIdentifier: "VC2toVC3", sender: nil)
//    }
    
    
       
}


extension VC2: UITableViewDelegate{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let dest = segue.destination
//
//        guard let VC3 = dest as? VC3 else{
//            return
//        }
        
//        VC3.idx = self.idx
//        VC3.idxpath = self.idxpath
//        VC3.Content = V2ContactContentArray[idxpath]
//        VC3.Title = V2ContactTitleArray[idxpath]
            
//        print("self idx : ",self.idx)
//        print("VC2 idx : ",VC3.idx)
//
//
        
        
    }
    
    
    func getCurrentWeather(lat:Double , lon:Double){
        //접근하고자 하는 URL 정보
        let URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric&lang=kr"

        AF.request(URL).responseJSON { response in
                    let result = response.result
                  
                    switch result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        print("success")
                        print(json)
                        
                    case .failure(let error):
                        print(error.errorDescription ?? "")
                    default:
                        fatalError()
                    }
                }
        
        

    }
    
}
