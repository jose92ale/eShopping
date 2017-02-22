//
//  ViewController.swift
//  eShopping
//
//  Created by Jose Alejandro with Student ID: 300823547 Apablaza on 2017-02-21.
//  Purpose: to acomplish and demostrate the diverse knowledge refering swift 3 and 
//  ios development.
//  Copyright © 2017 Jose Alejandro Apablaza. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


//View Controller: link with the main view  - > StoryBorard
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var itemLabel: String!
    var quantityLabel: String!
    
    var list:[String] = []
    var number:[String] = []
    var handle:FIRDatabaseHandle?
    var ref:FIRDatabaseReference?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBAction func Stepper(_ sender: Any) {
    }
    //Add a new item to the variable list, send to Firebase and clear TextFields.
    @IBAction func addItem(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        
        if nameField.text != ""
        {
            //list.append(nameField.text!)
            
            ref = FIRDatabase.database().reference()
            
            if nameField.text != ""
            {
                ref?.child("list").childByAutoId().setValue(nameField.text)
                ref?.child("list").childByAutoId().setValue(quantityField.text)
                quantityField.text = ""
                nameField.text = ""
            }
            
        }
    }
    
    //TableView Set-Up
    @IBOutlet weak var myTableView: UITableView!
    
    //Set up number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return(list.count)
    }
    //Set up cell  --> Dynamic data
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        //let ListTableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ListTableViewCell")
        //ListTableViewCell.textLabel?.text = list[indexPath.row]
        cell.itemLabel.text = list[indexPath.row]
        cell.quantityLabel.text = number[indexPath.row]
        
        return(cell)
    }
    //Delete selected (swipe left) row data and do the same with the database  --> Firebase
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let item = self.list[indexPath.row]
            ref = FIRDatabase.database().reference()
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
        
    }
    
    //Reload data everytime the view appears
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    //Load data when loading view.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = FIRDatabase.database().reference()
        
        handle = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                
                self.list.append(item)
                self.myTableView.reloadData()
            }
        })
        
        
    }
    
    //func updateValues() {
    //    self.itemLabel = self.nameField.text
    //    self.quantityLabel = self.quantityField.text
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

