//
//  RealmPrograms.swift
//  Ilmioprototipo
//
//  Created by Vito Guglielmino on 13/12/2021.
//


//QUESTO E' IL MODELLO DI DATI CHE VERRANNO AGGIUNTI AL DATABASE 
import RealmSwift
import Foundation




//USO IL DATABASE LOCALE RELAM PER FAR SALVARE IL NUOVO PROGRAMMA DI STUDIO NELLA PAGINA SECONDOVIEWCONTROLLER, creo una classe di tipo Object (che è la classe principale di Realm e inizializzo dei valori per il titolo della materia (string), il numeor di pagien da studiare, il numero di giorni che ho a disposizione e le pagine che dovrei studiare al giorno. Le ultime tre variabili in Realm non posso inserirle opzionali (quindi mettendoci un punto interrogativo) ma le devo inizializzare con 0.


class RealmPrograms: Object {
    @objc dynamic var subjectTitle: String?
    @objc dynamic var pageNumber: Int = 0
   // giorni disponibili
    @objc dynamic var dayNumber: Int = 0
    //pagine da fare al giorno (in base ai calcoli)
    @objc dynamic var pageForDay: Double = 0.0
   // giorni in cui decidi di studiare
    @objc dynamic var dayWantStudy: String?
// pagine fatte
    @objc dynamic var pageDone: Int = 0
    
    
    
}

