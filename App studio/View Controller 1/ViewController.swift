//
//  ViewController.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 23/11/2021.
//

import UIKit
import EventKit
import SwiftUI
import RealmSwift



class ViewController: UIViewController, UITableViewDelegate, UIGestureRecognizerDelegate {

  
    
    
    @IBOutlet weak var labelDiProva: UILabel!
     
    @IBOutlet weak var tableView: UITableView!
   

    var objectEventTable : RealmProgramsList?
    var eventTable : [RealmPrograms] = []
    var howManyPage : Double = 0.0
    var menuItems = [String]()
    var actions = [UIMenuElement]()
    
    
    
    //ciò che è scritto qua sono delle funzioni per far si che la tastiera si abbassi quando viene cliccato il tasto fatto o comunque qualsiasi altra parte dello schermo
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    


    
    
     override func viewDidLoad() {
        super.viewDidLoad()
         dependingDays()
         view.becomeFirstResponder()
      
        
        do {
            self.objectEventTable = try RealmProgramsList.init()
            self.tableView.delegate = self
            self.tableView.dataSource = self
           

        } catch let e {
            print ("-------ERRORE-------", e)
        }
         


    }
    
    // la funzione si compoerta nel seguente: ho inizializzato una variabile di tipo RealmPrograms vuota e qui andò a mettere il porgramma da eliminare. eseguo un ciclo cosi da trovare i programmi che ho sono finiti oppure per la quale è avvenuta la scadenza e li aggiungo alla variabile (la variabile ne accoglierà uno alla volta, ma sarà sufficiente) successivamente impongo una struttura di if poichè se non c'è nessun programma da eliminare l'app continua normalmente, in caso contrario eliminai il programma. l'istruzzione print serve per un' idea successiva ma è importante chiamarla prima della funzione che elimina il porgramma poiche se la eseguo dopo è come se cercassi di scrivere un qualcosa che è già stato eliminato. In conclusione riaggionro l'array con tutti i programmi restanti e riaggiorno la tableview 
    
    
    func deleteComplited()  {
        var programsToDelete1 : RealmPrograms? = nil
        
        for programs in eventTable{

            if programs.pageDone >= programs.pageNumber || programs.dayNumber < 0  {
         
                programsToDelete1 = programs

            }else{

        }
           
            if programsToDelete1 != nil {
            print("\((programs.subjectTitle) ?? "") COMPLETATA")
        //    objectEventTable?.deletePrograms(_model: programsToDelete1!)
                
//                func prepare(for segue: UIStoryboardSegue, sender: Any?){
//                    if segue.destination is ProgramComplited{
//                        let dpvc = segue.destination as! ProgramComplited
//                        dpvc.subjcetReceived = programsToDelete1?.subjectTitle
//                    }
//                }
                
                
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "complitedPopUpVC") as! ProgramComplited
                self.addChild(popOverVC)
                popOverVC.subjcetReceived = programsToDelete1!.subjectTitle
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: self)
                
//                override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//                    if segue.destination is DetailProgramViewController{
//                        let dpvc = segue.destination as! DetailProgramViewController
//                        dpvc.receivedSubjectTitle = sender as? RealmPrograms
//                    }
                

                
                
                objectEventTable?.deletePrograms(_model: programsToDelete1!)
                
                
            }else{
            }
        
        self.eventTable = self.objectEventTable?.getAllPrograms() ?? []
        self.tableView.reloadData()
        
    }
    }
    


    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.eventTable = self.objectEventTable?.getAllPrograms() ?? []
            self.tableView.reloadData()
    
         deleteComplited()
    
}
        

//Con questa funzione ricevo il maseggio dal PageDoneContainer di riaggiornare la tableview quando clicca il pulsante aggiungi-------- prima di riaggiornare la tableview ho aggiunto la funzione deleteComplited che sarebbe un controllo : l'app eseguendo la funzione controlla se un porgramma di studio è finitio cosichhè in tempo reale qunaod viene cliccato il tasto aggiungi viene eliminato il possibile programma finito  https://www.semicolonworld.com/question/75944/how-to-reload-tableview-from-another-view-controller-in-swift
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
            self.deleteComplited()
                self.tableView.reloadData()
                
            }
        }
    }
    

    
}

extension ViewController {
    func dependingDays(){
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE MMM d yyyy")
        print ("😶‍🌫️ \(dateFormatter.string(from: Date()))")
        if dateFormatter.string(from: Date()).lowercased().hasPrefix("mon") || dateFormatter.string(from: Date()).lowercased().hasPrefix("lun"){
            labelDiProva.text = " Buon lunedi "
            
        }else if dateFormatter.string(from: Date()).lowercased().hasPrefix("thu") || dateFormatter.string(from: Date()).lowercased().hasPrefix("mar")  {
            labelDiProva.text = "Buon martedì"
        }
        else if dateFormatter.string(from: Date()).lowercased().hasPrefix("wed") || dateFormatter.string(from: Date()).lowercased().hasPrefix("mer") {
            labelDiProva.text = " Buon mercoledì"
        }
        else if dateFormatter.string(from: Date()).lowercased().hasPrefix("tue") || dateFormatter.string(from: Date()).lowercased().hasPrefix("gio") {
            labelDiProva.text = " Buon giovedì"
        }
        else if dateFormatter.string(from: Date()).lowercased().hasPrefix("wed") || dateFormatter.string(from: Date()).lowercased().hasPrefix("ven") {
            labelDiProva.text = " Buon venerdì"
        }
        else if dateFormatter.string(from: Date()).lowercased().hasPrefix("sat") || dateFormatter.string(from: Date()).lowercased().hasPrefix("sab") {
            labelDiProva.text = " Buon Sabato"
        }
        else if dateFormatter.string(from: Date()).lowercased().hasPrefix("sun") || dateFormatter.string(from: Date()).lowercased().hasPrefix("dom") {
            labelDiProva.text = " Buona Domenica 🎉"
        }
        
    }
}

//Table view
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.eventTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = self.eventTable[indexPath.row]
        
        let pageTotal = object.pageNumber - object.pageDone

            let cellEvent = tableView.dequeueReusableCell(withIdentifier: "eventDay1", for: indexPath) as! SetTableViewEvent
        
        cellEvent.subject.text = object.subjectTitle
        cellEvent.pageDay.text = String("Mancano da studaire \(Int(pageTotal)) pagine di \(object.subjectTitle!) studiando \(Int(object.pageForDay) ) al giorno ")
        
        return cellEvent

    }

}

