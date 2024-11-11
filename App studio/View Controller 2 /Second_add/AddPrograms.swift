//
//  AddPrograms.swift
//  Ilmioprototipo
//
//  Created by Vito Guglielmino on 05/12/2021.
//

import UIKit
import Foundation
import EventKit

class AddPrograms: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleSubjectText: UITextField!
    @IBOutlet weak var pageText: UITextField!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var labelPage: UILabel!
    
  
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thurdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    var programList: RealmProgramsList?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleSubjectText.delegate = self
        pageText.delegate = self
        
        //stringa di sotto serve per aggionrare la label col numero di pagine per giorno
        resultText.text = ""
        _ = UIRefreshControl()
        scomponiDate()
        
        
        do {
            self.programList = try RealmProgramsList.init()
        } catch let e{
            print("🤖", e)
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    //ciò che è scritto qua sono delle funzioni per far si che la tastiera si abbassi quando viene cliccato il tasto fatto o comunque qualsiasi altra parte dello schermo
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == titleSubjectText{
            pageText.becomeFirstResponder()
        } else if textField == pageText {
            textField.resignFirstResponder()
        }
        return true
    }

    //---------REALM-------------
    
    //questa funzione con l'operazione self.navigationController?.popViewController(animated: true) fa si che quando l'utente clicca il pulsante viene riportato alla pagina genrale dei suoi programmi di studio
    @IBAction func yesButton_clicked(_ sender: UIButton) {
    
        labelSubject.textColor = .black
        labelPage.textColor = .black
        //Quando clicco il pulsante tutti i valori che ho scritto nelle caselle devono essere salvati in una variabile e ciò lo faccio con il metodo guard; ricorda Istruzione guard : Se la condizione -guard- non è verificata allora -else- esegui qualcosa. In questo caso creo la costante subject e gli attribuisco il valore del titleSubjecttexte poi impongo "se non è vero che subject è NON (!) vuoto (quindi se non è vero che subject è pieno) -> scrivi nella console che subject è vuoto; stessa cosa per le altre varibili
        guard
            let subject = self.titleSubjectText.text,
            !subject.isEmpty
        else{
//            yesButton.isHidden = true
            labelSubject.textColor = .red
            resultText.text = "Inserisci il titolo della materia"
            print("🤖 \(#function) subject isEmpty")
            return
        }
        
        guard
            let pageToStudy: Int = Int(self.pageText.text!),
            !pageToStudy.isMultiple(of: 0)
        else{
            labelPage.textColor = .red
            resultText.text = "Inserisci un numero di pagine"
            print("🤖 \(#function) page isEmpty o zero")
//            yesButton.isHidden = true
            return
        }
        
        //Per questa costante non ho utilizzato guard perche non si trattava di valori opzionali visto che la costanta è uguale a quella piccola operazione matematica in qulunque caso. Tuttavia ho inizializzato un if nel caso in cui l'utente scegliesse di inizializzare un programa di studio tutto in un giorno
            let dayToStudy: Int = Int ((datePicker.date.timeIntervalSinceNow / 86400) + 1)
        
        if  dayToStudy <= 0 {
                print("🤖 \(#function) dayToStudyis0")
            return
        }
        
        _ = UIRefreshControl()
        let page4Day: Double = pagePerDay
        let pageDone: Int = 0
        //ho inizializzato una nuova costante con valori in RealmPrograms e gli ho associato tutte le variabili (opzionali e non) che andranno inserite nel database e poi riportate nella schermata del SecondoViewController
        let valueProgram = RealmPrograms.init()
        valueProgram.subjectTitle = subject
        valueProgram.pageNumber = pageToStudy
        valueProgram.dayNumber = dayToStudy
        valueProgram.pageForDay = page4Day
        valueProgram.pageDone = pageDone
        if mondayButton.isSelected == true {
            valueProgram.dayWantStudy = String("Lunedi")
            }

        do {
            try self.programList?.addPrograms(programs: valueProgram)
            self.navigationController?.popViewController(animated: true)
        } catch let e {
            print("🤖", e)
        }
        
//
        scomponiDate()
        self.navigationController?.popViewController(animated: true)
        
        }
    
    
    
    
    var dayToStudyWeek: Double = 0.0
 
    //------CONTROLLO DATAPICKER E Algoritmo-------
    

    func scomponiDate() {
        mondayButton.isEnabled = true
        thurdayButton.isEnabled = true
        wednesdayButton.isEnabled = true
        tuesdayButton.isEnabled = true
        fridayButton.isEnabled = true
        saturdayButton.isEnabled = true
        sundayButton.isEnabled = true
        
        var giornodelmese: Int!
        var mesedellanno: Int!
        var anno: Int!
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.weekday, .day, .month, .year] , from: datePicker.date)
        giornodelmese = components.day
        mesedellanno = components.month
        anno = components.year
        print("Il giorno selezionato è \(giornodelmese!), il mese \(mesedellanno!) e l'anno \(anno!)")
        
        //costante che mi indica la data dell'esame
        let eta_giorni: Int = Int((datePicker.date.timeIntervalSinceNow / 86400) + 1)
        print ("🤖 età giorni is \(eta_giorni)")
        
        let pageDone1 = 0
        let valueProgram = RealmPrograms.init()
        valueProgram.pageDone = pageDone1
