
import Foundation
import SpriteKit

class Enemy {
    
    var enemyName: String
    
    var baseAttack: Float
    
    var baseDefense: Float
    
    var maxHP: Float
    
    var currentHP: Float
    
    var actualAttack: Float
    
    var actualDefense: Float
    
    init(_enemyName: String, _baseAttack: Float, _baseDefense: Float, _maxHP: Float) {
        
        enemyName = _enemyName
        baseAttack = _baseAttack
        baseDefense = _baseDefense
        maxHP = _maxHP
        
        currentHP = maxHP
        actualAttack = baseAttack
        actualDefense = baseDefense

    }
    
}


