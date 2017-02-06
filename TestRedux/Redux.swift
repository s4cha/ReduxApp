//
//  Redux.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

protocol State { }

protocol Action { }
typealias ActionCreator = (_ dispatch: @escaping Dispatch) -> Void

var store:Store!

protocol Store {
    func dispatch(_ action:Action)
    func dispatch(_ actionCreator:ActionCreator)
    var state:State {get set}
    var reducer:Reducer {get set}
    var stateObservers:[StateObserver] { get }
    func subscribe(_ observer:StateObserver)
}

protocol Reducer {
    func handleAction(_ state:State, action:Action) -> State
}

protocol StateObserver {
    func newState(_ state:State)
}

class DefaultStore:Store {
    var state:State
    var reducer:Reducer
    var stateObservers = [StateObserver]()
    
    init(aState:State, aReducer:Reducer) {
        state = aState
        reducer = aReducer
    }
    
    func dispatch(_ action: Action) {
        state = reducer.handleAction(state, action: action)
        pushStateToStateObserver()
    }
    
    func dispatch(_ actionCreator:ActionCreator) {
        actionCreator(store.dispatch)
    }
    
    func subscribe(_ observer:StateObserver) {
        stateObservers.append(observer)
        observer.newState(state)
    }

    func unSubscribe(_ observer:StateObserver) {
//        if let index = stateObservers.indexOf(observer){
//          stateObservers.removeAtIndex(index)
//        }
    }

    func pushStateToStateObserver() {
        for so in stateObservers {
            so.newState(state)   // TODO filter States so.filterState(state))
        }
    }
}

typealias Dispatch = (Action) -> Void

//Helpers

import UIKit

extension StateObserver {
    
    func dispatch(_ action: Action) {
        store.dispatch(action)
    }
    
    func dispatch(_ actionCreator:ActionCreator) {
        store.dispatch(actionCreator)
    }
    
    func subscribe(_ observer:StateObserver) {
        store.subscribe(observer)
    }
}
