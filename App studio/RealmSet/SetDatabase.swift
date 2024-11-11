//
//  SetDatabase.swift
//  Ilmioprototipo
//
//  Created by Vito Guglielmino on 13/12/2021.
//

import RealmSwift


struct RealmProgramsList {
    
    //OPERAZIONE DI INSERIMENTO DEL PROGRAMMA
    
    
    
    
    //OPERAZIONE DEL RECUPERO DI TUTTI I TO DO 
   
    
    init() throws {
        self.realm = try Realm.init()
        print("🤖 Realm ", Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
  
   fileprivate let realm: Realm
    
    func addPrograms(programs: RealmPrograms) throws{
        //con l'operazione write stai scrivendo un qualcosa di tipo RalmPrograms che poi passerai al parametro programs creato
        try self.realm.write {
            self.realm.add(programs)
    
            
        }
    }
    
   
    
    func deletePrograms <T:Object> (_model: T) {
        
        try! realm.write {
            realm.delete(_model)
        }
        

    }
    
    //funzione che quando invocata ci restituisce un array quindi una lista di parametri di tipo RealmPrograms
    func getAllPrograms() -> [RealmPrograms] {
        //creo una costante che incamera un parametro di tipo RealmPrograms
       let result = self.realm.objects(RealmPrograms.self)
      
        
        //Istruzione guard : Se la condizione -guard- non è verificata allora -else- esegui qualcosa. in questo caso se la condizione "result è non vuota" non è verificata e quindi significa se non è verificato che la result è piena (quindi è vuota) allora ritorna un array vuoto ; sotto aggiungo return Array.init(result) poiche se result è pieno allora creo un Array in cui custodico tutte le informazioni che sono state inserite nell'app.
        guard !result.isEmpty else {
            return []
        }
        return Array.init(result)
    }
    
    //SERVE PER IL BOTTONE QUANDO SI DEVONO RINTACCIARE LE MATERIE
    func getSubject() -> [RealmPrograms] {
        let subjectResult = realm.objects(RealmPrograms.self)
        
        for result in subjectResult {
            print(result.subjectTitle ?? "" )
        }
        guard !subjectResult.isEmpty else {
            return []
        }
        return Array.init(subjectResult)
}
    
    func getParameters() -> RealmPrograms? {
        let realm = try! Realm.init()
        let result = realm.objects(RealmPrograms.self)
        
        guard !result.isEmpty else {return nil}
    
        return result[0]
    }
    
    
    //FUNZIONE CHE SERVE PER MODIFICARE I PARAMETRI DEL DATABASE, IN PRIMO LUOGO INIZIALIZZO CON UNA COSTANTE CON TUTTI I PARAMETRI PRESENTI NEL DATA. POI USO L'OPERAZIONE WRITE E NEL PARAMETRO PAGEDONE METTO QUELLO CHE L'UTENTE INSERISCE (PAGEDONE: INT) ---- ancora non usata, probabilmente inutile----
    func editPrograms(pageDone: Int) {

       guard let programs = self.getParameters() else {
            return
        }
        
        let realm = try! Realm.init()
        
       try! realm.write{
            programs.pageDone = pageDone
        }
    }
    
    
   
    
    
    
}
