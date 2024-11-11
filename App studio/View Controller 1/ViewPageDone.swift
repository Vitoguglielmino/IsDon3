//
//  ViewPageDone.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 31/01/22.
//

import Foundation

import UIKit
import RealmSwift
import SwiftUI



class ViewPageDone: UIViewController, UIApplicationDelegate {
    
  

    @IBOutlet weak var Prova1: UIButton!
    @IBOutlet weak var Menu_Prova1: UIMenu!
    @IBOutlet weak var addButton1: UIButton!
    @IBOutlet weak var pageStudiedText1: UITextField!
    
    var objectEventTable : RealmProgramsList?
    var eventTable : [RealmPrograms] = []
    var menuItems = [String]()
    var actions = [UIMenuElement]()
    
    
    
    //Il codice funziona : la funzione get subject estrapola tutti i programmi dal database e con un ciclo assegna assegna alla costante let title un 'array con tutti i titoli dei programmi del databse. I risultati verranno aggiunti alla variabile menuitems

    func getSubject()  {
        let realm = try! Realm.init()
        let subjectResult = realm.objects(RealmPrograms.self)

        for result in subjectResult {
            let title = result.subjectTitle
            menuItems.append(title!)
            print(title ?? "" )
        }
       print ("🤖 ITEMS : " , menuItems)
     
}

    //la funzione create Items, a sua volta, prende i risultati della funzione prima (e quindi da menùitems) e con un altro ciclo assegna tutti gli elementi alla costante newaction che crea delle UiAction . Le stesse verrano aggiunte alle costante actions
    
    func createItems()  {
        let items = menuItems
        
        for action in items {
        let newAction = UIAction(title: action,  handler: { (_) in })
        
        actions.append(newAction)
    }

 
}
  
    
//    override func buildMenu(with builder: UIMenuBuilder) {
//        Prova.menu = UIMenu(title: "",  children: actions)
//    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.becomeFirstResponder()
        _ = UIRefreshControl()

        print ("👽" ,menuItems)

        createItems()
        

//        let menù = UIMenu(title: "", children: actions.self)
//
//        Prova.menu = menù
//    Prova.menu = UIMenu(title: "", children: actions.self)
//       self.Prova.showsMenuAsPrimaryAction = true

   }
   
    //questa funzione sicuramente è superflua, rimuove tutti i valori che ci sono nella costante actions
    func removeAction(){
        actions.removeAll()
    }
    
    //viewWillAppear= Ogni volta che apro il viewController viewWillAppear esegue qualcosa, in questo caso:
    // appena apro la pagina vengono rimossi gli elementi di menuItems. Dopo, con la funzione getsubject() riinizia il ciclo e vengono creati da capo gli elementi da aggiungere a meuItems. Analogamente faccio lo stesso con le action con la funzione removeAction, Imposto che in questo momento il menù del pulsante sia vuoto. Ora che tutti i valori sono azzerati chiamo la funzione createItems (che fa iniziare il ciclo con gli oggetti di getSubject creato 2 righe prima) e con i risultati di create items creo il popUpMenù con i risultati di createitems().
    //eseguo tutti questi passaggi poichè se non ci fossero gli iniziali comandi di "cancellazione" dei valori i cicli aggiungerebbero all'infinito gli stessi valori ogni volta che clicco il viewController
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
//        self.viewDidLoad()
        menuItems.removeAll()
        getSubject()
        removeAction()
        Prova1.menu = ._nilValue()
        createItems()
        
        if actions.isEmpty == true {
            Prova1.isEnabled = false
        }else {
        
  //      let menù = UIMenu(title: "", children: actions.self)
            Prova1.isEnabled = true
        Prova1.menu = UIMenu(title: "", children: actions.self)
        }

//
       print("😘" ,actions)
}
    
    
    func addPageDone(){
        
    guard
        let pageDoneText: Int =
            Int(self.pageStudiedText1.text!),
        !pageDoneText.isMultiple(of: 0)
        else{
            print("error")
            return
        }

        
        let realm = try! Realm.init()
        let subjectResult = realm.objects(RealmPrograms.self)
        
        let ciao = "\(Prova1.currentTitle ?? "")"
        
        print(ciao)
//        let name = "Cazzarola"
        
        for item in subjectResult.filter("subjectTitle = %@", ciao) {
           try! realm.write{
               item.pageDone = item.pageDone +
               pageDoneText
            }
            
        }
        
        
    }

    
    @IBAction func add_buttonClicked(_ sender: UIButton) {
        addPageDone()
        
        
    }
    


     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    @IBAction func menu_buttonClicked(_ sender: Any) {
        
        if actions.isEmpty == true {
            Prova1.menu = ._nilValue()
        }else {
        
  //      let menù = UIMenu(title: "", children: actions.self)

        Prova1.menu = UIMenu(title: "", children: actions.self)
        }

        
    }
}

