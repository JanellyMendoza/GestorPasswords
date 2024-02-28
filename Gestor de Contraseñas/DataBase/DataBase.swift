//
//  DataBase.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
//

import Foundation

class DataBase{
    static let shared = DataBase()
    let userDefaults = UserDefaults.standard
    // agregar funciones
    
    //obtener contrasenas
    func getPasswords() -> [PasswordEntry] {
        if let passwords = userDefaults.getData(type: [PasswordEntry].self, key: UserDefaultsKeys.passwords.rawValue) {
            return passwords
        }
        return []
    }
    //agrregarlos
    func addPassword(entry: PasswordEntry) {
        var passwords = getPasswords()
        passwords.append(entry)
        userDefaults.putData(object: passwords, key: UserDefaultsKeys.passwords.rawValue)
    }
    //deletepasswords
    
    func deletePassword(site: String) {
        var passwords = getPasswords()
        passwords.removeAll { $0.site == site }
        userDefaults.putData(object: passwords, key: UserDefaultsKeys.passwords.rawValue)
    }
    //buscar contrasena por sitio
    func findPassword(site: String) -> PasswordEntry? {
        let passwords = getPasswords()
        return passwords.first { $0.site == site }
    }
    
    //Generar una contraseña segura (opcional)
    
    func generateSecurePassword(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[{]};:<>|./?"
        let password = String((0..<length).map { _ in characters.randomElement()!})
        return password
    }
    
    
}
extension UserDefaults{
    func putData<T:Encodable>(object : T, key : String){
        let jsonEncoder = JSONEncoder()
        if let userEncode = try? jsonEncoder.encode(object){
            self.set(userEncode, forKey: key)
        }
    }
    
    func getData<T : Decodable>(type : T.Type, key : String) -> T?{
        if let data = self.data(forKey: key){
            let jsonDecoder = JSONDecoder()
            if let user = try? jsonDecoder.decode(type, from: data){
                return user
            }else{
                print("Error decoding data")
                return nil
            }
        }else{
            print("Error getting data")
            return nil
        }
    }
    
    func deleteData(key : String){
        self.removeObject(forKey: key)
        print("Delete data: \(key)")
    }
}
