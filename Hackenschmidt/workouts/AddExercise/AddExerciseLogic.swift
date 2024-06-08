//
//  AddExerciseLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import Foundation

class AddExerciseChecker{
    func checkName(name: String) ->Bool{
        return name.isEmpty;
    }
    
    func checkSets(sets: Int) -> Bool{
        return sets <= 0;
    }
    
    func checkWeight(weight: Int) -> Bool{
        return weight <= 0;
    }
    
    func checkMuscleGroup(group: String) ->Bool{
        return group.isEmpty;
    }
    
    func checkEquipment(equipment: String) -> Bool{
        return equipment.isEmpty;
    }
    
    func checkAll(name: String, sets: Int, weight: Int, group: String, equipment: String) -> Bool{
        if(name.isEmpty){
            return true
        }
        
        if (sets <= 0){
            return true
        }
        
        if(weight <= 0){
            return true
        }
        
        if(group.isEmpty){
            return true
        }
        
        if(equipment.isEmpty){
            return true
        }
        
        return false
    }
}
