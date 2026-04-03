import SwiftUI

enum EmergencySampleData {
    static let topics: [EmergencyTopic] = [
        choking,
        asthmaAttack,
        troubleBreathing,
        heartAttack,
        cardiacArrest,
        severeBleeding,
        nosebleed,
        minorBurn,
        severeBurn,
        poisonExposure,
        seizure
    ]

    static let grouped: [EmergencyCategory: [EmergencyTopic]] = {
        Dictionary(grouping: topics, by: { $0.category })
    }()

    // MARK: Topics
    static let choking = EmergencyTopic(
        title: "Choking",
        category: .breathingAirway,
        symbol: "mouth.fill",
        summary: "Airway blocked by food or object.",
        symptoms: [
            "Clutching the throat",
            "Cannot speak, cough, or breathe",
            "High-pitched or no sound",
            "Skin turning blue"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Ask if they can speak", detail: "Ask if the person can speak or cough.", tip: "Encourage strong coughing if they can breathe.", warning: nil),
            EmergencyStep(number: 2, title: "Call emergency services", detail: "Call emergency services immediately if they cannot breathe or speak.", tip: nil, warning: "Time is critical when breathing is blocked."),
            EmergencyStep(number: 3, title: "Give back blows", detail: "Stand to the side and slightly behind. Deliver 5 firm back blows between the shoulder blades.", tip: nil, warning: nil),
            EmergencyStep(number: 4, title: "Perform abdominal thrusts", detail: "Place a fist above the navel, grab with the other hand, and press inward and upward up to 5 times.", tip: "Alternate between back blows and thrusts until the object comes out.", warning: "Do not perform thrusts on infants or pregnant people."),
            EmergencyStep(number: 5, title: "If unresponsive, start CPR", detail: "Lay the person down and begin chest compressions. Follow dispatcher instructions.", tip: nil, warning: nil)
        ]
    )

    static let asthmaAttack = EmergencyTopic(
        title: "Asthma Attack",
        category: .breathingAirway,
        symbol: "wind",
        summary: "Narrowed airways causing wheeze and shortness of breath.",
        symptoms: [
            "Wheezing and coughing",
            "Chest tightness",
            "Shortness of breath",
            "Speaking in short phrases"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Help with inhaler", detail: "Have them sit upright and use their rescue inhaler as prescribed.", tip: "A spacer can help deliver medicine better.", warning: nil),
            EmergencyStep(number: 2, title: "Stay calm and monitor", detail: "Keep them calm. Loosen tight clothing and encourage slow breaths.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Call emergency services", detail: "If breathing does not improve, call emergency services.", tip: nil, warning: "Do not delay calling if symptoms are severe.")
        ]
    )

    static let troubleBreathing = EmergencyTopic(
        title: "Trouble Breathing",
        category: .breathingAirway,
        symbol: "lungs.fill",
        summary: "Breathing is hard, fast, or painful.",
        symptoms: [
            "Fast or shallow breathing",
            "Working hard to breathe",
            "Bluish lips or fingertips",
            "Chest pain or tightness"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services", detail: "If severe or sudden, call emergency services immediately.", tip: nil, warning: "Breathing problems can worsen quickly."),
            EmergencyStep(number: 2, title: "Sit upright", detail: "Help them sit upright and stay still.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Check for inhaler or oxygen", detail: "If they have prescribed devices, help them use it.", tip: nil, warning: nil)
        ]
    )

    static let heartAttack = EmergencyTopic(
        title: "Heart Attack",
        category: .cardiac,
        symbol: "heart.fill",
        summary: "Blood flow to the heart is blocked.",
        symptoms: [
            "Chest pressure or squeezing",
            "Pain in arm, jaw, or back",
            "Shortness of breath",
            "Cold sweat, nausea, or lightheadedness"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services now", detail: "Call emergency services immediately.", tip: nil, warning: "Don't drive them yourself unless no other option."),
            EmergencyStep(number: 2, title: "Rest in comfortable position", detail: "Keep them calm and seated. Loosen tight clothing.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Aspirin if appropriate", detail: "If not allergic and conscious, consider one adult aspirin to chew.", tip: "Only if advised or not contraindicated.", warning: nil),
            EmergencyStep(number: 4, title: "Watch breathing", detail: "Be prepared to start CPR if they become unresponsive.", tip: nil, warning: nil)
        ]
    )

    static let cardiacArrest = EmergencyTopic(
        title: "Cardiac Arrest",
        category: .cardiac,
        symbol: "bolt.heart.fill",
        summary: "Heart suddenly stops beating.",
        symptoms: [
            "Unresponsive and not breathing normally",
            "No pulse",
            "Sudden collapse"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services", detail: "Call emergency services immediately and put on speaker.", tip: nil, warning: nil),
            EmergencyStep(number: 2, title: "Start CPR", detail: "Push hard and fast in the center of the chest at 100–120/min.", tip: "Let the chest rise fully between compressions.", warning: nil),
            EmergencyStep(number: 3, title: "Use an AED if available", detail: "Turn it on and follow voice prompts.", tip: nil, warning: nil),
            EmergencyStep(number: 4, title: "Do not stop", detail: "Continue until help arrives or the person shows signs of life.", tip: nil, warning: nil)
        ]
    )

