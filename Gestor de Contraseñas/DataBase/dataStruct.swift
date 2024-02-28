//
//  dataStruct.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
//

import Foundation

struct PasswordEntry: Codable {
    let site: String
    let username: String
    let password: String
}
