//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
     
    var messages : [Message] = []
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        tableView.dataSource = self
        //tableView.delegate = self
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    func loadMessage(){
        //read data
        
        //any change in collection, retrieve all collection
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField) //order by date
            .addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs  {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String , let msbBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: sender, body: msbBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                //UI UX scroll to lastest message
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                        
                                       
                    }
                }
               
            }
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
            
        }
    }
        
    @IBAction func sendPressed(_ sender: UIButton) {
        if let msgBody = messageTextfield.text, let msgSender = Auth.auth().currentUser?.email{
            //write to firebase
            db.collection(K.FStore.collectionName)
                .addDocument(data: [
                K.FStore.senderField:  msgSender, //data dict
                K.FStore.bodyField: msgBody,
                K.FStore.dateField : Date().timeIntervalSince1970 //add auto generated date for ordering
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully ")
                    //empty text field
                    self.messageTextfield.text = ""
                }
            }

        }
        
        
    }
    

}
extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //every row in the table view
        let message = messages[indexPath.row]

       let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
              //main label in MessageCell
              cell.label.text = message.body //use message cell instead
        
        //msg from current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.imageLeft.isHidden = true
            cell.imageRight.isHidden = false //me avatar
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColor.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColor.purple)
        }else{
            cell.imageLeft.isHidden = false
            cell.imageRight.isHidden = true //me avatar
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColor.purple)
            cell.label.textColor = UIColor(named: K.BrandColor.lightPurple)
        }
        
        
        return cell
    }
    
}
//extension ChatViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}

