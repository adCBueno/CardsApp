//
//  NetworkManager.swift
//  cardsapp
//
//  Created by admin on 6/13/22.
//

import Foundation


// la clase maneja request

enum CardsNetworkError: Error {
    case noData
}

class NetworkManager {
    // singleton
    static let shared = NetworkManager(session: URLSession.shared)
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    @discardableResult
    
    // se usa un generic que puede devolver cualquier tipo de dato
    // callback completion, escaping deja que se pueda usar en el hilo principal datos
    func get<T: Decodable>( _ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>)  -> Void  ) -> URLSessionDataTask {
        //mandamos url y procesamos datos
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion( .failure(error)  )
                }
                return
            }
            
            let jsonDecoder = JSONDecoder()
            // , = y
            
            // si puedo rescatar y decodificar, mando los items
            if let data  = data, let items = try? jsonDecoder.decode(type, from: data) {
                DispatchQueue.main.async {
                    completion( Result.success(items)  )
                }
            } else {
                DispatchQueue.main.async {
                    // Manejador de errores
                    completion( .failure( CardsNetworkError.noData )  )
                }
            }
            
        }
        task.resume()
        
        return task
        
    }
    
    
}
