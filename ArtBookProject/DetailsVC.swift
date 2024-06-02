//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Sümeyra Demirtaş on 30.05.2024.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //Recognizers
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //bunu yaptigimizda AppDelegate i buraya degisken olarak atamis oluyoruz.
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        //UIImage i dataya cevirme
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
    
        
        
        
        //context.save() //coreData ya veri kaydetmemize olanak saglayacak fonksiyon bu.
        
        
    }
    
    @objc func hideKeyboard () {
        view.endEditing(true)
    }
    
    @objc func selectImage () {
        
        let picker = UIImagePickerController() // picker fotograflara erismek icin
        picker.delegate = self // bunun da fonksiyonlarini cagirabilmek icin delegate olarak tanimladik. yukarida ekledik.
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    
    //media ile isimiz bitince, secince, bu fonksiyon bana dictionary donduruyor. any type gorselin type i. biz tipini bilmedigimiz icin basta any olarak geliyor.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage //genelde original ya da editedImage kullanilir
        self.dismiss(animated: true, completion: nil) //pickeri geri kapatmak icin
        
    }
   

}
