//
//  ViewController.swift
//  MarvelApp
//
//  Created by Яна Преображенская on 16/07/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

extension Array {
    public func get(_ index: Int) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imgUrl: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    var characterID : Int?
    
    @IBAction func btnSearchClick(_ sender: Any) {
        characterID = Int(inputID.text!)
        if characterID != nil {
            DispatchQueue.global(qos: .background).sync {
                fetchCharacter(characterID: characterID!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func fetchCharacter(characterID : Int) {
        let ts = "bread"
        let apikey = "a0329a6b661c00809735adb5915637a1"
        let hash = "842ace5edbee2da123ff6eddb1184d00"
        let url = "https://gateway.marvel.com/v1/public/characters/\(characterID)"
        Alamofire.request(url,
                          method: .get,
                          parameters: ["ts" : ts, "apikey" : apikey, "hash" : hash])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let parsedCharacter = try JSONDecoder().decode(ResponseData.self, from: data)
                            if let characterImgUrl = parsedCharacter.data?.results?.get(0)?.thumbnail?.path,
                                let characterName = parsedCharacter.data?.results?.get(0)?.name,
                                let characterDescription = parsedCharacter.data?.results?.get(0)?.description {
                                DispatchQueue.main.async {
                                    self.imgUrl.kf.setImage(with: URL (string: characterImgUrl + ".jpg"))
                                    self.lblName.text = characterName
                                    self.lblDescription.text = characterDescription
                                }
                            }
                        }
                        catch {
                            print()
                        }
                    } else {
                        return
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
