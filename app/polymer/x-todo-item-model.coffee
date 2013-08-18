Polymer 'x-todo-item-model',
    editing: false
    description: ""

    toObject: ->
        description: @description, editing: @editing

    toString: ->
        JSON.stringify @toObject()
