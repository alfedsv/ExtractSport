//
//  WarmUp.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 07.09.2026.
//

import Foundation

struct WarmUp {
    
    struct Exercise: Identifiable {
        let id: UUID
        let name: String
        let description: String
        let image: String
        let targetAreas: [TargetArea]
        init(name: String, description: String, image: String, targetAreas: [TargetArea]) {
            self.id = UUID()
            self.name = name
            self.description = description
            self.image = image
            self.targetAreas = targetAreas
        }
    }
    
    func getExercises(targetArea: TargetArea) -> [Exercise] {
        let ex: [Exercise] = exercises.filter { exercise in
            exercise.targetAreas.contains(targetArea)
        }
        
        let status: String = (ex.count >= WorkoutModelConstants.warmUpExercisesCount ? "✅" : "❌")
        print("\(status) Упражений на разминку = \(ex.count) \t[targetArea: \(targetArea)]")
        return exercises.filter { exercise in
            exercise.targetAreas.contains(targetArea)
        }
    }
    
    let exercises: [Exercise] = [
        // ===== НОГИ (legs) – 9 шт. =====
        Exercise(
            name: "Приседания с подъёмом на носки",
            description: "Выполняйте приседания, в верхней точке поднимайтесь на носки.",
            image: "warmup_squat_toe_raise",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Выпады назад попеременно",
            description: "Шагайте назад поочерёдно, сгибая обе ноги до прямого угла.",
            image: "warmup_reverse_lunge",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Боковые выпады",
            description: "Широкий шаг в сторону, согните опорную ногу, вторую выпрямите.",
            image: "warmup_side_lunge",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Зашагивания на воображаемую ступеньку",
            description: "Поочерёдно поднимайте колени высоко вверх, имитируя шаг на платформу.",
            image: "warmup_step_up",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Махи ногами вперёд",
            description: "Стоя на одной ноге, делайте махи прямой ногой вперёд.",
            image: "warmup_leg_swing_forward",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Махи ногами в стороны",
            description: "Стоя на одной ноге, отводите прямую ногу в сторону.",
            image: "warmup_leg_swing_side",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Подъёмы на носки",
            description: "Медленно поднимайтесь на носки и опускайтесь, сохраняя равновесие.",
            image: "warmup_calf_raise",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Приседания плие (полуприсед)",
            description: "Широкая стойка, носки наружу, выполняйте неглубокие приседания.",
            image: "warmup_plie_squat",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Стойка на одной ноге с подъёмом колена",
            description: "Стоя на одной ноге, поднимайте колено второй ноги к груди и опускайте.",
            image: "warmup_one_leg_knee_raise",
            targetAreas: [.legs]
        ),

        // ===== РУКИ И ПЛЕЧИ (armsAndShoulders) – 9 шт. =====
        Exercise(
            name: "Круговые движения плечами вперёд",
            description: "Вращайте плечами вперёд с максимальной амплитудой.",
            image: "warmup_shoulder_circle_forward",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Круговые движения плечами назад",
            description: "Вращайте плечами назад с максимальной амплитудой.",
            image: "warmup_shoulder_circle_backward",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Махи руками в стороны",
            description: "Разводите прямые руки в стороны до уровня плеч и сводите.",
            image: "warmup_arm_swing_side",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Махи руками перед собой",
            description: "Скрещивайте прямые руки перед грудью.",
            image: "warmup_arm_swing_front",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Вращения руками (круги)",
            description: "Выполняйте круговые движения прямыми руками вперёд и назад.",
            image: "warmup_arm_circles",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Наклоны головы в стороны",
            description: "Медленно наклоняйте голову к правому и левому плечу.",
            image: "warmup_neck_side_bend",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Повороты головы",
            description: "Поворачивайте голову вправо и влево, растягивая шею.",
            image: "warmup_neck_rotation",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Подъём рук вверх с хлопком",
            description: "Рывком поднимите руки вверх, хлопните над головой.",
            image: "warmup_arm_raise_clap",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Круговые движения запястьями и кистями",
            description: "Сцепите пальцы в замок и вращайте кистями в обе стороны.",
            image: "warmup_wrist_rotation",
            targetAreas: [.armsAndShoulders]
        ),

        // ===== СПИНА (back) – 9 шт. =====
        Exercise(
            name: "Наклоны туловища вперёд",
            description: "Из положения стоя наклоняйтесь вперёд, стараясь коснуться руками пола.",
            image: "warmup_forward_bend",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Наклоны в стороны",
            description: "Из положения стоя наклоняйтесь вправо и влево, скользя рукой по бедру.",
            image: "warmup_side_bend",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Скручивания корпуса стоя",
            description: "Стоя, поворачивайте корпус вправо и влево, оставляя таз неподвижным.",
            image: "warmup_torso_twist",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Прогиб назад (стоя)",
            description: "Положите руки на поясницу, осторожно прогнитесь назад, взгляд вверх.",
            image: "warmup_back_bend_standing",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Наклон вперёд с округлением спины",
            description: "Слегка согните колени, наклонитесь вперёд, округляя спину, затем выпрямитесь.",
            image: "warmup_round_back_stretch",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Растяжка широчайших мышц (стоя)",
            description: "Поднимите одну руку вверх, наклонитесь в противоположную сторону, потянитесь.",
            image: "warmup_lat_stretch",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Повороты туловища с вытянутыми руками",
            description: "Стоя, вытяните руки в стороны и поворачивайте корпус вправо-влево.",
            image: "warmup_torso_rotation_arms",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Наклоны вперёд с подъёмом рук (волна)",
            description: "Наклонитесь вперёд, затем поднимайте корпус, одновременно поднимая руки вверх, выпрямляя спину.",
            image: "warmup_forward_bend_arms_up",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Круги плечами с наклоном вперёд",
            description: "Наклонитесь вперёд, делайте круговые движения плечами, затем выпрямитесь.",
            image: "warmup_forward_shoulder_circles",
            targetAreas: [.back]
        ),

        // ===== ГРУДЬ (chest) – 9 шт. =====
        Exercise(
            name: "Сведение рук перед грудью (в замок)",
            description: "Согните руки в локтях, соедините ладони и с силой давите друг на друга.",
            image: "warmup_chest_press_isometric",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Разведение рук в стороны с сопротивлением",
            description: "Имитируйте разведение рук с резиной, напрягая грудные мышцы.",
            image: "warmup_chest_fly_iso",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Пуловер с воображаемым весом (стоя)",
            description: "Стоя, держите воображаемый груз перед грудью, опускайте его вниз и поднимайте над головой.",
            image: "warmup_pullover_standing",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Круговые движения руками в локтевых суставах (стоя)",
            description: "Согните руки в локтях, кисти у плеч, вращайте локтями вперёд и назад.",
            image: "warmup_elbow_circles",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Сведение лопаток (стоя)",
            description: "Стоя, сведите лопатки, задержитесь на секунду, затем расслабьте.",
            image: "warmup_scapular_squeeze_standing",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Динамическое разведение рук с хлопком за спиной",
            description: "Разведите руки в стороны, затем с силой хлопните ладонями за спиной (если не получается, просто сводите лопатки).",
            image: "warmup_clap_behind_back",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Рывковые движения руками вверх-вниз",
            description: "Стоя, резко поднимайте и опускайте прямые руки перед собой, напрягая грудь.",
            image: "warmup_arm_pumps",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Круговые движения руками (малые круги) в стороны",
            description: "Вытяните руки в стороны, делайте маленькие круговые движения кистями/руками, активно напрягая грудные мышцы.",
            image: "warmup_small_arm_circles",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Отведение рук назад с прямыми локтями",
            description: "Стоя, отведите прямые руки назад, сводя лопатки, затем верните вперёд.",
            image: "warmup_arms_back_swing",
            targetAreas: [.chest]
        ),

        // ===== ПРЕСС И КОР (absAndCore) – 9 шт. =====
        Exercise(
            name: "Наклоны в стороны с касанием пятки",
            description: "Стоя, ноги на ширине плеч, наклоняйтесь вправо, стараясь коснуться пятки, затем влево.",
            image: "warmup_side_bend_heel_touch",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Скручивания стоя (повороты корпуса)",
            description: "Стоя, скрестите руки перед грудью, поворачивайте корпус вправо и влево с усилием.",
            image: "warmup_standing_twist",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Подъём коленей к груди стоя",
            description: "Стоя, поднимайте колено к груди, помогая руками, поочерёдно.",
            image: "warmup_knee_to_chest_standing",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Боковые наклоны с поднятой рукой",
            description: "Поднимите одну руку вверх, наклоняйтесь в противоположную сторону, вытягивая бок.",
            image: "warmup_side_stretch_arm_up",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Вакуум живота стоя",
            description: "Сделайте глубокий выдох, втяните живот под рёбра, задержите на несколько секунд, повторите.",
            image: "warmup_stomach_vacuum",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Диагональные скручивания стоя",
            description: "Стоя, поднимайте правое колено и тянитесь к нему левым локтем, затем наоборот.",
            image: "warmup_standing_cross_crunch",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Наклоны вперёд с подъёмом рук вверх (для пресса)",
            description: "Наклонитесь вперёд, затем резко выпрямитесь, поднимая руки вверх и напрягая пресс.",
            image: "warmup_forward_crunch_standing",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Круги тазом",
            description: "Стоя, вращайте тазом по кругу, плавно, в обе стороны.",
            image: "warmup_hip_circles",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Подъём колена с поворотом корпуса",
            description: "Поднимите правое колено и поверните корпус вправо, затем левое – влево.",
            image: "warmup_knee_twist",
            targetAreas: [.absAndCore]
        ),

        // ===== ВСЁ ТЕЛО (fullBody) – 9 шт. =====
        Exercise(
            name: "Марш на месте с высоким подниманием колен",
            description: "Шагайте на месте, высоко поднимая колени, руки работают как при ходьбе.",
            image: "warmup_march_high_knees",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Альпинист (имитация стоя)",
            description: "Стоя, согните корпус вперёд, поочерёдно подтягивайте колени к груди в быстром темпе (без опоры руками).",
            image: "warmup_standing_mountain_climber",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Прыжки на месте с хлопком над головой",
            description: "Прыгайте, одновременно поднимая руки и хлопая над головой – мягко.",
            image: "warmup_jump_clap",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Прыжки «тучка» (джампинг джек)",
            description: "Из стойки ноги вместе прыжком разведите ноги в стороны, руки вверх.",
            image: "warmup_jumping_jack",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Бег на месте с высоким подниманием бедра",
            description: "Бегите на месте, поднимая колени как можно выше.",
            image: "warmup_high_knees",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Бег на месте с захлёстом голени",
            description: "Бегите на месте, стараясь пятками коснуться ягодиц.",
            image: "warmup_butt_kicks",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Полуприседания с разведением рук",
            description: "Неглубокий присед, руки разводите в стороны – всё в умеренном темпе.",
            image: "warmup_half_squat_arms",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Выпады назад с поворотом корпуса",
            description: "Шаг назад в выпад, поверните корпус в сторону передней ноги, вернитесь.",
            image: "warmup_reverse_lunge_twist",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Спринт на месте (в медленном темпе)",
            description: "Бег на месте с постепенным ускорением до комфортного темпа.",
            image: "warmup_sprint_place",
            targetAreas: [.fullBody]
        )
    ]
}
