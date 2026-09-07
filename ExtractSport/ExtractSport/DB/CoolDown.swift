//
//  CoolDown.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 07.09.2026.
//

import Foundation

struct CoolDown {
    
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
        
        let status: String = (ex.count >= WorkoutModelConstants.coolDownExercisesCount ? "✅" : "❌")
        print("\(status) Упражений на заминку = \(ex.count) \t[targetArea: \(targetArea)]")
        return exercises.filter { exercise in
            exercise.targetAreas.contains(targetArea)
        }
    }
    
    let exercises: [Exercise] = [
        // ===== НОГИ (legs) – 5 шт. =====
        Exercise(
            name: "Наклон вперёд к прямым ногам",
            description: "Стоя, ноги на ширине плеч, медленно наклоняйтесь вперёд, стараясь коснуться руками пола, колени держите прямыми. Задержитесь на 20–30 сек.",
            image: "cooldown_forward_fold",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Растяжка задней поверхности бедра стоя",
            description: "Выставьте одну ногу вперёд на пятку, носок на себя. Наклонитесь к этой ноге, сохраняя спину прямой. Держите 20–30 сек, затем смените ногу.",
            image: "cooldown_hamstring_stretch",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Растяжка квадрицепса стоя",
            description: "Согните одну ногу в колене, возьмитесь рукой за стопу и притяните пятку к ягодице. Держите 20–30 сек, затем смените ногу. Для равновесия можно держаться взглядом за точку.",
            image: "cooldown_quad_stretch",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Растяжка икроножных мышц",
            description: "Сделайте шаг назад одной ногой, пятка прижата к полу, нога прямая. Согните переднюю ногу в колене, подавая таз вперёд. Держите 20–30 сек, смените ногу.",
            image: "cooldown_calf_stretch",
            targetAreas: [.legs]
        ),
        Exercise(
            name: "Статический выпад с наклоном",
            description: "Сделайте широкий шаг вперёд, зафиксируйте выпад. Медленно опускайте таз вниз, чувствуя растяжение в передней части бедра задней ноги. Держите 20–30 сек, смените ногу.",
            image: "cooldown_lunge_stretch",
            targetAreas: [.legs]
        ),

        // ===== РУКИ И ПЛЕЧИ (armsAndShoulders) – 5 шт. =====
        Exercise(
            name: "Растяжка трицепса стоя",
            description: "Поднимите одну руку вверх, согните в локте и опустите ладонь за спину. Другой рукой мягко надавите на локоть, растягивая трицепс. Держите 20–30 сек, смените руку.",
            image: "cooldown_triceps_stretch",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Растяжка бицепса и передней части плеча",
            description: "Сцепите руки в замок за спиной, выпрямите локти и поднимите руки вверх, отводя плечи назад. Держите 20–30 сек.",
            image: "cooldown_biceps_stretch",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Растяжка дельтовидных мышц (рука через грудь)",
            description: "Выпрямите одну руку и прижмите её к груди, помогая другой рукой. Держите 20–30 сек, смените руку.",
            image: "cooldown_chest_shoulder_stretch",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Растяжка шеи с наклоном в стороны",
            description: "Медленно наклоняйте голову к плечу, помогая рукой, но без сильного давления. Держите 15–20 сек, затем смените сторону.",
            image: "cooldown_neck_side_stretch",
            targetAreas: [.armsAndShoulders]
        ),
        Exercise(
            name: "Круговые движения плечами (медленно)",
            description: "Выполняйте плавные круговые движения плечами вперёд и назад, с максимальной амплитудой, по 5–7 раз в каждую сторону.",
            image: "cooldown_shoulder_circles",
            targetAreas: [.armsAndShoulders]
        ),

        // ===== СПИНА (back) – 5 шт. =====
        Exercise(
            name: "Наклон вперёд с округлением спины",
            description: "Слегка согните колени, наклоните корпус вперёд, округляя спину и опуская голову вниз. Почувствуйте растяжение вдоль позвоночника. Держите 20–30 сек.",
            image: "cooldown_round_back_stretch",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Прогиб назад с опорой на поясницу",
            description: "Руки на пояснице, медленно прогнитесь назад, направляя взгляд вверх. Держите 15–20 сек, затем вернитесь в нейтральное положение.",
            image: "cooldown_back_bend",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Скручивание корпуса стоя (растяжка спины)",
            description: "Стоя, руки в стороны, плавно поверните корпус вправо, затем влево, фиксируя крайнее положение на 15–20 сек.",
            image: "cooldown_torso_twist",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Растяжка широчайших мышц (рука вверх, наклон в сторону)",
            description: "Поднимите правую руку вверх, наклоните корпус влево, чувствуя растяжение правого бока и спины. Держите 20–30 сек, смените сторону.",
            image: "cooldown_lat_stretch",
            targetAreas: [.back]
        ),
        Exercise(
            name: "Кошка-корова (стоя у стены – но мы делаем без стены, просто прогибы)",
            description: "Встаньте прямо, на вдохе прогнитесь в пояснице, направляя копчик назад, голову вверх. На выдохе округлите спину, подбородок к груди. Повторите 5–8 раз медленно.",
            image: "cooldown_cat_cow_standing",
            targetAreas: [.back]
        ),

        // ===== ГРУДЬ (chest) – 5 шт. =====
        Exercise(
            name: "Растяжка грудных мышц (руки за спиной)",
            description: "Сцепите руки в замок за спиной, выпрямите локти и максимально отведите руки назад, раскрывая грудную клетку. Держите 20–30 сек.",
            image: "cooldown_chest_stretch_hands_behind",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Растяжка грудных мышц у стены (без стены – имитация)",
            description: "Вытяните одну руку в сторону, согните в локте 90°, предплечье вертикально. Поверните корпус в противоположную сторону, чувствуя растяжение груди. Выполните по 20–30 сек на каждую руку.",
            image: "cooldown_chest_stretch_arm",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Растяжка грудных мышц с подъёмом рук вверх",
            description: "Сцепите руки над головой, выпрямите локти и отведите руки назад, прогибаясь в грудном отделе. Держите 20–30 сек.",
            image: "cooldown_chest_stretch_overhead",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Отведение рук назад с прямыми локтями",
            description: "Стоя, отведите прямые руки назад, сводя лопатки, и задержитесь на 15–20 сек. Повторите 3–4 раза.",
            image: "cooldown_arms_back_squeeze",
            targetAreas: [.chest]
        ),
        Exercise(
            name: "Динамическое раскрытие груди (плавные махи)",
            description: "Стоя, руки в стороны, делайте медленные махи руками назад, сводя лопатки, затем возвращайте вперёд. Выполните 8–10 раз.",
            image: "cooldown_chest_open_swings",
            targetAreas: [.chest]
        ),

        // ===== ПРЕСС И КОР (absAndCore) – 5 шт. =====
        Exercise(
            name: "Наклоны в стороны (растяжка косых мышц)",
            description: "Стоя, руки на поясе, наклоняйтесь вправо, затем влево, фиксируя крайнее положение на 15–20 сек.",
            image: "cooldown_side_bend_oblique",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Повороты корпуса с фиксацией (для пресса)",
            description: "Стоя, руки перед грудью, поверните корпус вправо, зафиксируйте на 15–20 сек, затем влево.",
            image: "cooldown_core_twist",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Растяжка живота (прогиб назад)",
            description: "Медленно прогнитесь назад, выпрямляя руки над головой и раскрывая грудную клетку, чувствуя растяжение передней поверхности корпуса. Держите 15–20 сек.",
            image: "cooldown_ab_stretch_backbend",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Наклон вперёд с вытянутыми руками (растяжка поясницы)",
            description: "Наклонитесь вперёд, руки вытянуты вперёд, спина прямая. Потянитесь руками вперёд, удлиняя позвоночник. Держите 20–30 сек.",
            image: "cooldown_forward_reach",
            targetAreas: [.absAndCore]
        ),
        Exercise(
            name: "Боковой наклон с поднятой рукой (растяжка брюшной стенки)",
            description: "Поднимите одну руку вверх, наклонитесь в противоположную сторону, чувствуя растяжение вдоль бока. Держите 20–30 сек, смените сторону.",
            image: "cooldown_side_stretch_arm_up",
            targetAreas: [.absAndCore]
        ),

        // ===== ВСЁ ТЕЛО (fullBody) – 5 шт. =====
        Exercise(
            name: "Глубокий наклон вперёд с захватом локтей",
            description: "Наклонитесь вперёд, согнув колени, обхватите локти руками и повисите, расслабляя спину и ноги. Держите 20–30 сек.",
            image: "cooldown_deep_forward_fold",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Поза треугольника (растяжка всего тела)",
            description: "Широко расставьте ноги, наклонитесь в сторону, одна рука тянется к полу, другая вверх. Выполните по 20–30 сек на каждую сторону.",
            image: "cooldown_triangle_stretch",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Скручивание с выпадом (растяжка корпуса и ног)",
            description: "Сделайте шаг назад в выпад, поверните корпус в сторону передней ноги, руки в стороны. Держите 20–30 сек, смените ногу.",
            image: "cooldown_lunge_twist_stretch",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Волна (плавные прогибы и округления)",
            description: "Стоя, плавно переходите из прогиба назад в наклон вперёд, создавая волнообразное движение позвоночника. Повторите 5–7 раз.",
            image: "cooldown_spinal_wave",
            targetAreas: [.fullBody]
        ),
        Exercise(
            name: "Растяжка всего тела с подъёмом рук и пяток",
            description: "Встаньте прямо, поднимите руки вверх, соедините ладони и потянитесь вверх, одновременно поднимаясь на носки. Задержитесь на 15–20 сек, затем опуститесь.",
            image: "cooldown_full_body_stretch",
            targetAreas: [.fullBody]
        )
    ]
}
