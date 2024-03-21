//
//  OverviewItemType.swift
//  Kedi
//
//  Created by Saffet Emin Reisoğlu on 2/3/24.
//

import Foundation

enum OverviewItemType: String, Codable, CaseIterable {
    
    case mrr
    case subscriptions
    case trials
    case revenue
    case users
    case installs
    case arr
    case proceeds
    case newUsers
    case churnRate
    case subscriptionsLost
    
    var icon: String {
        switch self {
        case .mrr: "dollarsign.arrow.circlepath"
        case .subscriptions: "repeat"
        case .trials: "clock"
        case .revenue: "dollarsign.circle"
        case .users: "person.2"
        case .installs: "iphone"
        case .arr: "dollarsign.arrow.circlepath"
        case .proceeds: "dollarsign.circle"
        case .newUsers: "person.2"
        case .churnRate: "person.2.slash"
        case .subscriptionsLost: "person.2.slash"
        }
    }
    
    var title: String {
        switch self {
        case .mrr: "MRR"
        case .subscriptions: "Subscriptions"
        case .trials: "Trials"
        case .revenue: "Revenue"
        case .users: "Users"
        case .installs: "Installs"
        case .arr: "ARR"
        case .proceeds: "Proceeds"
        case .newUsers: "New Users"
        case .churnRate: "Churn Rate"
        case .subscriptionsLost: "Subs. Lost"
        }
    }
    
    var availableTimePeriods: [OverviewItemTimePeriod] {
        switch self {
        case .mrr,
                .subscriptions,
                .trials,
                .arr,
                .proceeds,
                .newUsers,
                .churnRate,
                .subscriptionsLost:
            return [
                .last7Days,
                .last30Days,
                .last90Days,
                .last12Months,
//                .lastWeek,
//                .lastMonth,
//                .lastYear,
                .thisWeek,
                .thisMonth,
                .thisYear,
                .allTime
            ]
        case .revenue: 
            return [
                .last7Days,
                .last28Days,
                .last30Days,
                .last90Days,
                .last12Months,
//                .lastWeek,
//                .lastMonth,
//                .lastYear,
                .thisWeek,
                .thisMonth,
                .thisYear,
                .allTime
            ]
        case .users,
                .installs:
            return [.last28Days]
        }
    }
    
    var valueType: OverviewItemValueType {
        switch self {
        case .mrr: .live
        case .subscriptions: .live
        case .trials: .live
        case .revenue: .total
        case .users: .total
        case .installs: .total
        case .arr: .live
        case .proceeds: .total
        case .newUsers: .last
        case .churnRate: .last
        case .subscriptionsLost: .last
        }
    }
    
    var chartName: RCChartName? {
        switch self {
        case .mrr: .mrr
        case .subscriptions: .actives
        case .trials: .trials
        case .revenue: .revenue
        case .users: nil
        case .installs: nil
        case .arr: .arr
        case .proceeds: .revenue
        case .newUsers: .conversionToPaying
        case .churnRate: .churn
        case .subscriptionsLost: .churn
        }
    }
    
    var chartIndex: Int? {
        switch self {
        case .mrr: 1
        case .subscriptions: 1
        case .trials: 1
        case .revenue: 3
        case .users: nil
        case .installs: nil
        case .arr: 1
        case .proceeds: 6
        case .newUsers: 1
        case .churnRate: 3
        case .subscriptionsLost: 2
        }
    }
}

enum OverviewItemValueType {
    
    case live
    case last
    case average
    case total
}
