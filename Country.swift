//
//  Country.swift
//  bucket list
//
//  Created by Karl Cridland on 07/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation

class Country {
    
    let flag: String
    let name: String
    let continent: Int
    
    init() {
        self.flag = String()
        self.name = String()
        self.continent = Int()
    }
    
    init(country: String, flag: String, continent: Int) {
        self.flag = flag
        self.name = country
        self.continent = continent
    }
    
    func cont() -> String{
        return Countries.all.continent(continent)
    }
    
}

class Countries {
    
    static let all = Countries()
    var countries = [Country]()
    
    private init(){
        
        struct c{
            var name: String
            var flag: String
        }
        
        let europe = [c(name: "Albania", flag: "🇦🇱"), c(name: "Andorra", flag: "🇦🇩"), c(name: "Austria", flag: "🇦🇹"), c(name: "Belarus", flag: "🇧🇾"), c(name: "Belgium", flag: "🇧🇪"), c(name: "Bosnia & Herzegovina", flag: "🇧🇦"), c(name: "Bulgaria", flag: "🇧🇬"), c(name: "Croatia", flag: "🇭🇷"), c(name: "Cyprus", flag: "🇨🇾"), c(name: "Czechia", flag: "🇨🇿"), c(name: "Denmark", flag: "🇩🇰"), c(name: "England", flag: "🏴󠁧󠁢󠁥󠁮󠁧󠁿"), c(name: "Estonia", flag: "🇪🇪"), c(name: "Faroe Islands", flag: "🇫🇴"), c(name: "Finland", flag: "🇫🇮"), c(name: "France", flag: "🇫🇷"), c(name: "Germany", flag: "🇩🇪"), c(name: "Gibraltar", flag: "🇬🇮"), c(name: "Greece", flag: "🇬🇷"), c(name: "Greenland", flag: "🇬🇱"), c(name: "Guernsey", flag: "🇬🇬"), c(name: "Hungary", flag: "🇭🇺"), c(name: "Iceland", flag: "🇮🇸"), c(name: "Ireland", flag: "🇮🇪"), c(name: "Isle of Man", flag: "🇮🇲"), c(name: "Italy", flag: "🇮🇹"), c(name: "Jersey", flag: "🇯🇪"), c(name: "Kosovo", flag: "🇽🇰"), c(name: "Latvia", flag: "🇱🇻"), c(name: "Liechtenstein", flag: "🇱🇮"), c(name: "Lithuania", flag: "🇱🇹"), c(name: "Luxembourg", flag: "🇱🇺"), c(name: "Macedonia", flag: "🇲🇰"), c(name: "Malta", flag: "🇲🇹"), c(name: "Moldova", flag: "🇲🇩"), c(name: "Monaco", flag: "🇲🇨"), c(name: "Montenegro", flag: "🇲🇪"), c(name: "Northern Ireland", flag: "🇬🇧"), c(name: "Norway", flag: "🇳🇴"), c(name: "Poland", flag: "🇵🇱"), c(name: "Portugal", flag: "🇵🇹"), c(name: "Romania", flag: "🇷🇴"), c(name: "Russia", flag: "🇷🇺"), c(name: "San Marino", flag: "🇸🇲"), c(name: "Scotland", flag: "🏴󠁧󠁢󠁳󠁣󠁴󠁿"), c(name: "Serbia", flag: "🇷🇸"), c(name: "Slovakia", flag: "🇸🇰"), c(name: "Slovenia", flag: "🇸🇮"), c(name: "Spain", flag: "🇪🇸"), c(name: "Svalbard", flag: "🇳🇴"), c(name: "Sweden", flag: "🇸🇪"), c(name: "Switzerland", flag: "🇨🇭"), c(name: "The Netherlands", flag: "🇳🇱"), c(name: "The Vatican", flag: "🇻🇦"), c(name: "Turkey", flag: "🇹🇷"), c(name: "Ukraine", flag: "🇺🇦"), c(name: "Wales", flag: "🏴󠁧󠁢󠁷󠁬󠁳󠁿")]
        
        let asia = [c(name: "Afghanistan", flag: "🇦🇫"), c(name: "Armenia", flag: "🇦🇲"), c(name: "Azerbaijan", flag: "🇦🇿"), c(name: "Bahrain", flag: "🇧🇭"), c(name: "Bangladesh", flag: "🇧🇩"), c(name: "Bhutan", flag: "🇧🇹"), c(name: "Brunei", flag: "🇧🇳"), c(name: "Cambodia", flag: "🇰🇭"), c(name: "China", flag: "🇨🇳"), c(name: "Georgia", flag: "🇬🇪"), c(name: "Hong Kong", flag: "🇭🇰"), c(name: "India", flag: "🇮🇳"), c(name: "Indonesia", flag: "🇮🇩"), c(name: "Iran", flag: "🇮🇷"), c(name: "Iraq", flag: "🇮🇶"), c(name: "Israel", flag: "🇮🇱"), c(name: "Japan", flag: "🇯🇵"), c(name: "Jordan", flag: "🇯🇴"), c(name: "Kazakhstan", flag: "🇰🇿"), c(name: "Kuwait", flag: "🇰🇼"), c(name: "Kyrgyzstan", flag: "🇰🇬"), c(name: "Laos", flag: "🇱🇦"), c(name: "Lebanon", flag: "🇱🇧"), c(name: "Macau", flag: "🇲🇴"), c(name: "Malaysia", flag: "🇲🇾"), c(name: "Maldives", flag: "🇲🇻"), c(name: "Mongolia", flag: "🇲🇳"), c(name: "Myanmar", flag: "🇲🇲"), c(name: "Nepal", flag: "🇳🇵"), c(name: "North Korea", flag: "🇰🇵"), c(name: "Oman", flag: "🇴🇲"), c(name: "Pakistan", flag: "🇵🇰"), c(name: "Palestine", flag: "🇵🇸"), c(name: "Phillipines", flag: "🇵🇭"), c(name: "Qatar", flag: "🇶🇦"), c(name: "Saudi Arabia", flag: "🇸🇦"), c(name: "Singapore", flag: "🇸🇬"), c(name: "South Korea", flag: "🇰🇷"), c(name: "Sri Lanka", flag: "🇱🇰"), c(name: "Syria", flag: "🇸🇾"), c(name: "Taiwan", flag: "🇹🇼"), c(name: "Tajikistan", flag: "🇹🇯"), c(name: "Thailand", flag: "🇹🇭"), c(name: "Türkmenistan", flag: "🇹🇲"), c(name: "United Arab Emirates", flag: "🇦🇪"), c(name: "Uzbekistan", flag: "🇺🇿"), c(name: "Vietnam", flag: "🇻🇳"), c(name: "Yemen", flag: "🇾🇪")]
        
        let africa = [c(name: "Algeria", flag: "🇩🇿"), c(name: "Angola", flag: "🇦🇴"), c(name: "Bénin", flag: "🇧🇯"), c(name: "Botswana", flag: "🇧🇼"), c(name: "Burkina Faso", flag: "🇧🇫"), c(name: "Burundi", flag: "🇧🇮"), c(name: "Cameroon", flag: "🇨🇲"), c(name: "Cape Verde", flag: "🇨🇻"), c(name: "Central African Republic", flag: "🇨🇫"), c(name: "Chad", flag: "🇹🇩"), c(name: "Comoros", flag: "🇰🇲"), c(name: "Democratic Republic of the Congo", flag: "🇨🇩"), c(name: "Djibouti", flag: "🇩🇯"), c(name: "Egypt", flag: "🇪🇬"), c(name: "Ethiopia", flag: "🇪🇹"), c(name: "Eritrea", flag: "🇪🇷"), c(name: "Gabon", flag: "🇬🇦"), c(name: "Ghana", flag: "🇬🇭"), c(name: "Guinea", flag: "🇬🇳"), c(name: "Guinea-Bassau", flag: "🇬🇼"), c(name: "Ivory Coast", flag: "🇨🇮"), c(name: "Kenya", flag: "🇰🇪"), c(name: "Lesotho", flag: "🇱🇸"), c(name: "Liberia", flag: "🇱🇷"), c(name: "Libya", flag: "🇱🇾"), c(name: "Madagascar", flag: "🇲🇬"), c(name: "Malawi", flag: "🇲🇼"), c(name: "Mali", flag: "🇲🇱"), c(name: "Mauritania", flag: "🇲🇷"), c(name: "Mauritius", flag: "🇲🇺"), c(name: "Mayotte", flag: "🇾🇹"), c(name: "Morocco", flag: "🇲🇦"), c(name: "Mozambique", flag: "🇲🇿"), c(name: "Namibia", flag: "🇳🇦"), c(name: "Niger", flag: "🇳🇪"), c(name: "Nigeria", flag: "🇳🇬"), c(name: "Republic of the Congo", flag: "🇨🇬"), c(name: "Réunion", flag: "🇷🇪"), c(name: "Rwanda", flag: "🇷🇼"), c(name: "Sao Tome and Principe", flag: "🇸🇹"), c(name: "Senegal", flag: "🇸🇳"), c(name: "Seychelles", flag: "🇸🇨"), c(name: "Sierra Leone", flag: "🇸🇱"), c(name: "Somalia", flag: "🇸🇴"), c(name: "South Africa", flag: "🇿🇦"), c(name: "South Sudan", flag: "🇸🇩"), c(name: "Sudan", flag: "🇸🇩"), c(name: "Swaziland", flag: "🇸🇿"), c(name: "Tanzania", flag: "🇹🇿"), c(name: "The Gambia", flag: "🇬🇲"), c(name: "Togo", flag: "🇹🇬"), c(name: "Tunisia", flag: "🇹🇳"), c(name: "Uganda", flag: "🇺🇬"), c(name: "Western Sahara", flag: "🇪🇭"), c(name: "Zambia", flag: "🇿🇲"), c(name: "Zimbabwe", flag: "🇿🇼")]
        
        let namerica = [c(name: "Anguilla", flag: "🇦🇮"), c(name: "Antigua and Barbuda", flag: "🇦🇬"), c(name: "Aruba", flag: "🇦🇼"), c(name: "Barbados", flag: "🇧🇧"), c(name: "Belize", flag: "🇧🇿"), c(name: "Bermuda", flag: "🇧🇲"), c(name: "Bonaire", flag: "🇧🇶"), c(name: "Canada", flag: "🇨🇦"), c(name: "Cayman Islands", flag: "🇰🇾"), c(name: "Costa Rica", flag: "🇨🇷"), c(name: "Cuba", flag: "🇨🇺"), c(name: "Curaçao", flag: "🇨🇼"), c(name: "Dominica", flag: "🇩🇲"), c(name: "Dominican Republic", flag: "🇩🇴"), c(name: "El Salvador", flag: "🇸🇻"), c(name: "Grenada", flag: "🇬🇩"), c(name: "Guadeloupe", flag: "🇬🇵"), c(name: "Guatemala", flag: "🇬🇹"), c(name: "Haiti", flag: "🇭🇹"), c(name: "Honduras", flag: "🇭🇳"), c(name: "Jamaica", flag: "🇯🇲"), c(name: "Martinique", flag: "🇲🇶"), c(name: "Mexico", flag: "🇲🇽"), c(name: "Montserrat", flag: "🇲🇸"), c(name: "Nicaragua", flag: "🇳🇮"), c(name: "Panama", flag: "🇵🇦"), c(name: "Puerto Rico", flag: "🇵🇷"), c(name: "Saint Barthélemy", flag: "🇧🇱"), c(name: "Saint Kitts and Nevis", flag: "🇰🇳"), c(name: "Saint Lucia", flag: "🇱🇨"), c(name: "Saint Martin", flag: "🇲🇫"), c(name: "Saint Pierre and Miquelon", flag: "🇵🇲"), c(name: "Saint Vincent and the Grenadines", flag: "🇻🇨"), c(name: "Sint Maarten", flag: "🇸🇽"), c(name: "The Bahamas", flag: "🇧🇸"), c(name: "Trinidad and Tobago", flag: "🇹🇹"), c(name: "Turks and Caicos Islands", flag: "🇹🇨"), c(name: "United States of America", flag: "🇺🇸")]
        
        let samerica = [c(name: "Argentina", flag: "🇦🇷"), c(name: "Bolivia", flag: "🇧🇴"), c(name: "Brazil", flag: "🇧🇷"), c(name: "Chile", flag: "🇨🇱"), c(name: "Colombia", flag: "🇨🇴"), c(name: "Ecuador", flag: "🇪🇨"), c(name: "Falkland Islands", flag: "🇫🇰"), c(name: "French Guiana", flag: "🇬🇫"), c(name: "Guyana", flag: "🇬🇾"), c(name: "Paraguay", flag: "🇵🇾"), c(name: "Peru", flag: "🇵🇪"), c(name: "Suriname", flag: "🇸🇷"), c(name: "Uruguay", flag: "🇺🇾"), c(name: "Venezuela", flag: "🇻🇪")]
        
        let australia = [c(name: "American Samoa", flag: "🇦🇸"), c(name: "Australia", flag: "🇦🇺"), c(name: "Christmas Island", flag: "🇨🇽"), c(name: "Cocos Islands", flag: "🇨🇨"), c(name: "Cook Islands", flag: "🇨🇰"), c(name: "Federated States of Micronesia", flag: "🇫🇲"), c(name: "Fiji", flag: "🇫🇯"), c(name: "French Polynesia", flag: "🇵🇫"), c(name: "Guam", flag: "🇬🇺"), c(name: "Kiribati", flag: "🇰🇮"), c(name: "Marshall Islands", flag: "🇲🇭"), c(name: "Nauru", flag: "🇳🇷"), c(name: "New Caledonia", flag: "🇳🇨"), c(name: "New Zealand", flag: "🇳🇿"), c(name: "Niue", flag: "🇳🇺"), c(name: "Norfolk Island", flag: "🇳🇫"), c(name: "Northern Mariana Islands", flag: "🇲🇵"), c(name: "Palau", flag: "🇵🇼"), c(name: "Papua New Guinea", flag: "🇵🇬"), c(name: "Pitcairn Islands", flag: "🇵🇳"), c(name: "Saint Helena", flag: "🇸🇭"), c(name: "Samoa", flag: "🇼🇸"), c(name: "Solomon Islands", flag: "🇸🇧"), c(name: "Timor-Leste", flag: "🇹🇱"), c(name: "Tokelau", flag: "🇹🇰"), c(name: "Tonga", flag: "🇹🇴"), c(name: "Tuvalu", flag: "🇹🇻"), c(name: "Vanuatu", flag: "🇻🇺"), c(name: "Wallis and Futuna", flag: "🇼🇫")]
        
        var i = 0
        for continent in [europe,asia,africa,namerica,samerica,australia]{
            for country in continent{
                countries.append(Country(country: country.name, flag: country.flag, continent: i))
            }
            i += 1
        }
    }
    
    func continent(_ c: Int) -> String{
        return ["Europe","Asia","Africa","North America","South America","Oceania"][c]
    }
    
    func getCountry(_ name: String) -> Country{
        for c in countries{
            if c.name == name{
                return c
            }
        }
        return Country()
    }
    
    func get(_ name: String) -> Int{
        var i = 0
        for a in Countries.all.countries{
            if a.name == name{
                return i
            }
            i += 1
        }
        return -1
    }
    
    func get(_ country: Int) -> Country{
        return Countries.all.countries[country]
    }
    
}

class Continents {
    
    static let Europe = 0
    static let Asia = 1
    static let Africa = 2
    static let NAmerica = 3
    static let SAmerica = 4
    static let Australia = 5
    
}
