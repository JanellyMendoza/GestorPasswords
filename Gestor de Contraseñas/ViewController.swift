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
    
    var collection: UICollectionView = {
        var layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumLineSpacing = 1
        layot.minimumInteritemSpacing = 1
        layot.scrollDirection = .vertical
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collection.backgroundColor = .black
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        initUI()

        savePasswordButton.addTarget(self, action: #selector(savePassword), for: .touchUpInside)
        generateNewPasswordButton.addTarget(self, action: #selector(generateNewPassword), for: .touchUpInside)
        deletePasswordButton.addTarget(self, action: #selector(deletePasswordSaved), for: .touchUpInside)
        searchPasswordButton.addTarget(self, action: #selector(searchSavedPasswords), for: .touchUpInside)
    }
    
    func initUI(){
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(MyCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(labelTitle)
        labelTitle.addAnchors(left: 20, top: 70, right: 20, bottom: nil)
        
        view.addSubview(siteName)
        siteName.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: labelTitle)
        
        view.addSubview(nameUser)
        nameUser.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: siteName)
        
        view.addSubview(password)
        password.addAnchors(left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: nameUser)
        
        view.addSubview(savePasswordButton)
        savePasswordButton.addAnchors(left: 20, top: 20, right: 20, bottom: nil, withAnchor: .top, relativeToView: password)
        
        view.addSubview(generateNewPasswordButton)
        generateNewPasswordButton.addAnchors(left: 20, top: 20, right: 20, bottom: nil, withAnchor: .top, relativeToView: savePasswordButton)
        
        view.addSubview(deletePasswordButton)
        deletePasswordButton.addAnchors(left: 20, top: 20, right: 20, bottom: nil, withAnchor: .top, relativeToView: generateNewPasswordButton)
        
        view.addSubview(searchPasswordButton)
        searchPasswordButton.addAnchors(left: 20, top: 20, right: 20, bottom: nil, withAnchor: .top, relativeToView: deletePasswordButton)
        view.addSubview(collection)
        collection.addAnchorsAndSize(width: 10, height: height, left: 5, top: 20, right: 5, bottom: nil, withAnchor: .top, relativeToView:  searchPasswordButton)
    }
    
    @objc func savePassword() {
        guard let website = siteName.text?.lowercased(), !website.isEmpty,
              let username = nameUser.text?.lowercased(), !username.isEmpty,
              let password = password.text?.lowercased(), !password.isEmpty else {
            
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
        // acomoodarlo de manera que se pueda ver que credencial eliminar
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
    @objc func searchSavedPasswords(){
        let savedPasswords = dataBase.getPasswords()
        
        
         return
         
         
         print(savedPasswords)
         
         }
         
    }

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCell
        //llamarla aqui una vez hecha para mostrar las credenciales
        //mandar a llamar a la celda para q muestre
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width / 1, height: 100)
    }
}
