//
//  AlertPresenter.swift
//  AlbumList
//
//  Created by Abin Baby on 29/10/20.
//

import UIKit

class AlertPresenter {

    static func presentAlert(_ viewController: UIViewController, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        presentAlert(viewController, title: Alert.ErrorTitle, message: message, handler: handler)
    }

    static func presentAlert(_ viewController: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: Alert.okButtonLabel, style: .default, handler: handler)

        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: completion)
    }
}
