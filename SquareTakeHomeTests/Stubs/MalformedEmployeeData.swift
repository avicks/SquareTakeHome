//
//  MalformedEmployeeData.swift
//  SquareTakeHomeTests
//
//  Created by Alex Vickers on 11/9/22.
//

import Foundation

let malformedEmployeeData =
"""
    {
      "phone_number" : "5557510409",
      "email_address" : "tnakamura.demo@squareup.com",
      "biography" : "Hardware packaging designer on the hardware team, working from LA.",
      
      "photo_url_small" : "https://s3.amazonaws.com/sq-mobile-interview/photos/e2b088e6-0b8d-4295-a66c-d7181cdec3d6/small.jpg",
      "photo_url_large" : "https://s3.amazonaws.com/sq-mobile-interview/photos/e2b088e6-0b8d-4295-a66c-d7181cdec3d6/large.jpg",

      "team" : "Hardware",
      "employee_type" : "CONTRACTOR"
    }
""".data(using: .utf8)!
