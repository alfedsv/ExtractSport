//
//  ExtractSportTests.swift
//  ExtractSportTests
//
//  Created by  Alexander Fedoseev on 31.08.2026.
//

import XCTest
@testable import ExtractSport

final class ExtractSportTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testExercisesCountAtLeastFifteenForAllCombinations() {
        let workout = Workout()
        let targetAreas: [TargetArea] = [.legs, .armsAndShoulders, .back, .chest, .absAndCore, .fullBody]
        let workoutTypes: [WorkoutType] = [.strength, .endurance, .explosivePower, .circuit]
        let equipments: [Equipment] = [.bodyweight, .homeGym, .outdoorPark, .gym]
        for target in targetAreas {
            for type in workoutTypes {
                for equipment in equipments {
                    let exercises = workout.getExercises(
                        targetArea: target,
                        workoutType: type,
                        equipment: equipment
                    )
                    let count = exercises.count
                    XCTAssertGreaterThanOrEqual(
                        count,
                        WorkoutModelConstants.exercisesCountMax,
                        "Комбинация (\(target), \(type), \(equipment)) вернула \(count) упражнений, а нужно минимум \(WorkoutModelConstants.exercisesCountMax)"
                     )
                    
                }
            }
        }
    }
    
    func testWarmUpCountAtLeastFifteenForAllCombinations() {
        let workout = WarmUp()
        let targetAreas: [TargetArea] = [.legs, .armsAndShoulders, .back, .chest, .absAndCore, .fullBody]
        for target in targetAreas {
            let exercises = workout.getExercises(targetArea: target)
            let count = exercises.count
            XCTAssertGreaterThanOrEqual(
                count,
                WorkoutModelConstants.warmUpExercisesCount,
                "Комбинация (\(target)) вернула \(count) упражнений на разминку, а нужно минимум \(WorkoutModelConstants.warmUpExercisesCount)"
             )
        }
    }

    func testCoolDownCountAtLeastFifteenForAllCombinations() {
        let workout = CoolDown()
        let targetAreas: [TargetArea] = [.legs, .armsAndShoulders, .back, .chest, .absAndCore, .fullBody]
        for target in targetAreas {
            let exercises = workout.getExercises(targetArea: target)
            let count = exercises.count
            XCTAssertGreaterThanOrEqual(
                count,
                WorkoutModelConstants.coolDownExercisesCount,
                "Комбинация (\(target)) вернула \(count) упражнений на заминку, а нужно минимум \(WorkoutModelConstants.coolDownExercisesCount)"
             )
        }
    }
}
