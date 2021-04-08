@Docs = new Meteor.Collection 'docs'
@Tags = new Meteor.Collection 'tags'
@Level_results = new Meteor.Collection 'level_results'

@results = new Meteor.Collection 'results'


Docs.helpers
    _author: -> Meteor.users.findOne @_author_id
    _buyer: -> Meteor.users.findOne @buyer_id
    recipient: ->
        Meteor.users.findOne @recipient_id
    seven_tags: ->
        if @tags
            @tags[..7]
    five_tags: ->
        if @tags
            @tags[..5]
    ten_tags: ->
        if @tags
            @tags[..10]
    three_tags: ->
        if @tags
            @tags[..3]

    when: -> moment(@_timestamp).fromNow()
    is_visible: -> @published in [0,1]
    is_published: -> @published is 1
    is_anonymous: -> @published is 0
    is_private: -> @published is -1
    is_read: ->
        @read_ids and Meteor.userId() in @read_ids




Docs.before.insert (userId, doc)->
    # if Meteor.user()
    timestamp = Date.now()
    doc._timestamp = timestamp
    doc._timestamp_long = moment(timestamp).format("dddd, MMMM Do YYYY, h:mm:ss a")

    doc.app = 'stand'

    date = moment(timestamp).format('Do')
    weekdaynum = moment(timestamp).isoWeekday()
    weekday = moment().isoWeekday(weekdaynum).format('dddd')

    hour = moment(timestamp).format('h')
    minute = moment(timestamp).format('m')
    ap = moment(timestamp).format('a')
    month = moment(timestamp).format('MMMM')
    year = moment(timestamp).format('YYYY')


    doc.points = 0


    # date_array = [ap, "hour #{hour}", "min #{minute}", weekday, month, date, year]
    date_array = [ap, weekday, month, date, year]
    if _
        date_array = _.map(date_array, (el)-> el.toString().toLowerCase())
        # date_array = _.each(date_array, (el)-> console.log(typeof el))
        # console.log date_array
        doc._timestamp_tags = date_array

    return



Meteor.methods
    add_facet_filter: (delta_id, key, filter)->
        if key is '_keys'
            new_facet_ob = {
                key:filter
                filters:[]
                res:[]
            }
            Docs.update { _id:delta_id },
                $addToSet: facets: new_facet_ob
        Docs.update { _id:delta_id, "facets.key":key},
            $addToSet: "facets.$.filters": filter

        Meteor.call 'fum', delta_id, (err,res)->


    remove_facet_filter: (delta_id, key, filter)->
        if key is '_keys'
            Docs.update { _id:delta_id },
                $pull:facets: {key:filter}
        Docs.update { _id:delta_id, "facets.key":key},
            $pull: "facets.$.filters": filter
        Meteor.call 'fum', delta_id, (err,res)->



    upvote_sentence: (doc_id, sentence)->
        # console.log sentence
        if sentence.weight
            Docs.update(
                { _id:doc_id, "tone.result.sentences_tone.sentence_id": sentence.sentence_id },
                $inc: 
                    "tone.result.sentences_tone.$.weight": 1
                    points:1
            )
        else
            Docs.update(
                { _id:doc_id, "tone.result.sentences_tone.sentence_id": sentence.sentence_id },
                {
                    $set: 
                        "tone.result.sentences_tone.$.weight": 1
                    $inc:
                        points:1
                }
            )
    tag_sentence: (doc_id, sentence, tag)->
        # console.log sentence
        Docs.update(
            { _id:doc_id, "tone.result.sentences_tone.sentence_id": sentence.sentence_id },
            { $addToSet: 
                "tone.result.sentences_tone.$.tags": tag
                "tags": tag
            }
        )

    reset_sentence: (doc_id, sentence)->
        # console.log sentence
        Docs.update(
            { _id:doc_id, "tone.result.sentences_tone.sentence_id": sentence.sentence_id },
            { 
                $set: 
                    "tone.result.sentences_tone.$.weight": -2
            } 
        )


    downvote_sentence: (doc_id, sentence)->
        # console.log sentence
        Docs.update(
            { _id:doc_id, "tone.result.sentences_tone.sentence_id": sentence.sentence_id },
            { $inc: 
                "tone.result.sentences_tone.$.weight": -1
                points: -1
            }
        )
    check_url: (str)->
        # console.log 'testing', str
        pattern = new RegExp('^(https?:\\/\\/)?'+ # protocol
        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ # domain name
        '((\\d{1,3}\\.){3}\\d{1,3}))'+ # OR ip (v4) address
        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ # port and path
        '(\\?[;&a-z\\d%_.~+=-]*)?'+ # query string
        '(\\#[-a-z\\d_]*)?$','i') # fragment locator
        return !!pattern.test(str)
