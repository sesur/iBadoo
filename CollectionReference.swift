//
//  CollectionReference.swift
//  iBadoo
//
//  Created by Sergiu on 10/5/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}

func reference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
