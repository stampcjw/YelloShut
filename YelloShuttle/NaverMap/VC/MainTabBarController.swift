//
//  MainTabBarController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/19.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["list.bullet", "map", "person.circle", "message"]
        let titles = ["탑승목록", "Map", "기사", "대화"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
            items[x].title = titles[x]
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                
//        // Specific Tab Disable
//        if let three = tabBarController.viewControllers?[2] {
//            return viewController != three
//        }
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("\(viewController) Tab selected")
    }
}
