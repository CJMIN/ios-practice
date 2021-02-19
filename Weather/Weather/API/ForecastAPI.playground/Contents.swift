import UIKit

import CoreLocation


struct Forecast: Codable{
    let cod : String
    let message : Int
    let cnt : Int
    
    
    struct ListItem:Codable {
        
        let dt: Int
        
        struct Main:Codable {
            let temp: Double
        }
        
        let main:Main
        
        struct Weather:Codable {
            
            let description : String
            let icon : String
            
        }
        
        let weather:[Weather]
        
    }
    
    let list:[ListItem]
    
}

enum ApiError : Error{
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}



func fetch<ParsingType: Codable>(urlStr:String, completion : @escaping (Result<ParsingType,Error>)->()){
        
    
    
    guard let url = URL(string: urlStr) else {
        
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }
    
    let task = URLSession.shared.dataTask(with:url){(data, response, error) in
        if let error = error{
            completion(.failure(error))//
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(ApiError.invalidResponse))//
            return
        }
        
        print("statusCode : \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200  else {
            print("@@@@@")
            print(httpResponse.statusCode)
            completion(.failure(ApiError.failed(httpResponse.statusCode)))//
            return
        }
        
        guard let data = data else {
            completion(.failure(ApiError.emptyData))//
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
        
            completion(.success(data))
            
        }catch{
            completion(.failure(error))
            print(error)
        }
        
    }
    task.resume()
}


func fetchForecast(cityName :String,completion : @escaping (Result<Forecast, Error>) -> () ){
    
    let urlStr =  "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=b39aeb1e660919371efad86125f1a70d&units=metric&lang=kr"
    
    fetch(urlStr : urlStr, completion : completion )
    
    
}

func fetchForecast(cityId :Int,completion : @escaping (Result<Forecast, Error>) -> () ){
    
    let urlStr =  "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=b39aeb1e660919371efad86125f1a70d&units=metric&lang=kr"
    
    fetch(urlStr : urlStr, completion : completion )
    
    
}


func fetchForecast(location :CLLocation,completion : @escaping (Result<Forecast, Error>) -> () ){

    let urlStr =  "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=b39aeb1e660919371efad86125f1a70d&units=metric&lang=kr"

    fetch(urlStr : urlStr, completion : completion )


}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)

fetchForecast(location : location){ (result) in
    
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}

fetchForecast(cityName: "seoul"){ _ in }

fetchForecast(cityId: 1835847){ (result) in

    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}