// inizializzoun guard che assegna alla costante(nuova) pageToStudy il valore che l'utente inserisce nella casella di testo "inserisci le pagine da studiare" e lo fa se e solo se le pagine non sono 0 ; devo ancora creare un alert se l'utente dimentica di inserire la pagina oppure ci mette 0
        guard
            let pageToStudy: Int = Int(self.pageText.text!) ,
            !pageToStudy.isMultiple(of: 0)
        else{
           print("🤖 \(#function) pageToStudyis0")
            return
        }
        
        let pageTotal = pageToStudy - pageDone1
        
        
//  inizializzo una costane con il numero di giorni rimanenti prima dell'esame, ciò mi serve per rendere il programma più dettagliato, il fine è quello di aggiornare la label con il testo che mi indica quante pagine devo studaire nel corso della settimana in base ai giorni che seleziono; utilizzo double cosicche dopo posso usare la funzione round che mi da un'approssimazione più precisa della divisione razionale
        let dayToStudy: Double = Double(eta_giorni)
            print("🤖 day to study :\(dayToStudy)")
        
        // INIZIO UN MACRO IF-ELSE: NEL PRIMO CASO L'UTENTE VUOLE PROGRAMMARE UN PROGRAMMA INFRAWEEK E ALLORA L'APP ESEGUE UNA SEMPLICE DIVISIONE TRA NUMERO DI PAGINE E NUMERO DI GIORNI, IL SELETTORE DI GIORNI VERA' DISABILITATO ; NEL SECONDO CASO ESEGUE L'ALGORITMO
        if dayToStudy < 7 && dayToStudy > 0  {
            let division_base = pageTotal / Int(dayToStudy)
            mondayButton.isEnabled = false
            thurdayButton.isEnabled = false
            wednesdayButton.isEnabled = false
            tuesdayButton.isEnabled = false
            fridayButton.isEnabled = false
            saturdayButton.isEnabled = false
            sundayButton.isEnabled = false
            mondayButton.isSelected = false
            tuesdayButton.isSelected = false
            wednesdayButton.isSelected = false
            thurdayButton.isSelected = false
            fridayButton.isSelected = false
            saturdayButton.isSelected = false
            sundayButton.isSelected = false
            
            resultText.text = "Devi studiare \(division_base) pagine al giorno"
        }else{
// il primo passaggio è quello di considerare i giorni che mancano all'esame e dividere per 7 (numero di giorni della settimana) per vedere quante settimane mi mancano all'esame
        let divisione_first: Double = round(Double(eta_giorni) / 7 )
        print ("🤖 divisione first:\(divisione_first)")
        // secondo passaggio: dopo aver calcolato quante settimane (approssimativamente mancano all'esame) moltiplico il risultato per il numero di giorni della settimana (es. mi mancano 3 settimane all'esame e voglio studiare tre volte alla settimana, moltiplico 3x3 che mi darà i giorni effettivi sul quale dovranno essere conteggiate le pagine che mi voglio studiare)
        let division_second: Double =
            round(divisione_first * dayToStudyWeek)
        print ("🤖 divisione second:\(division_second)")
   //terzo passaggio: come sopracitato divido le pagine che voglio studiare nell'effettivo numero di giorni che l'utente imposta nel momento in cui clicca i pulsanti della settimana della view
        let division_third: Double =
            round(Double(pageTotal) / division_second)


           
        if eta_giorni < 0 || dayToStudy < 0{
            resultText.text = "L'esame non può essere già avvenuto"}
        else if dayToStudyWeek == 0 {
            resultText.text = "Seleziona i giorni in cui desideri studiare"}
        else if division_third.isInfinite == true {
            resultText.text = "Decidi un giusto intervallo di tempo"
        }else{
            resultText.text = "devi studiare \(division_third) pagine nei giorni selezionati "
        }
            
           
            // faccio l'operazione di seguito cosicche la variabile assuma il valore delle pagine da studiare in un giorno, mi serve per trasportare questo valore nel To Do del Primo VieW Controller
            pagePerDay = division_third
            
            print ("🧮 \(pagePerDay)" )
            
    }
    }

    var pagePerDay: Double = 0.0


    @IBAction func scomposizione(_ sender: Any) {
        scomponiDate()
    }
    //creo una funzione generale per tutti i bottoni della settimana, dentro l'istruzione if chiamo la funzione scomponidate() cosicchè ogni volta che premo un bottone mi si aggiorna la label result.
@IBAction func buttonCLicked(_ sender: UIButton) {
   sender.isSelected.toggle()
 if sender.isSelected {
     dayToStudyWeek += 1
    scomponiDate()
 }else{
     dayToStudyWeek -= 1
    scomponiDate()
 }

    print ("🤖 \(dayToStudyWeek)")
    _ = UIRefreshControl()
}
    
  
    //funzione prepare che porta il valore pagePerday (le pagine da studiare giornalmente) nel primo view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let howManyPagesPerDay = pagePerDay
        
        let destinationVC = segue.destination as! ViewController
        destinationVC.howManyPage = howManyPagesPerDay
    }
    
}
