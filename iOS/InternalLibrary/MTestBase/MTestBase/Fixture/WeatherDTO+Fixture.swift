//
//  WeatherDTO+Fixture.swift
//  MTestBase
//
//  Created by Duong Nguyen T. on 8/8/22.
//

import Foundation
import MModels
import MUtility

// Didn't use plain text json file as it is too easy to be extracted from IPA
// As this may used in the app for development or demo purpose.
// swiftlint:disable force_try
extension WeatherDTO {
    public static let getFixtureData = """
  {
      "ts": [
          1659992400000,
          1660003200000,
          1660014000000,
          1660024800000,
          1660035600000,
          1660046400000,
          1660057200000,
          1660068000000,
          1660078800000,
          1660089600000,
          1660100400000,
          1660111200000,
          1660122000000,
          1660132800000,
          1660143600000,
          1660154400000,
          1660165200000,
          1660176000000,
          1660186800000,
          1660197600000,
          1660208400000,
          1660219200000,
          1660230000000,
          1660240800000,
          1660251600000,
          1660262400000,
          1660273200000,
          1660284000000,
          1660294800000,
          1660305600000,
          1660316400000,
          1660327200000,
          1660338000000,
          1660348800000,
          1660359600000,
          1660370400000,
          1660381200000,
          1660392000000,
          1660402800000,
          1660413600000,
          1660424400000,
          1660435200000,
          1660446000000,
          1660456800000,
          1660467600000,
          1660478400000,
          1660489200000,
          1660500000000,
          1660510800000,
          1660521600000,
          1660532400000,
          1660543200000,
          1660554000000,
          1660564800000,
          1660575600000,
          1660586400000,
          1660597200000,
          1660608000000,
          1660618800000,
          1660629600000,
          1660640400000,
          1660651200000,
          1660662000000,
          1660672800000,
          1660683600000,
          1660694400000,
          1660705200000,
          1660716000000,
          1660726800000,
          1660737600000,
          1660748400000,
          1660759200000,
          1660770000000,
          1660780800000,
          1660791600000,
          1660802400000,
          1660813200000,
          1660824000000,
          1660834800000,
          1660845600000
      ],
      "units": {
          "wind_u-surface": "m*s-1",
          "wind_v-surface": "m*s-1",
          "dewpoint-surface": "K",
          "rh-surface": "%",
          "pressure-surface": "Pa"
      },
      "wind_u-surface": [
          0.2941105380410576,
          -0.07135959959722403,
          -0.8038624225593258,
          2.7274269844661663,
          0.5598510696737242,
          1.2836329233681267,
          1.7138999603259961,
          2.636408581804865,
          -4.244416638691704,
          -2.873964659566222,
          2.1897738578449135,
          1.2016577654348102,
          -0.04313608203376523,
          -4.468437147130071,
          -1.7390569780573653,
          -2.042855311746666,
          1.8513455610828715,
          1.5276833399457643,
          -1.6843189794611066,
          2.4977617725151484,
          1.1785515915403633,
          0.715598010193158,
          -1.6408020264292764,
          0.985723441267209,
          2.0695651112401277,
          2.5323038422804798,
          1.121225623340574,
          2.1606518753624733,
          1.2084841456344013,
          -2.845506759849952,
          -0.984531998657297,
          2.158376415296,
          1.8064027832881382,
          2.527020477920005,
          2.398715781121259,
          -0.9830866420484102,
          2.6983050019838806,
          -2.520145268105288,
          1.2572746971038,
          0.7302273628956097,
          1.4632575457015107,
          -0.03230567339109547,
          -3.7540696432388914,
          1.392786645100357,
          -3.566329538865533,
          2.1555931272317235,
          1.9802948088016104,
          -1.0980803857540167,
          -2.412436902981761,
          -3.3087435529651197,
          2.795446638386359,
          -0.7565367595446049,
          2.6068471327861378,
          1.0852772606586696,
          -1.2065407269510473,
          1.045832697531136,
          0.8915408795435078,
          -1.4573198644979144,
          -4.758026062807369,
          2.6983928952910325,
          -0.19987914670241666,
          -2.3881197546313797,
          -3.104792016358189,
          -0.8697335734124114,
          1.8715414899137808,
          2.1414716025270177,
          -0.895300759910911,
          -1.048742942594886,
          0.218981292153571,
          -1.7265077669608015,
          2.219354838709766,
          -2.8101834162421837,
          1.6941532639546675,
          0.05590014343706641,
          -3.6410681478317595,
          -1.0640461439864195,
          1.4394970549638662,
          1.5113351847896939,
          0.7304617450484511,
          0.01984435560165628
      ],
      "wind_v-surface": [
          2.074789880062386,
          1.212732322153543,
          -1.2881740775782287,
          -2.2393456831570777,
          2.5475972777491824,
          0.5703396710106216,
          -1.9459285256510281,
          1.3896127201149175,
          0.04241340372932728,
          -0.12585345011748256,
          2.8858888515887653,
          2.3900436414688184,
          2.2089345988344213,
          1.9914572588276558,
          1.13021027253057,
          0.7620056764428449,
          0.07471907712025054,
          -0.14028748435932387,
          -2.3321707815792485,
          2.1129062776575362,
          1.8351634266184012,
          2.364408093508886,
          -0.8111087374493764,
          2.6010071108128394,
          0.28254768517118073,
          -1.3516721091341117,
          0.8917361980041826,
          1.7343595690788483,
          2.594473708304232,
          -1.3882552568134676,
          0.8139017914367621,
          2.349241615039684,
          0.37782403027443184,
          2.3320926541948808,
          -0.5262465285196284,
          -3.318831751457574,
          2.9279213843198755,
          1.2557219153418033,
          -3.05157750175508,
          0.2871279030732179,
          2.240800805688839,
          0.5475753044221058,
          2.903916745506427,
          1.3827765739922948,
          1.2500576799830816,
          3.48538956877367,
          0.2707895138402619,
          -1.5652137821590801,
          -0.10626300851444082,
          -0.09567674794770528,
          2.1300161748101862,
          1.99614490188313,
          2.06490676595373,
          2.1946177556690083,
          0.5573509933774687,
          1.9797674489579293,
          -2.674847254860376,
          1.0183806878873378,
          2.3636268196662726,
          0.44168340098266345,
          -0.21366863002412084,
          3.4117642750330894,
          2.226952726829034,
          1.6062599566638665,
          0.19491805780212035,
          -0.7421027253030178,
          0.3725601977600115,
          1.9294631794184733,
          2.2793957335125388,
          -2.9206750694299286,
          -1.0551005584888322,
          3.765671559801386,
          2.1403485213783817,
          2.321291543321209,
          1.4625153355510736,
          1.700217902157826,
          2.5345304727319586,
          0.7789983825190397,
          0.12391003143406559,
          2.841424604022543
      ],
      "dewpoint-surface": [
          296.8561228056703,
          297.8682451384019,
          295.971160532265,
          295.5085719754081,
          296.50802164161206,
          298.1352704174156,
          297.29913322180346,
          296.3519533980711,
          297.0517834212652,
          297.1293665919143,
          296.8478267353114,
          296.81758824564577,
          297.0708142521211,
          298.1577380556131,
          296.4909064861251,
          295.3735010526358,
          297.68606182641304,
          297.5689132852005,
          296.2458539229738,
          296.65723002285796,
          296.58527705087164,
          297.21499135780687,
          295.7454262940012,
          298.29111530698674,
          295.87715398078444,
          296.3373711332346,
          296.4399617364933,
          296.5335128524898,
          295.9216146274068,
          297.62751972459745,
          295.79504911417166,
          296.87152695929575,
          295.41895618679183,
          297.92437415908137,
          295.6844669434069,
          296.79199954530145,
          295.8396544563874,
          295.7102033603469,
          295.67473713000373,
          298.17951188155547,
          296.7388299108925,
          297.34527802468745,
          296.5844007220498,
          298.1382470128102,
          297.05303316758284,
          296.57903841833564,
          295.1986374196741,
          297.0087981649787,
          296.7277116736098,
          297.48309100533686,
          295.58784763815225,
          296.7544045065425,
          297.2042616815353,
          295.9619268504087,
          295.9481179811876,
          294.8318912892421,
          295.5752390585472
      ],
      "rh-surface": [
          68.24919705801683,
          89.74148136844924,
          59.01654713583817,
          87.5790203558453,
          79.46857020783071,
          79.87443464461097,
          85.01553392132226,
          82.10937589647972,
          85.77303018280469,
          80.94733359782532,
          90.31927732169481,
          82.57992248298453,
          90.16238288521909,
          87.38309884945126,
          76.01070589312425,
          77.08213995788297,
          85.1893771172202,
          84.94083681752878,
          82.67541611987494,
          66.60914212469882,
          81.91566148869123,
          72.27960570085972,
          91.48983794671415,
          72.92338755455015,
          78.92388805810585,
          86.95465071565812,
          86.99814081240191,
          67.11428693502758,
          74.4067458113357,
          62.186287423323236,
          85.29157506027273,
          87.85526657917936,
          87.61151402325419,
          85.75281228064716
      ],
      "pressure-surface": [
          100491.97385174106,
          100446.5661671804,
          100493.83372295297,
          100747.72716452528,
          100621.6583269753,
          100480.03183690908,
          100123.7714041566,
          100730.69202551346,
          100632.39112521743,
          100694.79791253395,
          100321.75659657581
      ]
  }
  """.data(using: .utf8)!

    public static let getFixtureObject: WeatherDTO = try! getFixtureData.decoded()
}
