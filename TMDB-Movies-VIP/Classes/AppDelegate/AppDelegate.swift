//
//  AppDelegate.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = UIStoryboard(name: "UpcomingMovies", bundle: nil).instantiateViewController(withIdentifier: "UpcomingMoviesViewController") as! UpcomingMoviesViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

