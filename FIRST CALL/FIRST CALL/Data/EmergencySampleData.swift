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
        chemicalBurn,
        sunburn,
        frostbite,
        snakeBites,
        seizure,
        anaphylaxis,
        stroke,
        opioidOverdose,
        drowning,
        chokingInfant
    ]

    static let grouped: [EmergencyCategory: [EmergencyTopic]] = {
        Dictionary(grouping: topics, by: { $0.category })
    }()

    // MARK: Topics
    static let choking = EmergencyTopic(
        title: "Choking",
        category: .breathingAirway,
        symbol: "lungs.fill",
        summary: "Airway blocked by food or object.",
        symptoms: [
            "Clutching the throat",
            "Cannot speak, cough, or breathe",
            "High-pitched or no sound",
            "Skin turning blue"
        ],
        steps: [
            EmergencyStep(
                number: 1,
                title: "Check if they can breathe or speak",
                detail: "Ask if they can speak or cough.",
                subtitle: "If they can cough, encourage them to keep coughing",
                bullets: [
                    StepBullet(text: "If they can breathe or speak, **encourage strong coughing** to clear the blockage."),
                    StepBullet(text: "Do not put your fingers in their mouth unless you can see and easily remove the object.")
                ]
            ),
            EmergencyStep(
                number: 2,
                title: "Call for help if severe",
                detail: "Call emergency services if they cannot breathe or speak.",
                warning: "Time is critical when breathing is blocked.",
                callNumber: "112"
            ),
            EmergencyStep(
                number: 3,
                title: "Give 5 back blows",
                detail: "Stand behind and to one side.",
                subtitle: nil,
                bullets: [
                    StepBullet(text: "**Stand behind** the person and slightly to one side."),
                    StepBullet(text: "**Support their chest** with one hand and **lean them forward** so the object comes out of the mouth."),
                    StepBullet(text: "With the **heel of your hand**, strike firmly **between their shoulder blades** up to **5 times**."),
                    StepBullet(text: "After each back blow, **check** if the object is dislodged."),
                    StepBullet(text: "If the airway is still blocked, go to Step 4.")
                ],
                listStyle: .numbered,
                illustrationName: "choking(adult and child) step 2 pic",
                illustrationLabel: "Back blows between the shoulder blades"
            ),
            EmergencyStep(
                number: 4,
                title: "Perform 5 abdominal thrusts",
                detail: "Alternate with back blows until the object comes out.",
                warning: "Do not perform on pregnant people or infants under 1 year old.",
                bullets: [
                    StepBullet(text: "**Stand behind** the choking person."),
                    StepBullet(text: "**Wrap your arms** around their waist and **bend** them slightly forward."),
                    StepBullet(text: "Make a **fist** and place it **just above the belly button**."),
                    StepBullet(text: "Grab your fist with the other hand and **pull sharply inward and upward**."),
                    StepBullet(text: "Repeat **up to 5 times**.")
                ],
                listStyle: .numbered,
                illustrationName: "choking(adult and chikd) step 3 pic",
                illustrationLabel: "Abdominal thrusts with hands above the navel"
            ),
            EmergencyStep(
                number: 5,
                title: "If unresponsive, start CPR",
                detail: "Lay the person down and begin chest compressions.",
                subtitle: "Follow dispatcher instructions",
                bullets: [
                    StepBullet(text: "Push hard and fast in the centre of the chest at **100 to 120 per minute**."),
                    StepBullet(text: "Use an **AED** if available." )
                ]
            )
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
            EmergencyStep(number: 1, title: "Help with inhaler", detail: "Have them sit upright and use their reliever inhaler.", bullets: [
                StepBullet(text: "Use a **spacer** if available."),
                StepBullet(text: "Give **one puff at a time** with **slow breaths** in between as prescribed.")
            ]),
            EmergencyStep(number: 2, title: "Keep calm and comfortable", detail: "Loosen tight clothing and encourage slow breaths.", bullets: [
                StepBullet(text: "Let them **sit upright**. Do not lie flat."),
                StepBullet(text: "Stay with them and **reassure**.")
            ]),
            EmergencyStep(number: 3, title: "Call for help if not improving", detail: "If breathing does not improve, call emergency services.", warning: "Do not delay calling if symptoms are severe.", callNumber: "112")
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
            EmergencyStep(number: 1, title: "Assess and call if severe", detail: "If sudden or severe, call emergency services immediately.", warning: "Breathing problems can worsen quickly.", callNumber: "112"),
            EmergencyStep(number: 2, title: "Position for easier breathing", detail: "Help them sit upright and stay still.", bullets: [
                StepBullet(text: "Loosen tight clothing."),
                StepBullet(text: "Encourage **slow, steady breaths**.")
            ]),
            EmergencyStep(number: 3, title: "Use prescribed aids", detail: "If they have an inhaler or oxygen, help them use it.")
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
            EmergencyStep(number: 1, title: "Call emergency services now", detail: "Call emergency services immediately.", warning: "Do not drive them yourself unless there is no other option.", callNumber: "112"),
            EmergencyStep(number: 2, title: "Position for comfort", detail: "Sit them on the floor with knees bent and head supported if possible.", bullets: [
                StepBullet(text: "Loosen tight clothing."),
                StepBullet(text: "Reassure and keep them still.")
            ]),
            EmergencyStep(number: 3, title: "Aspirin if appropriate", detail: "If not allergic and conscious, offer one adult aspirin to chew.", tip: "Only if advised or not contraindicated."),
            EmergencyStep(number: 4, title: "Monitor and be ready for CPR", detail: "Watch breathing and prepare to start CPR if they become unresponsive.")
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
            EmergencyStep(number: 1, title: "Call and put on speaker", detail: "Call emergency services and put the phone on speaker.", callNumber: "112"),
            EmergencyStep(number: 2, title: "Start hands-only CPR", detail: "Push hard and fast in the centre of the chest.", bullets: [
                StepBullet(text: "Compress **5 to 6 cm** deep at **100 to 120 per minute**."),
                StepBullet(text: "Let the chest rise fully between compressions.")
            ], illustrationName: "cpr_hands_only", illustrationLabel: "Hands-only CPR"),
            EmergencyStep(number: 3, title: "Use an AED if available", detail: "Turn it on and follow voice prompts."),
            EmergencyStep(number: 4, title: "Do not stop", detail: "Continue until help arrives or they show signs of life.")
        ]
    )

    // MARK: New Topics (sourced from NHS, SAMHSA; see summaries)

    static let anaphylaxis = EmergencyTopic(
        title: "Anaphylaxis",
        category: .breathingAirway,
        symbol: "syringe",
        summary: "Severe allergic reaction. Use an adrenaline auto-injector if available and call for urgent help.",
        symptoms: [
            "Swollen throat or tongue",
            "Difficulty breathing or swallowing",
            "Wheezing, coughing, or noisy breathing",
            "Feeling faint, dizzy, or confused",
            "Skin, lips, or tongue turning blue, grey, or pale"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services now", detail: "Call emergency services immediately.", warning: "Anaphylaxis is life-threatening.", callNumber: "112"),
            EmergencyStep(number: 2, title: "Use an auto-injector", detail: "If you have an adrenaline auto-injector, use it now.", bullets: [
                StepBullet(text: "Follow the device instructions, inject into the outer thigh."),
                StepBullet(text: "Record the time of the injection."),
                StepBullet(text: "If no improvement after 5 to 15 minutes, use a second device if available.")
            ]),
            EmergencyStep(number: 3, title: "Lie down and raise legs", detail: "Lie flat with legs raised unless this makes breathing worse.", tip: "If breathing is difficult, sit up slightly; if pregnant, lie on your left side."),
            EmergencyStep(number: 4, title: "Remove the trigger if safe", detail: "If a sting, scrape the stinger off; avoid squeezing.")
        ]
    )

    static let stroke = EmergencyTopic(
        title: "Stroke (FAST)",
        category: .neurologic,
        symbol: "brain.head.profile",
        summary: "Face, Arms, Speech, Time. If any sign is present, call immediately.",
        symptoms: [
            "Face drooping on one side",
            "Arm weakness on one side",
            "Speech slurred or hard to understand",
            "Sudden confusion, loss of balance, severe headache"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Check FAST signs", detail: "Ask them to smile, raise both arms, and speak.", bullets: [
                StepBullet(text: "Face, is it uneven when they smile"),
                StepBullet(text: "Arms, can they lift both and keep them raised"),
                StepBullet(text: "Speech, is it slurred or unclear")
            ]),
            EmergencyStep(number: 2, title: "Call emergency services immediately", detail: "If any FAST sign is present, call now.", warning: "Time-critical emergency", callNumber: "112"),
            EmergencyStep(number: 3, title: "Keep them safe and comfortable", detail: "Loosen tight clothing, keep them warm, do not give food or drink.")
        ]
    )

    static let opioidOverdose = EmergencyTopic(
        title: "Opioid Overdose",
        category: .poisoning,
        symbol: "pills",
        summary: "Unresponsive or slow, shallow breathing. Give naloxone if available and call for help.",
        symptoms: [
            "Unresponsive or cannot be woken",
            "Slow, shallow, or stopped breathing",
            "Blue, grey, or pale lips or fingertips",
            "Pinpoint pupils"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Call emergency services now", detail: "Call immediately.", warning: "Life-threatening breathing emergency", callNumber: "112"),
            EmergencyStep(number: 2, title: "Give naloxone if available", detail: "Use nasal spray or auto-injector.", bullets: [
                StepBullet(text: "Follow the device instructions, give one dose now."),
                StepBullet(text: "If no response after 2 to 3 minutes, give another dose.")
            ]),
            EmergencyStep(number: 3, title: "Support breathing", detail: "If not breathing normally, give rescue breaths.", bullets: [
                StepBullet(text: "Tilt head, lift chin, give 1 breath every 5 to 6 seconds.")
            ]),
            EmergencyStep(number: 4, title: "Monitor until help arrives", detail: "If they start to breathe, place in recovery position and stay with them.")
        ]
    )

    static let drowning = EmergencyTopic(
        title: "Drowning",
        category: .breathingAirway,
        symbol: "water.waves",
        summary: "Remove from the water only if safe. Check breathing, start rescue breaths and CPR if needed.",
        symptoms: [
            "Coughing, difficulty breathing",
            "Unresponsive",
            "Blue, grey, or pale skin or lips"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Ensure your safety", detail: "Do not enter deep or fast water if unsafe. Use reach or throw aids."),
            EmergencyStep(number: 2, title: "Call emergency services", detail: "Call immediately if the person is unresponsive or not breathing.", callNumber: "112"),
            EmergencyStep(number: 3, title: "Check breathing", detail: "Open the airway and look, listen, and feel for breathing."),
            EmergencyStep(number: 4, title: "Recovery position", detail: "If breathing but not fully awake, place in the recovery position and monitor breathing.", bullets: [
                StepBullet(text: "Lay on their side, head tilted back to keep the airway open."),
                StepBullet(text: "Support the head and keep the mouth downward so fluid can drain."),
                StepBullet(text: "Keep them warm and continue to check breathing."),
            ], illustrationName: "drowning step 3 recovery position", illustrationLabel: "Recovery position"),
            EmergencyStep(number: 5, title: "Start rescue breaths and CPR if needed", detail: "If not breathing, give 5 rescue breaths, then start compressions.", bullets: [
                StepBullet(text: "Compress at 100 to 120 per minute, depth as appropriate for age."),
                StepBullet(text: "Alternate 30 compressions with 2 breaths.")
            ])
        ]
    )

    static let chokingInfant = EmergencyTopic(
        title: "Choking (Infant)",
        category: .breathingAirway,
        symbol: "figure.and.child.holdinghands",
        summary: "If coughing effectively, encourage coughing. If not, give back blows then chest thrusts.",
        symptoms: [
            "Quiet or weak cough",
            "Unable to cry, speak, or breathe",
            "Blue, grey, or pale skin"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Check if they can cough", detail: "If effective cough, keep them upright and encourage coughing."),
            EmergencyStep(number: 2, title: "Call for help if severe", detail: "If unable to breathe or cough, call immediately.", callNumber: "112"),
            EmergencyStep(number: 3, title: "5 back blows", detail: "Support the head and neck. Hold face down along your thigh and give up to 5 back blows between the shoulder blades.", illustrationName: "choking (infanct) step 3", illustrationLabel: "Back blows for infants"),
            EmergencyStep(number: 4, title: "5 chest thrusts", detail: "Turn face up and give up to 5 chest thrusts on the centre of the chest, just below the nipple line.", illustrationName: "choking (infanct) step 4", illustrationLabel: "Chest thrusts for infants"),
            EmergencyStep(number: 5, title: "Repeat and check", detail: "Alternate 5 back blows with 5 chest thrusts until the object comes out or help arrives.")
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
            EmergencyStep(
                number: 1,
                title: "Call for Help & Protect Yourself",
                detail: "Call for help immediately.",
                warning: nil,
                callNumber: "112",
                subtitle: nil,
                bullets: [
                    StepBullet(text: "**Call local emergency services immediately** and request an ambulance."),
                    StepBullet(text: "If available, **wear disposable gloves** to prevent infection.")
                ]
            ),
            EmergencyStep(
                number: 2,
                title: "Check for Embedded Objects",
                detail: "Look for any object stuck in the wound.",
                tip: nil,
                warning: "Removing an embedded object may cause more bleeding.",
                subtitle: "If there are no embedded objects, continue to step 3",
                bullets: [
                    StepBullet(text: "Look for any object stuck in the wound (glass, metal, etc.)."),
                    StepBullet(text: "**Do NOT remove it**. It may be helping to slow down the bleeding."),
                    StepBullet(text: "If there is an object, **take care not to press down on it**."),
                    StepBullet(text: "Instead, **press firmly on either side** of the object and **build up padding around it** before bandaging to **avoid putting pressure on the object** itself.")
                ]
            ),
            EmergencyStep(
                number: 3,
                title: "Apply Pressure to Stop Bleeding",
                detail: "Use a clean pad or cloth to press on the wound.",
                subtitle: nil,
                bullets: [
                    StepBullet(text: "If no object is embedded, **press firmly on the wound** using a clean pad or cloth."),
                    StepBullet(text: "**Maintain pressure until the bleeding stops**.")
                ],
                illustrationName: "bleeding_direct_pressure", illustrationLabel: "Apply direct pressure on the wound"
            ),
            EmergencyStep(
                number: 4,
                title: "Bandage the Wound Securely",
                detail: "Bandage firmly to keep pressure on the wound.",
                warning: "A loose bandage will not stop bleeding, and an overly tight one may cut off circulation.",
                bullets: [
                    StepBullet(text: "Use a **clean dressing** or any clean, soft material to **bandage the wound firmly**."),
                    StepBullet(text: "If bleeding continues through the pad, **apply pressure** to the wound until the bleeding stops."),
                    StepBullet(text: "Now **apply another pad over the top** and **bandage it in place**."),
                    StepBullet(text: "**Do not remove the original pad or dressing**, but continue to check that the bleeding has stopped.")
                ],
                illustrationName: "bandage.fill", illustrationLabel: "Apply and secure bandage"
            ),
            EmergencyStep(
                number: 5,
                title: "Handling a Severed Body Part",
                detail: "Bag, wrap, cool, and send with the patient.",
                warning: "Do not wash the severed limb.",
                bullets: [
                    StepBullet(text: "If a body part, such as a finger, has been severed, **place it in a plastic bag or wrap it in cling film**."),
                    StepBullet(text: "Wrap the package in soft fabric and **place in a container of crushed ice**, ensuring it **does not touch the ice directly**."),
                    StepBullet(text: "**Make sure the severed limb goes with the patient** to hospital.")
                ]
            )
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
            EmergencyStep(number: 1, title: "Sit and lean forward", detail: "Tilt slightly forward. Do not lean back.", bullets: [
                StepBullet(text: "Breathe through the mouth.")
            ]),
            EmergencyStep(number: 2, title: "Pinch the soft part", detail: "Pinch the soft part of the nose firmly for 10 minutes.", tip: "Use a clock and do not release early.", illustrationName: "nosebleed_pinch", illustrationLabel: "Pinch the soft part of the nose"),
            EmergencyStep(number: 3, title: "Cold pack", detail: "Apply a cold pack to the bridge of the nose.", bullets: [
                StepBullet(text: "Avoid blowing the nose for several hours afterward.")
            ])
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
            EmergencyStep(number: 1, title: "Cool the burn", detail: "Cool under cool running water for at least 20 minutes.", bullets: [
                StepBullet(text: "Do not use ice."),
                StepBullet(text: "Remove rings or tight items early if they are not stuck to the skin.")
            ], illustrationName: "burns_cool_water", illustrationLabel: "Cool burn under running water"),
            EmergencyStep(number: 2, title: "Protect the skin", detail: "Cover loosely once cooled.", bullets: [
                StepBullet(text: "Use **cling film** or a clean non fluffy cloth.")
            ]),
            EmergencyStep(number: 3, title: "Avoid creams", detail: "Do not apply creams, lotions, or sprays.")
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
            EmergencyStep(number: 1, title: "Call emergency services", detail: "Call emergency services immediately.", tip: nil, warning: nil, callNumber: "112"),
            EmergencyStep(number: 2, title: "Cool the burn", detail: "Cool with cool running water for at least 20 minutes. Watch for hypothermia in children and older adults.", tip: nil, warning: nil, callNumber: nil),
            EmergencyStep(number: 3, title: "Remove tight items early", detail: "While cooling and before swelling, gently remove rings or tight clothing unless stuck to skin.", tip: nil, warning: nil, callNumber: nil),
            EmergencyStep(number: 4, title: "Cover loosely", detail: "After cooling, cover loosely with cling film (or clean non-fluffy cloth).", tip: nil, warning: nil, callNumber: nil)
        ]
    )

    static let chemicalBurn = EmergencyTopic(
        title: "Acid and Chemical Burns",
        category: .burns,
        symbol: "testtube.2",
        summary: "Remove the chemical and rinse with cool running water for at least 20 minutes. Seek urgent help for eye, large, or deep burns.",
        symptoms: [
            "Pain, redness, or blistering",
            "Burn after contact with chemical",
            "Eye pain or vision changes if splashed in eyes"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Remove the chemical", detail: "Brush off dry chemical. Remove contaminated clothing and jewelry.", bullets: [
                StepBullet(text: "Avoid touching the chemical with bare hands."),
                StepBullet(text: "If powder, brush off first before rinsing.")
            ]),
            EmergencyStep(number: 2, title: "Rinse with cool running water", detail: "Rinse the area for at least 20 minutes.", bullets: [
                StepBullet(text: "Do not use ice or creams."),
                StepBullet(text: "For eye exposure, remove contact lenses and irrigate for at least 20 minutes, keeping eyelids open.")
            ]),
            EmergencyStep(number: 3, title: "Call emergency services if severe", detail: "Call if the burn is large, deep, on the face, hands, genitals, or eyes, or if pain is severe.", tip: nil, warning: nil, callNumber: "112"),
            EmergencyStep(number: 4, title: "Cover loosely", detail: "After thorough rinsing, cover with cling film or a clean non fluffy cloth.")
        ]
    )

    static let sunburn = EmergencyTopic(
        title: "Sunburn",
        category: .burns,
        symbol: "sun.max.fill",
        summary: "Move out of the sun, cool the skin, and drink fluids. Seek help for severe blistering or symptoms of heat illness.",
        symptoms: [
            "Red, painful skin",
            "Warm or hot to touch",
            "Blistering in more serious cases"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Get out of the sun", detail: "Move to shade or indoors. Cool the skin with a cool shower or cool compresses."),
            EmergencyStep(number: 2, title: "Hydrate and relieve pain", detail: "Drink water. Consider pain relief if appropriate.", bullets: [
                StepBullet(text: "Use a gentle, water based moisturizer or aloe gel after cooling."),
                StepBullet(text: "Do not pop blisters. Do not use petroleum jelly on fresh burns.")
            ]),
            EmergencyStep(number: 3, title: "Seek medical advice if severe", detail: "Get help if there is extensive blistering, fever, confusion, or if an infant is sunburned.")
        ]
    )

    static let frostbite = EmergencyTopic(
        title: "Frostbite",
        category: .burns,
        symbol: "thermometer.snowflake",
        summary: "Warm the person and rewarm the area in warm water. Do not rub. Seek medical help.",
        symptoms: [
            "Numbness, cold skin that may look pale, blue, or grey",
            "Hard or waxy skin",
            "Loss of feeling"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Move to a warm place", detail: "Remove wet clothing and protect the area from further cold."),
            EmergencyStep(number: 2, title: "Rewarm gently", detail: "Immerse in warm water (about 37 to 39°C) for 20 to 30 minutes.", bullets: [
                StepBullet(text: "Do not rub or massage the area."),
                StepBullet(text: "Do not use direct heat like a fire or radiator."),
                StepBullet(text: "If refreezing is possible, delay rewarming and keep warm otherwise.")
            ]),
            EmergencyStep(number: 3, title: "Cover and seek medical help", detail: "Loosely cover with a clean, dry dressing. Seek urgent care, especially if the area is hard, blistered, or numb.")
        ]
    )

    static let snakeBites = EmergencyTopic(
        title: "Snake Bites",
        category: .poisoning,
        symbol: "bandage.fill",
        summary: "Most bites aren’t serious, but all need quick medical care.",
        symptoms: [
            "Pain, redness, or swelling at the bite",
            "Nausea, dizziness, or sweating",
            "Tingling or numbness",
            "Trouble breathing (seek help immediately)"
        ],
        steps: [
            EmergencyStep(number: 1, title: "Get medical help", detail: "Call emergency services or go to A&E. Do not delay.", warning: "Do not drive yourself. Ask someone to drive or call an ambulance.", callNumber: "112"),
            EmergencyStep(number: 2, title: "What to do", detail: "Keep them calm and still.", bullets: [
                StepBullet(text: "**Remove rings or tight items** before swelling."),
                StepBullet(text: "Keep the bite **below heart level**."),
                StepBullet(text: "Clean around the bite if needed. Do not cut the wound.")
            ]),
            EmergencyStep(number: 3, title: "What not to do", detail: "Avoid harmful actions.", bullets: [
                StepBullet(text: "Do not cut the wound."),
                StepBullet(text: "Do not suck out venom."),
                StepBullet(text: "Do not use a tourniquet or ice.")
            ]),
            EmergencyStep(number: 4, title: "Recovery position if needed", detail: "If drowsy or vomiting, turn on their side to keep the airway clear.", illustrationName: "snake poison step 4 recovery position ", illustrationLabel: "Recovery position")
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
            EmergencyStep(number: 1, title: "Protect from injury", detail: "Clear hazards and protect the head.", warning: "Do not hold the person down.", bullets: [
                StepBullet(text: "Move furniture away and **cushion the head** with something soft."),
                StepBullet(text: "Loosen tight clothing around the neck."),
                StepBullet(text: "Do not put anything in the mouth.")
            ]),
            EmergencyStep(number: 2, title: "Time the seizure", detail: "If it lasts more than 5 minutes, call emergency services.", callNumber: "112"),
            EmergencyStep(number: 3, title: "After the seizure", detail: "When movements stop, help breathing.", bullets: [
                StepBullet(text: "Turn on their side into the **recovery position**."),
                StepBullet(text: "Stay until fully awake and breathing normally.")
            ], illustrationName: "recovery_position", illustrationLabel: "Person turned into recovery position")
        ]
    )
}
