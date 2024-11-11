//
//  SecondoViewController.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 27/11/2021.
//

import UIKit
import RealmSwift


class SecondoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //Creo una variabile di tipo RealmProgramsList per andare a configurare la tableview, questa variabile infatti mi fornirà di tutti i dati presenti nel database
    var programTable : RealmProgramsList?
    // inizializzo la varibile come una array (inizialmente vuoto), per ogni programma di studio che inizializzo nell'app l'array cresce di un valore, questa variabile mi serve per aggiornare la viewcontroller dei programmi e far si che ogni volta che aggiungo un programama si aggiunga una table view
    var programTableObject : [RealmPrograms] = []
    
    enum Segues {
        static let toPageDone = "ToFirstVC"
    }
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.programTable = try RealmProgramsList.init()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
        } catch let e {
            print ("-------ERRORE-------", e)
        }

    // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == Segues.toPageDone {
//            let destVC = segue.destination as! ViewPageDone
//        }
//    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //attribuisco agli ogetti della table view i valori ottenuti dalla variabile program table e in caso non ci fosse nulla l'array di ritorno sarebbe vuoto
        self.programTableObject = self.programTable?.getAllPrograms() ?? []
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let programSelected = self.programTableObject[indexPath.row]
        print ("🧐" , #function, programSelected)
        self.performSegue(withIdentifier: "segueToDetail", sender: programSelected)
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is DetailProgramViewController{
            let dpvc = segue.destination as! DetailProgramViewController
            dpvc.receivedSubjectTitle = sender as? RealmPrograms
        }


    }
    }
    


extension SecondoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.programTableObject.count
        //con questa ultima stringa faccio si che i programmi visualizzati non siano un numero prefissato in partenza bensi il numero eguale a quanti sono i programmi settati dall'utente
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creao la costante ch emi richiama gli ogetti dal databse e indexPath.row mi serve per inizializzare i valori esattamente dove io voglio (guarda due righe sotto per capire
        let objectTable = self.programTableObject[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! SetTableViewCell
        cell.subjectLabel.text = objectTable.subjectTitle
        cell.pageToDoLabel.text = String (objectTable.pageNumber)
        cell.dayLabel.text = String (objectTable.dayNumber)
        cell.pageDoneLabel.text = String (objectTable.pageDone)
        return cell
    }
}

extension SecondoViewController: UITableViewDelegate{
    
    //QUESTA SECONDA ESTENSIONE L'HO CREATA PER IMPLEMENARE LA FUNZIONE DI DELETE QUANDO SI ESEGUE UNO SCROLL DAL SECONDO VIEW CONTROLLER .
    //ho creato la funzione delegata agli scroll sullo schermo, di seguito ho imposto che la funzione dovesse eseguire:
    //1. Creare una costante (che in realtà è variabile) che contiene l'ogetto del database che si vuole eliminare; per fare ciò ho aggiunto [indexPath.row]
    //2. Ho creato in persona la costante che farà eseguire tutta l'operazione, dopo aver impostato che tipo di costante è, lo stile e il titolo ho scritto tutto ciò che si doveva eseguire una volta chiamata:
    //     - dalla lista di programmi settati ho imposto che quando venisse
    //       eseguita l'operazione di delete si dovesse eliminare la riga di
//           competenza dalla lista (essendo che un programma si stava
//           cancellando) "self?.programTableObject.remove(at: indexPath.row)" ;
//           senza fare ciò il programma sarebbe andato in crash perchè il
//           numero di contenitori deve essere uguale al numero di cose che ci
//           sono dentro l'app.
//         - successivamente ho chiamato la funzione settata in SetDatabase di
//           delete e ho impostato come valore programToDelete che poco prima
//           aveva incamerato il valore della table da elminiare RICORDA!!
//         - concluso il lavoro sul database realm ho banalmente aggionato la
//           tableview con il semplice comando delle teble view
//           "self?.tableView.deleteRows(at: [indexPath], with: .automatic)" al
//           fine di far scomparire la tabella dalla vista dell'utente
//     3.Ho dato come valore di ritorno una swipeaction con valori uguali alla
//       costante appena imostata
    
   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let programToDelete = self.programTableObject[indexPath.row]
    let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
        self?.programTableObject.remove(at: indexPath.row)
        self?.programTable?.deletePrograms(_model: programToDelete)
        self?.tableView.beginUpdates()
        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        self?.tableView.endUpdates()
        
    }
      
    return UISwipeActionsConfiguration(actions: [delete])
    }
    
  
    }

