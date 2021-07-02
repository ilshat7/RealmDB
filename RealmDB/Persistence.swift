
import Foundation

class Persistence {
    
    static let shared = Persistence()
    
    //User Name
    private let kUserNameKey = "Persistence.kUserNameKey"
    var  userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    //User Surname
    private let kUserSurnameKey = "Persistence.kUserSurnameKey"
    var  userSurname: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnameKey) }
        get { return UserDefaults.standard.string(forKey: kUserSurnameKey) }
    }
    
    
}
