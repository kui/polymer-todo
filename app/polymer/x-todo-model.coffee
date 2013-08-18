Polymer 'x-todo-model',
    # publish props
    items: []
    storageId: 'x-todo-model'

    enteredDocument: ->
        @load()

    itemsChanged: ->
        @save()

    addItem: (desc) ->
        console.debug "addItem: #{desc}"

        if (not desc?) or (desc.length is 0)
            console.debug 'ignore'
            return

        # TODO document 使うな
        # TODO item-model の作成は item-model に任せたい
        item = document.createElement('x-todo-item-model');
        item.description = desc

        @items.push item
        @itemsChanged()

    deleteItem: (item) ->
        console.debug "deleteItem: %o", item

        idx = @items.indexOf(item)
        if idx < 0
            throw "invalid item: #{item?.description}"

        @_deleteItem idx

    _deleteItem: (idx) ->
        delete @items[idx]
        @items = (i for i in @items when i?)

    save: ->
        console.debug "save: %o", @toObject()
        # TODO localStrage をラップしろ
        localStorage.setItem @storageId, @toString()

    load: ->
        json = localStorage.getItem(@storageId)
        objs = JSON.parse(json)
        if not objs?
            console.debug 'did not stored ToDo items'
            return

        for obj in objs
            # TODO 毎回 save() が走ってしまう
            @addItem obj.description

    toObject: ->
        i.toObject() for i in @items

    toString: ->
        JSON.stringify @toObject()
