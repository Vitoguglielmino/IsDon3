//
//  ProgramComplited.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 04/02/22.
//

import UIKit

class ProgramComplited: UIViewController {

    public var subjcetReceived : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        label1.text = "🏆"
        label2.text = "Programma di \(subjcetReceived ?? "") completato"
        print("😜", subjcetReceived as Any)
        
        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      //  self.view.endEditing(true)
        self.view.removeFromSuperview()
//        self.viewWillAppear(true)
        dismiss(animated: true, completion: nil)
    }

   
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    


}
