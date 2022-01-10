//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by YaoKevinn on 24/12/2021.
//

import Foundation

// JSON data:
/*
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 11997,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 697,
     "total_market_cap": {
       "btc": 49017810.186076336,
       "eth": 610801843.202817,
       "ltc": 15231148627.943823,
       "bch": 5472836652.16076,
       "bnb": 4597702334.7595005,
       "eos": 723296011110.6404,
       "xrp": 2591389653510.796,
       "xlm": 8866728528960.518,
       "link": 113210557718.58392,
       "dot": 87005351215.46599,
       "yfi": 81714061.67181684,
       "usd": 2503649206334.13,
       "aed": 9196153899785.902,
       "ars": 256090265638457.9,
       "aud": 3462071159010.9023,
       "bdt": 214908721273956.88,
       "bhd": 944106086514.9497,
       "bmd": 2503649206334.13,
       "brl": 14209210705628.74,
       "cad": 3211285625310.824,
       "chf": 2297150723444.8975,
       "clp": 2151360726510858,
       "cny": 15948746174189.695,
       "czk": 55360190520618.96,
       "dkk": 16425826545053.482,
       "eur": 2209069840716.858,
       "gbp": 1867855001333.1958,
       "hkd": 19525834977739.562,
       "huf": 817199445610263,
       "idr": 35551443182563708,
       "ils": 7893455144746.128,
       "inr": 188200570175687.44,
       "jpy": 286437498398275.1,
       "krw": 2969013590503336,
       "kwd": 757494089271.6296,
       "lkr": 507248900654208.9,
       "mmk": 4453764441479639,
       "mxn": 51674931553109.27,
       "myr": 10514074842000.176,
       "ngn": 1029450480660467.4,
       "nok": 22081024306635.32,
       "nzd": 3673622005998.5176,
       "php": 125231291490826.88,
       "pkr": 446025106108425.4,
       "pln": 10232832415705.072,
       "rub": 183812917430639.06,
       "sar": 9403305835117.988,
       "sek": 22726219714406.03,
       "sgd": 3400281096598.5747,
       "thb": 83907299501081.86,
       "try": 28825765137128.008,
       "twd": 69429942958156.484,
       "uah": 68200343248994.055,
       "vef": 250690395030.23672,
       "vnd": 57357382174732696,
       "zar": 39147684902542.08,
       "xdr": 1784047847800.3691,
       "xag": 109401458639.3414,
       "xau": 1383541587.9123027,
       "bits": 49017810186076.336,
       "sats": 4901781018607634
     },
     "total_volume": {
       "btc": 2319828.753115416,
       "eth": 28906955.919468623,
       "ltc": 720833027.7494757,
       "bch": 259008792.4897305,
       "bnb": 217591973.89586055,
       "eos": 34230882147.09294,
       "xrp": 122640734172.32637,
       "xlm": 419628941184.20123,
       "link": 5357830265.261503,
       "dot": 4117636317.4598913,
       "yfi": 3867219.4673839784,
       "usd": 118488308525.42442,
       "aed": 435219406044.73694,
       "ars": 12119789916478.387,
       "aud": 163846817912.04236,
       "bdt": 10170822176960.629,
       "bhd": 44680993238.46935,
       "bmd": 118488308525.42442,
       "brl": 672468546205.1948,
       "cad": 151978081023.6676,
       "chf": 108715511326.55598,
       "clp": 101815818632812.14,
       "cny": 754794222968.6598,
       "czk": 2619989780452.4775,
       "dkk": 777372644111.4132,
       "eur": 104546974144.32309,
       "gbp": 88398558040.31845,
       "hkd": 924084393774.3589,
       "huf": 38674978824230.77,
       "idr": 1682516207814748.8,
       "ils": 373567569352.78815,
       "inr": 8906825751475.35,
       "jpy": 13556010401776.76,
       "krw": 140512256045181.8,
       "kwd": 35849348674.218346,
       "lkr": 24006184288054.406,
       "mmk": 210779934308087.84,
       "mxn": 2445580322276.93,
       "myr": 497591651652.51984,
       "ngn": 48720022699484.016,
       "nok": 1045011902619.0892,
       "nzd": 173858724517.51517,
       "php": 5926726422240.703,
       "pkr": 21108692163804.367,
       "pln": 484281504490.9346,
       "rub": 8699174635319.607,
       "sar": 445023128692.1306,
       "sek": 1075546576702.708,
       "sgd": 160922526457.63483,
       "thb": 3971017171921.067,
       "try": 1364215140207.4744,
       "twd": 3285858290896.1895,
       "uah": 3227665957348.258,
       "vef": 11864234332.650763,
       "vnd": 2714509356237428.5,
       "zar": 1852712814180.6697,
       "xdr": 84432280400.73848,
       "xag": 5177559919.973776,
       "xau": 65477824.17423476,
       "bits": 2319828753115.416,
       "sats": 231982875311541.6
     },
     "market_cap_percentage": {
       "btc": 38.576653930924245,
       "eth": 19.4575044852134,
       "bnb": 3.65664198905937,
       "usdt": 3.105010637534773,
       "sol": 2.318169674424243,
       "ada": 1.848000738903663,
       "xrp": 1.835026817392137,
       "usdc": 1.702463648349883,
       "luna": 1.4331045553757153,
       "dot": 1.2271340579841088
     },
     "market_cap_change_percentage_24h_usd": 4.198740630496021,
     "updated_at": 1640324794
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
}