    static let severeBleeding = EmergencyTopic(
        title: "Severe Bleeding",
        category: .bleedingInjury,
        symbol: "drop.triangle.fill",
        summary: "Heavy bleeding that won't stop.",
        symptoms: [
            "Large or deep wound",
            "Blood soaking through clothes",
            "Pulsing or spurting blood",
            "Pale, clammy skin"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services", detail: "Call emergency services immediately.", tip: nil, warning: "Do not delay."),
            EmergencyStep(number: 2, title: "Apply direct pressure", detail: "Press firmly on the wound with a clean cloth or dressing.", tip: "Add more cloths on top if soaking; don't remove the first layer.", warning: nil),
            EmergencyStep(number: 3, title: "Raise the limb if possible", detail: "If an arm or leg, raise it above the heart.", tip: nil, warning: nil),
            EmergencyStep(number: 4, title: "Tourniquet if trained", detail: "If heavy bleeding from a limb and trained, use a tourniquet.", tip: nil, warning: nil)
        ]
    )

    static let nosebleed = EmergencyTopic(
        title: "Nosebleed",
        category: .bleedingInjury,
        symbol: "nose.fill",
        summary: "Bleeding from the nose.",
        symptoms: [
            "Bleeding from one or both nostrils",
            "Taste of blood",
            "Dripping into throat"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Sit and lean forward", detail: "Tilt slightly forward; don't lean back.", tip: nil, warning: nil),
            EmergencyStep(number: 2, title: "Pinch for 10 minutes", detail: "Pinch the soft part of the nose firmly.", tip: "Use a clock; don't release early.", warning: nil),
            EmergencyStep(number: 3, title: "Cold pack on bridge", detail: "Apply a cold pack to the bridge of the nose.", tip: nil, warning: nil)
        ]
    )

    static let minorBurn = EmergencyTopic(
        title: "Minor Burn",
        category: .burns,
        symbol: "flame.fill",
        summary: "Small, superficial burn.",
        symptoms: [
            "Red, painful skin",
            "No severe blistering",
            "Area smaller than the palm"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Cool the burn", detail: "Run cool (not cold) water over the area for 10–20 minutes.", tip: nil, warning: nil),
            EmergencyStep(number: 2, title: "Protect the skin", detail: "Cover loosely with a clean, dry dressing.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Avoid creams and ice", detail: "Do not apply butter, creams, or ice.", tip: nil, warning: nil)
        ]
    )

    static let severeBurn = EmergencyTopic(
        title: "Severe Burn",
        category: .burns,
        symbol: "flame.fill",
        summary: "Large or deep burn.",
        symptoms: [
            "Deep, charred, or white skin",
            "Large blisters",
            "Burns on face, hands, groin, or major joints"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services", detail: "Call emergency services immediately.", tip: nil, warning: nil),
            EmergencyStep(number: 2, title: "Do not break blisters", detail: "Cover with a sterile, non-stick dressing.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Remove tight items early", detail: "Gently remove rings or tight clothing before swelling.", tip: nil, warning: nil)
        ]
    )

    static let poisonExposure = EmergencyTopic(
        title: "Poison Exposure",
        category: .poisoning,
        symbol: "skull",
        summary: "Contact with a harmful substance.",
        symptoms: [
            "Nausea or vomiting",
            "Confusion or drowsiness",
            "Burns around mouth or skin irritation",
            "Trouble breathing"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call poison control / emergency", detail: "Call poison control or emergency services immediately.", tip: nil, warning: nil),
            EmergencyStep(number: 2, title: "Do not induce vomiting", detail: "Unless told by professionals, do not induce vomiting.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Move to fresh air if fumes", detail: "If inhaled, move to fresh air.", tip: nil, warning: nil)
        ]
    )

    static let seizure = EmergencyTopic(
        title: "Seizure",
        category: .neurologic,
        symbol: "bolt.fill",
        summary: "Sudden burst of electrical activity in the brain.",
        symptoms: [
            "Jerking movements or staring",
            "Unresponsive during episode",
            "Confusion or sleepiness afterward"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Protect from injury", detail: "Clear the area and cushion the head.", tip: nil, warning: "Do not hold the person down."),
            EmergencyStep(number: 2, title: "Time the seizure", detail: "If it lasts more than 5 minutes, call emergency services.", tip: nil, warning: nil),
            EmergencyStep(number: 3, title: "Recovery position", detail: "After movements stop, turn on side to help breathing.", tip: nil, warning: nil)
        ]
    )
}

