//
//  ExerciseModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

final class ExerciseModel {

    let id: UUID
    let index: Int
    let title: String
    let description: String
    let imageName: String
    var currentState: CurrentState = .begin
    let setDuration: Int        // длительность одного подхода (сек)
    let recoveryDuration: Int   // отдых после подхода (сек)
    let setsCount: Int          // количество подходов
    let isLastInCycle: Bool     // является ли циклической и нужно ли добавить отдых
    let exerciseDuration: Int   // время выполнения всего уражнения
    var progress: Int = 0

    init(id: UUID, index: Int, title: String, description: String, imageName: String?, setDuration: Int, recoveryDuration: Int, setsCount: Int, isLastInCycle: Bool) {
        self.id = id
        self.index = index
        self.title = title
        self.description = description
        self.imageName = Self.groupedImageName(for: imageName)
        self.setDuration = setDuration
        self.recoveryDuration = recoveryDuration
        self.setsCount = setsCount
        self.isLastInCycle = isLastInCycle
        self.exerciseDuration = (setDuration + recoveryDuration) * setsCount + (isLastInCycle ? recoveryDuration : 0)
    }

    private static func groupedImageName(for rawImage: String?) -> String {
        guard let rawImage = rawImage else {
            return "exercise_default"
        }
        let s = rawImage.lowercased()

        // Снаряды — одна картинка на весь снаряд
        if s.contains("medball") { return "exercise_medball" }
        if s.contains("kettlebell") { return "exercise_kettlebell" }
        if s.contains("trx") { return "exercise_trx" }
        if s.contains("band") { return "exercise_band" }

        // Кардио / прыжки / взрывные
        if s.contains("burpee") ||
            s.contains("jump") ||
            s.contains("sprint") ||
            s.contains("shuttle") ||
            s.contains("high_knees") ||
            s.contains("butt_kicks") ||
            s.contains("jumping_jack") ||
            s.contains("mountain_climber") ||
            s.contains("ski_jump") {
            return "exercise_cardio"
        }

        // Отжимания и брусья
        if s.contains("pushup") || s.contains("dips") || s.contains("bench_dip") {
            return "exercise_pushup"
        }

        // Подтягивания и выходы силой
        if s.contains("pullup") || s.contains("muscle_up") {
            return "exercise_pullup"
        }

        // Ноги: приседы, выпады, тренажёры на ноги
        if s.contains("squat") ||
            s.contains("lunge") ||
            s.contains("bulgarian") ||
            s.contains("step_up") ||
            s.contains("leg_press") ||
            s.contains("leg_curl") ||
            s.contains("leg_extension") ||
            s.contains("calf_raise") ||
            s.contains("hip_adduction") ||
            s.contains("hip_abduction") ||
            s.contains("glute_kickback") ||
            s.contains("wall_sit") {
            return "exercise_legs"
        }

        // Ягодицы / мостики
        if s.contains("glute_bridge") || s.contains("bridge") || s.contains("hip_thrust") {
            return "exercise_glutes"
        }

        // Пресс / кор
        if s.contains("plank") ||
            s.contains("crunch") ||
            s.contains("sit_up") ||
            s.contains("leg_raise") ||
            s.contains("knee_raise") ||
            s.contains("russian_twist") ||
            s.contains("bicycle") ||
            s.contains("superman") ||
            s.contains("boat") ||
            s.contains("cobra") ||
            s.contains("leg_hold") {
            return "exercise_core"
        }

        // Спина / тяги / задние дельты
        if s.contains("row") ||
            s.contains("pulldown") ||
            s.contains("face_pull") ||
            s.contains("rear_delt") ||
            s.contains("hyperextension") {
            return "exercise_back"
        }

        // Грудь — жимы
        if s.contains("bench_press") ||
            s.contains("incline_press") ||
            s.contains("decline_press") ||
            s.contains("floor_press") ||
            s.contains("chest_press") {
            return "exercise_chest_press"
        }

        // Грудь — разводки / кроссоверы / пуловеры
        if s.contains("fly") ||
            s.contains("crossover") ||
            s.contains("pullover") ||
            s.contains("chest_fly") {
            return "exercise_chest_fly"
        }

        // Плечи
        if s.contains("shoulder_press") ||
            s.contains("overhead_press") ||
            s.contains("lateral_raise") ||
            s.contains("front_raise") ||
            s.contains("upright_row") ||
            s.contains("one_arm_press") ||
            s.contains("two_hand_overhead") {
            return "exercise_shoulders"
        }

        // Бицепс
        if s.contains("curl") {
            return "exercise_biceps"
        }

        // Трицепс
        if s.contains("triceps") ||
            s.contains("french_press") ||
            s.contains("pushdown") ||
            s.contains("kickback") ||
            s.contains("close_grip") {
            return "exercise_triceps"
        }

        // Становая / румынская
        if s.contains("deadlift") ||
            s.contains("romanian") ||
            s.contains("stiff_leg") {
            return "exercise_deadlift"
        }

        // Йога / растяжка / мобильность
        if s.contains("stretch") ||
            s.contains("yoga") ||
            s.contains("dog") ||
            s.contains("warrior") ||
            s.contains("triangle") ||
            s.contains("neck") ||
            s.contains("shoulder_roll") ||
            s.contains("arm_circles") ||
            s.contains("hip_circles") {
            return "exercise_mobility"
        }

        return "exercise_default"
    }
}
