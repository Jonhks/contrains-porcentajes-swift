//
//  ViewController.swift
//  countrains
//
//  Created by Jonh Parra on 24/10/19.
//  Copyright © 2019 Jonh Parra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contrainBottom: NSLayoutConstraint!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var descuento: UILabel!
    
    @IBOutlet weak var cantidadText: UITextField!
    
    @IBOutlet weak var porcentajeText: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responsiveCode()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFunc(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFunc(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFunc(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func responsiveCode () {
        if UIDevice().userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                print("Este es un iphone 5 o un SE")
            case 1334:
                print("Este es un iphone 6, 7 o 6S")
            case 1920:
                print(" Este es un iphone Plus")
            case 2436:
                print("Es el Iphone X y Xs")
            case 1792:
                print("Este es el Iphone XR")
                self.contrainBottom.constant = 340
            case 2688:
                print("Este es el iphone xsMax ")
            default:
                print("Este es un dispositivo de otro tamaño")
            }
        }
    }
    
    
    @objc func keyboardFunc (notificacion: Notification ) {
        guard let keyUpLet = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height == 1136 {
                self.view.frame.origin.y = -keyUpLet.height
            }
        } else {
            self.view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func calcular(_ sender: UIButton) {
        if  cantidadText.text != "" && porcentajeText.text != "" {
            self.view.endEditing(true)
            guard let cantidad = cantidadText.text else { return }
            guard let porcentaje = porcentajeText.text else { return }
            
            let cantNum = (cantidad as NSString).floatValue
            let porcNum = (porcentaje as NSString).floatValue
            
            let desc = cantNum * porcNum / 100
            let totalFinal = cantNum - desc
            
            total.text = "$\(totalFinal)"
            descuento.text = "$\(desc)"
        } else {
            let alert = UIAlertController(title: "alerta", message: "Los campos de cantidad y porcentaje no pueden ir vacios", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(accion)
            present(alert, animated: true, completion: nil )
        }
        
    }
    
    
    @IBAction func limpiar(_ sender: UIButton) {
        self.view.endEditing(true)
        total.text = "$0.00"
        descuento.text = "$0.00"
        cantidadText.text = " "
        porcentajeText.text = " "
    }
    
    
}

