//
//  SubscriptionModels.swift
//  Bandmates
//
//  Created by Mac mini on 22/04/2026.
//

import Foundation

// MARK: - Models
struct SubscriptionPlanResponse: Codable {
    let success: Bool
    let plans: [String: PlanDetail]
}

struct PlanDetail: Codable {
    let name: String
    let membership: String
    let billing: String?
    let trialDays: Int
    let features: [String]
    let durationDays: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case membership
        case billing
        case trialDays    = "trial_days"
        case features
        case durationDays = "duration_days"
    }
}

struct SelectPlanResponse: Codable {
    let success: Bool
    let message: String
    let data: SubscriptionData?
}

struct SubscriptionData: Codable {
    let membership        : String
    let plan              : String
    let billing           : String?
    let isOnTrial         : Bool
    let trialEndsAt       : Date?
    let subscriptionEndsAt: Date?

    enum CodingKeys: String, CodingKey {
        case membership
        case plan
        case billing
        case isOnTrial          = "is_on_trial"
        case trialEndsAt        = "trial_ends_at"
        case subscriptionEndsAt = "subscription_ends_at"
    }
}

struct CancelPlanResponse: Codable {
    let success: Bool
    let message: String
}

