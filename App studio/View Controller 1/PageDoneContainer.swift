//
//  TerzoController.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 31/01/22.
//

import UIKit
import RealmSwift
import SwiftUI

class PageDoneContainer: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var textPageDone: UITextField!
    
    @IBOutlet weak var subject_Menu: UIButton!
    @IBOutlet weak var addPage: UIButton!
    
    @IBOutlet weak var menu: UIMenu!
    
    var objectEventTable : RealmProgramsList?
    var eventTable : [RealmPrograms] = []
    var menuItems1 = [String]()
    var actions1 = [UIMenuElement]()
    
    //Questa funzioen serve per far tornare l'app al suo posto quando per esempio tocco un punto qualsiasi e c'è la tastiera alzata, quindi si abbassa
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Il codice funziona : la funzione get subject estrapola tutti i programmi dal database e con un ciclo assegna assegna alla costante let title un 'array con tutti i titoli dei programmi del databse. I risultati verranno aggiunti alla variabile menuitems
    func getSubject()  {
        let realm = try! Realm.init()
        let subjectResult = realm.objects(RealmPrograms.self)

        for result in subjectResult {
            let title = result.subjectTitle
            menuItems1.append(title!)
            print(title ?? "" )
        }
       print ("🤖 ITEMS : " , menuItems1)
     
}
    
    //la funzione create Items, a sua volta, prende i risultati della funzione prima (e quindi da menùitems) e con un altro ciclo assegna tutti gli elementi alla costante newaction che crea delle UiAction . Le stesse verrano aggiunte alle costante actions
    func createItems()  {
        let items1 = menuItems1
        
        for action in items1 {
        let newAction = UIAction(title: action,  handler: { (_) in })
        
        actions1.append(newAction)
    }

}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.becomeFirstResponder()
        
        do {
            self.objectEventTable = try RealmProgramsList.init()
        } catch let e {
            print ("-------ERRORE-------", e)
        }
        
  


   
    }
    
//    func removeAction(){
//        actions1.removeAll()
//    }
    
    //viewWillAppear= Ogni volta che apro il viewController viewWillAppear esegue qualcosa, in questo caso:
    // appena apro la pagina vengono rimossi gli elementi di menuItems. Dopo, con la funzione getsubject() riinizia il ciclo e vengono creati da capo gli elementi da aggiungere a meuItems. Analogamente faccio lo stesso con le action con la funzione removeAction, Imposto che in questo momento il menù del pulsante sia vuoto. Ora che tutti i valori sono azzerati chiamo la funzione createItems (che fa iniziare il ciclo con gli oggetti di getSubject creato 2 righe prima) e con i risultati di create items creo il popUpMenù con i risultati di createitems().
    //eseguo tutti questi passaggi poichè se non ci fossero gli iniziali comandi di "cancellazione" dei valori i cicli aggiungerebbero all'infinito gli stessi valori ogni volta che clicco il viewController
    func setMenuItems(){
        self.eventTable = self.objectEventTable?.getAllPrograms() ?? []
   
        print("\(eventTable)")
        menuItems1.removeAll()
        getSubject()
        actions1.removeAll()
        
        subject_Menu.menu = ._nilValue()
        createItems()
        
        if actions1.isEmpty == true {
            subject_Menu.menu = ._nilValue()
            subject_Menu.isEnabled = false
            subject_Menu.setTitle("Non ci sono materie", for: .disabled)
        }else {
        
  //      let menù = UIMenu(title: "", children: actions.self)
            subject_Menu.isEnabled = true
            subject_Menu.menu = UIMenu(title: "", children: actions1.self)
        }
        

        

    
       print("😘" ,actions1)
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
//        self.viewDidLoad()
   
        setMenuItems()
        

        
        //metto questa funzione cosicchè ogni volta che l'utente cambia pagina viene resettato il campo di testo se no rimarrebbe il numero
        textPageDone.text?.removeAll()
        
    

    
}
    
    func addPageDone(){
        
        //Prendo il parametro inserito dall'utente nel campo di testo
    guard
        let pageDoneText: Int =
            Int(self.textPageDone.text!),
        !pageDoneText.isMultiple(of: 0)
        else{
            print("error")
            return
        }

        // con subjectResult prendo tutti i programmi che sono salvati nel database
        let realm = try! Realm.init()
        let subjectResult = realm.objects(RealmPrograms.self)
        
        //questa costante serve per capire quale materia è stata selezionata, quando tu cambi materia è ovvio che si cambia anche il current Title
        let ciao = "\(subject_Menu.currentTitle ?? " " )"
        
        print(ciao)

       
        // faccio un ciclo tra tutti i parametri del databaser e li filtro, l'obiettivo è quello di intercettare la materia selezionata dal pulsante ed andare a modificare il suo valore pageDone,
        for item in subjectResult.filter("subjectTitle = %@", ciao) {
           try! realm.write{
               item.pageDone = item.pageDone +
               pageDoneText
            }
        }
        
        
    }
    
    //funzione che salva le modifche(aggiunta pagine studiate) precedentemente effettuate nel data
    @IBAction func add_buttonClicked(_ sender: UIButton) {
                addPageDone()
        setMenuItems()


                
        //Questa stringa di sotto invia un segnale al ViewController per far si che si aggiornino le tableView (ho fatto una cosa strana https://www.semicolonworld.com/question/75944/how-to-reload-tableview-from-another-view-controller-in-swift
        self.performSegue(withIdentifier: "reloadTable", sender: self)
        

        
        //fa si che quando clicchi il bottone aggiungi si abbassa la tasitera
        textPageDone.resignFirstResponder()
        
    //fa si che quando clicchi il bottone aggiungi la textfield torna vuota
        textPageDone.text?.removeAll()
    }
    
    //questa funzione fa si che se non ci sono programmi il pulsante del menù è spento, viceversa mostra le materie
    @IBAction func menu_buttonClicked(_ sender: Any) {
        
        setMenuItems()
        
        if actions1.isEmpty == true {
            subject_Menu.menu = ._nilValue()
            subject_Menu.isEnabled = false
        }else {
        
  //      let menù = UIMenu(title: "", children: actions.self)

        subject_Menu.menu = UIMenu(title: "", children: actions1.self)
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



