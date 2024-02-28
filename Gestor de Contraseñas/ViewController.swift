//
//  ViewController.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
import UIKit


class ViewController: UIViewController {
    
    var viewModel: ViewControllerModel!
    
    let dataBase = DataBase.shared
    
    var labelTitle: UILabel = {
        var label = UILabel()
        label.text = "Guardar nueva información"
        label.textColor = .red
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    var siteName : UITextField = {
        var textField = UITextField()
        textField.placeholder = "Sitio web"
        textField.backgroundColor = .white
        return textField
    }()
    
    var nameUser : UITextField = {
        var textField = UITextField()
        textField.placeholder = "Nombre de usuario"
        textField.backgroundColor = .white
        return textField
    }()
    
    var password  : UITextField = {
        var textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.backgroundColor = .white
        return textField
    }()
    
    var savePasswordButton : UIButton = {
        var saveButton = UIButton()
        saveButton.setTitle("Guardar Contraseña", for: .normal)
        saveButton.backgroundColor = .systemPink
        return saveButton
    }()
    
    var generateNewPasswordButton : UIButton = {
        var generateNewButton = UIButton()
        generateNewButton.setTitle("Generar Nueva Contraseña", for: .normal)
        generateNewButton.backgroundColor = .systemPink
        return generateNewButton
    }()
    
    var deletePasswordButton : UIButton = {
        var deleteButton = UIButton()
        deleteButton.setTitle("Eliminar Contraseña", for: .normal)
        deleteButton.backgroundColor = .systemPink
        return deleteButton
    }()
    
    var searchPasswordButton : UIButton = {
        var searchButton = UIButton()
        searchButton.setTitle("Buscar Contraseña", for: .normal)
        searchButton.backgroundColor = .systemPink
        return searchButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        initUI()
        savePasswordButton.addTarget(self, action: #selector(savePassword), for: .touchUpInside)
        generateNewPasswordButton.addTarget(self, action: #selector(generateNewPassword), for: .touchUpInside)
        deletePasswordButton.addTarget(self, action: #selector(deletePasswordSaved), for: .touchUpInside)
        //searchPasswordButton.addTarget(self, action: #selector(searchSavedPassword), for: .touchUpInside)
    }
    
    func initUI(){
        view.addSubview(labelTitle)
        labelTitle.addAnchors(left: 20, top: 50, right: 20, bottom: nil)
        
        view.addSubview(siteName)
        siteName.addAnchors(left: 20, top: 100, right: 20, bottom: nil)
        
        view.addSubview(nameUser)
        nameUser.addAnchors(left: 20, top: 150, right: 20, bottom: nil)
        
        view.addSubview(password)
        password.addAnchors(left: 20, top: 200, right: 20, bottom: nil)
        
        view.addSubview(savePasswordButton)
        savePasswordButton.addAnchors(left: 20, top: 300, right: 20, bottom: nil)
        
        view.addSubview(generateNewPasswordButton)
        generateNewPasswordButton.addAnchors(left: 20, top: 350, right: 20, bottom: nil)
        
        view.addSubview(deletePasswordButton)
        deletePasswordButton.addAnchors(left: 20, top: 400, right: 20, bottom: nil)
        
        view.addSubview(searchPasswordButton)
        searchPasswordButton.addAnchors(left: 20, top: 450, right: 20, bottom: nil)
    }
    
    @objc func savePassword() {
        guard let website = siteName.text, !website.isEmpty,
              let username = nameUser.text, !username.isEmpty,
              let password = password.text, !password.isEmpty else {
            
            return
        }
        let newEntry = PasswordEntry(site: website, username: username, password: password)
        
        //aqui se llama  a la función de la base de datos para agregar la contraseña
        dataBase.addPassword(entry: newEntry)
        print("la contrasena se ha guardado: \(newEntry)")
    }
    @objc func generateNewPassword() {
        var newPasswordLength = 8
        let newPassword = dataBase.generateSecurePassword(length: newPasswordLength)
        password.text = newPassword
        print("the generated password is \(newPassword)")
    }
    @objc func deletePasswordSaved(){
        guard let savePasswordEntry = dataBase.getPasswords().last else{
            print("no se pudo eliminar porque no existe")
            return
        }
        //hacer la eliminacion
        dataBase.deletePassword(site: savePasswordEntry.site)
        //campo de la contrasena
        password.text = ""
        print("it has been deleted")
    }
        /*@objc func searchSavedPassword(){
        let savedPasswords = dataBase.getPasswords()
        
        //tus contrasenas son
        let holaaPasswords = UIAlertAction(title: "Saved passwords", style: .destructive){ _ in
           
            
            if password in savedPasswords {
                let siteName = password.site
            }
        
        
    }
    func alerta(titulo : String, mensaje : String, actions : [UIAlertAction]){
      let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
      for action in actions {
        alert.addAction(action)
      }
      present(alert, animated:  true)
      
    }*/
}
