//
//  DetailProgramViewController.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 06/01/22.
//


//QUESTO VIEW CONTROLLER E' LA PARTE GESTIONALE DELLA TABLEVIEW, CLICCANDO SUI PROGRAMMI CREATI L'UTENTE RICEVERà I DETTAGLI DEL SUO PROGRAMMA
import UIKit
import Charts

class DetailProgramViewController: UIViewController {

    @IBOutlet weak var graphicDetail: PieChartView!
    @IBOutlet weak var subjectDetail: UILabel!
    @IBOutlet weak var pageToDoDetail: UILabel!
    @IBOutlet weak var pageDoneDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    
    //Questa variabile è la variabile di destinazione (dei dati di tipo RealmPrograms, quindi subjcetTitle; pageNumber ecc): Questi dati sono stati "lanciati dalla funzione prepare for segue del secondo viewController
    var receivedSubjectTitle:  RealmPrograms?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        subjectDetail.text = self.receivedSubjectTitle?.subjectTitle
        setupPieChart()
        pageDoneDetail.text = String(self.receivedSubjectTitle!.pageDone)
        pageToDoDetail.text = String(self.receivedSubjectTitle!.pageNumber - self.receivedSubjectTitle!.pageDone)
     
        
    }
    
    func setupPieChart() {
        graphicDetail.chartDescription?.enabled = false
        graphicDetail.drawHoleEnabled = false
        graphicDetail.centerText? = ""
        graphicDetail.rotationAngle = 0
        graphicDetail.legend.font = .systemFont(ofSize: 15)
//        graphicDetail.legend.direction = .leftToRight
        //graphicDetail.rotationEnabled = false
        graphicDetail.isUserInteractionEnabled = false
        
        
        
        //graphicDetail.legend.enabled = false
        
        //Inizializzo una variabile che mi dia tutti i valori di entrata che andranno inseriti nel grafico, nel mio caso sono due e sono il numero di pagine da fare e il numero di pagine già eseguite
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: Double(receivedSubjectTitle!.pageNumber) - Double(receivedSubjectTitle!.pageDone), label: "Pagine da studiare"))
        entries.append(PieChartDataEntry(value: Double(receivedSubjectTitle!.pageDone), label: "Pagine studiate"))
    
        let dataSet = PieChartDataSet(entries: entries, label: "")
     
        let color1 = NSUIColor(.red)
        let color2 = NSUIColor(.green)
        let color3 = NSUIColor(hex: 0x35012C)
        let color4 = NSUIColor(hex: 0x290025)
        let color5 = NSUIColor(hex: 0x11001C)
        
        
        dataSet.colors = [color1, color2, color3, color4, color5]
        dataSet.drawValuesEnabled = false
        
        graphicDetail.data = PieChartData(dataSet: dataSet)
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
