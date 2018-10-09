//
//  Constants.swift
//  iBadoo
//
//  Created by Sergiu Suru on 12/1/17.
//  Copyright © 2017 Sergiu Suru. All rights reserved.
//

import UIKit

enum MainLoginTextMessage: String {
    case mainLoginTitleMessage = "Make new friends trough nearby location"
    case mainLabelMessage = "Log in you will agree to share your phone number"
}

enum ButtonText: String {
    case register = "Register"
    case login = "Login"
    case registerAnAcoount = "Register an account"
    case send = "Send"
    case save = "Save"
    case loginWithFacebook = "Login with Facebook"
}

enum Register: String {
    case header = "Register an account"
    case phoneNumber = "Your phone number"
    case password = "Password"
    case retypePassword = "Retype password"
    case termsAndConditions = "If you register an account automatically\n agree with Terms & Conditions and Privacy Policy"
    case youHaveAccount = "You have an account?"
}

enum Login: String {
    case header  = "Sign in your account"
    case forgotPassword = "Forgot your password?"
    case doNothaveAnAccout = "You don't have an account?"
}

enum Confirm: String {
    case header = "Confirm SMS code"
    case codeFromSms = "Code from SMS "
}

enum NewPassword: String {
    case header = "Set new password" 
    case password = "New password"
    case confirmPassword = "Confirm new password"
}

enum Camera: String {
    case camera = "camera"
    case library = "library"
    case bottomMessTitle = "You haven’t any photo\n"
    case bottomMessSubtitle = "\n\nUpload are photo for launching\n full features application"
}

enum ProfileInfo: String {
    case firstName = "First Name"
    case lastName = "Last Name"
    case birthDate = "Birth Date"
    case hobby = "Your hobbies"
    case languange = "Language know"
}


enum RadarText: String {
    case chooseAgeLabel = "CHOOSE AGE RANGE"
    case connectionLabel = "CHOOSE CONNECTION"
    case globalLabel = "Global"
    case localNetwork = "Local Network"
    case allPeopleLabel = "Show all people"
    case girlsLabel = "Show only girls"
    case guysLabel = "Show only guys"
    
}

enum TabBar: String {
    case favorites = "FAVORITES"
    case alarms = "ALARMS"
    case radar = ""
    case inbox = "INBOX"
    case profile = "PROFILE"
    
    enum Image: String {
        case heart = "tbi_heart"
        case alarm = "tbi_alarms"
        case radar = "tbi_radar"
        case inbox = "tbi_inbox"
        case profile = "tbi_profile"
    }
}


enum RadarSettings {
    enum Frame: Int {
        case width = 200
        case height = 35
    }
    
}

enum DefaultRadar {
    
    enum Label: String {
        case message = "We searching for new people\n of near you..."
    }
    enum Image: String {
        case name = "bitmap"
    }
}

enum Alarm {
    enum Button: String {
        case accept = "Accept"
        case reject = "Reject"
    }
}

enum MyProfile {
    enum Image: String {
        case next = "next"
        case none = "none"
    }
    enum Text: String {
        case relashionship = "RELASHIONSHIP"
        case relashionshipPlaceholder = "Relashionship type"
        case withPlaceholder = "With..."
        case knowLanguages = "KNOWN LANGUAGES"
        case languagePlaceholder = "Language know"
        case interests = "INTERESTS"
        case hobbyPlaceholder = "Your hobbies"
        case visitedCountries = "VISITED COUNTRIES"
        case showAllTrips = "Show all trips"
        case inRelashionshipWith = "in relashionship with "
    }
}

enum Settings {
    enum Image: String {
        case next = "next"
        case none = "none"
    }
    enum Text: String {
        case changePassword = "CHANGE PASSWORD"
        case oldPasswordPlaceholder = "Old Password"
        case newPasswordPlaceholder = "New Password"
        case confirmPasswordPlaceholder = "Confirm New Password"
        case phoneNr = "Your phone number"
        case smsCode = "Code from SMS"
        case changePhoneNr = "Change Phone Number"
        case labelMessage = "For change your phone number we'll request an\n amount of $3.99 for one number. "
        
        case version = "v1.6.1"
        case availability = "is available from 22 March 2018"
        case updateMessage = " Fixed bugs\n\n Better detalizations of localization\n\n Messenger updated"
        case update = "Update to last version"
        case copyright = "© 2017 Radar Ltd. All Rights Reserved."
        
        
        
        case termsAndConditions = "If you are in the market for a computer, there are a number of factors to consider. Will it be used for your home, your office or perhaps even your home office combo? First off, you will need to set a budget for your new purchase before deciding whether to shop for notebook or desktop computers. Many offices use desktop computers because they are not intended to be moved around a lot. In addition, affordability often plays a large role in someone’s decision as to whether to purchase notebook or desktop computers.\n\n - While you are shopping around, it’s important to keep in mind some of the benefits that go along with owning different types of computers. To that end, this article provides five important reasons to purchase desktop computers.\n\n – Desktop computers are typically much more affordable than notebook computers. With notebooks, you are paying more for the convenience of portability. For as little as $299.00, desktop computers can be purchased from one of the leading manufacturers and a notebook computer for as little as $499.00.\n\n – Unlike notebook computers, replacing a keyboard, mouse, speakers or even a monitor does not require having your computer serviced by a professional repair shop. Because notebook computers have everything built in, including the aforementioned features, it is more difficult to replace a keyboard or monitor as opposed to desktop computers, which operate on external connections.\n\n – In the event of an unlawful entry into your home, desktop computers are not as likely to be stolen because of their weight and bulk. Notebook computers, on the other hand, are small and portable. This, alone, makes them more appealing to a thief than desktop computers.\n\n – Desktop computers are stationary by nature. Unlike a notebook computer, which can easily be moved from room to room, they are less likely to be dropped or broken because they are not moved as often.\n\n – The vents on desktop computers are located on the back of the tower, which allows for proper ventilation that will help to prevent the computer from overheating. Notebook computers, on the other hand, feature only one vent on the back with the remaining underneath the base. If placed on a table, the air vents can become blocked and the computer may overheat. If prolonged use leads to overheating, damage may result.\n\n - When choosing from the many desktop computers on the market, always make sure that you purchase from a manufacturer who has experience in creating computers. Even though they are more affordable than notebooks, desktop computers are not cheap. With an investment that involves several hundred dollars, you will want to consider the length of time the manufacturer has been in business, their reputation with customers and their warranty.\n\n Additionally, when choosing any system, including desktop computers, always look at the potential for future upgrading. As you grow, you will want your computer to grow with you and a part of that will include a slight upgrade from time to time. This is the only way to get the best use of your desktop computers and make sure that your investment is one that lasts for years to come."
    }
}

let SHADOW_GRAY: CGFloat = 120.0/255.0
let radioButtonDiameter: CGFloat = 25


// TextSize
let seventeen: CGFloat = 17
let thirteen: CGFloat = 13

// ChatLog Placeholder
let PLACEHOLDER_TEXT = "Message ..."
let NEW_LINE = "\n"

//ChatLog userProfileImage
let imageHeight: CGFloat = 32































