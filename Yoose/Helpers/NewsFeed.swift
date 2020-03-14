//
//  NewsFeed.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-13.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import Foundation
struct API {


}

//
//let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?q="
//
//let apiKey: String = "&APPID=6fe885b5bcab04a96e4aeafd7a648605"
//
//
//func getWeather(city:String, completion: @escaping (Result<Weather, Error>) ->Void){
//
//    let urlString = baseURL + city + apiKey
//    guard let url: URL =  URL (string: urlString) else{return}
//
//     let task = URLSession.shared.dataTask(with: url){(data, response, error)
//                in
//                if let unwrappedError = error{
//                    print("something went wrong, error: \(unwrappedError)")
//                    completion(.failure(unwrappedError))
//                    return
//                }
//                if let unwrappedData = data {
//                    print("we got data! \(String(data: unwrappedData, encoding:String.Encoding.utf8) ?? "NO Data")")
//                    do{
//
//
//                    let decoder = JSONDecoder()
//                        let weather: Weather =   try  decoder.decode(Weather.self, from: unwrappedData)
//
//                        completion(.success(weather))
//                    }catch{
//
//                      print("couldnt parse json...")
//                    }
//
//
//                }
//            }
//            task.resume()
//}
