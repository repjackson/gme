# Router.route '/g/:group', (->
#     @layout 'layout'
#     @render 'group'
#     ), name:'group'
# # Router.route '/:group', (->
# #     @layout 'layout'
# #     @render 'group'
# #     ), name:'group_short'

@picked_tags = new ReactiveArray []
@picked_time_tags = new ReactiveArray []
@picked_location_tags = new ReactiveArray []
@picked_people_tags = new ReactiveArray []
@picked_emotion = new ReactiveArray []
@picked_timestamp_tags = new ReactiveArray []


    

# Template.home.onCreated ->
#     Session.setDefault('ticker_view', 'small')
#     Session.setDefault('sort_key', '_timestamp')
#     @autorun => Meteor.subscribe 'agg_sentiment_group',
#         # Router.current().params.group
#         picked_tags.array()
#         picked_time_tags.array()
#         picked_location_tags.array()
#         picked_people_tags.array()
#         picked_emotion.array()
#         picked_timestamp_tags.array()
#         ()->Session.set('ready',true)

#     @autorun => Meteor.subscribe 'group_tags',
#         # Router.current().params.group
#         picked_tags.array()
#         picked_time_tags.array()
#         picked_location_tags.array()
#         picked_people_tags.array()
#         picked_emotion.array()
#         picked_timestamp_tags.array()
#         # selected_group_authors.array()
#         Session.get('toggle')
#     @autorun => Meteor.subscribe 'group_count', 
#         # Router.current().params.group
#         picked_tags.array()
#         picked_time_tags.array()
#         picked_location_tags.array()
#         picked_people_tags.array()
    
#     @autorun => Meteor.subscribe 'group_posts', 
#         # Router.current().params.group
#         picked_tags.array()
#         picked_time_tags.array()
#         picked_location_tags.array()
#         picked_people_tags.array()
#         picked_emotion.array()
#         picked_timestamp_tags.array()
#         Session.get('sort_key')
#         Session.get('sort_direction')
#         Session.get('skip_value')

# Template.home.helpers
#     posts: ->
#         # sort_key = Session.eu
#         # if Router.current().params.group is 'all'
#         #     Docs.find 
#         #         model:'post'
#         #         group:$exists:false
#         # else
#         Docs.find {
#             model:'post'
#             group:'gme'
#         }, sort:"#{Session.get('sort_key')}":-1
#     picked_tags: -> picked_tags.array()
#     picked_time_tags: -> picked_time_tags.array()
#     picked_location_tags: -> picked_location_tags.array()
#     picked_people_tags: -> picked_people_tags.array()
#     picked_emotion: -> picked_emotion.array()
#     picked_timestamp_tags: -> picked_timestamp_tags.array()
#     counter: -> Counts.get 'counter'
#     emotion_avg: -> results.findOne(model:'emotion_avg')

#     one_post: ->
#         Docs.find({
#             model:'post'
#             group:Router.current().params.group
#         }).count() is 1
#     two_posts: ->
#         Docs.find({
#             model:'post'
#             group:Router.current().params.group
#         }).count() is 2

    
#     result_tags: -> results.find(model:'group_tag')
#     time_tags: -> results.find(model:'time_tag')
#     location_tags: -> results.find(model:'location_tag')
#     people_tags: -> results.find(model:'people_tag')
#     emotion_results: -> results.find(model:'emotion')
#     timestamp_tag_results: -> results.find(model:'timestamp_tag')
#     current_group: ->
#         Router.current().params.group
        
# Template.emotion_edit.events
#     'click .up_emotion': ->
#         # console.log Template.parentData()
#         parent = Template.parentData()
#         current = parent["#{@key}_percent"]
#         # console.log parent
#         # console.log current
#         # console.log typeof(current)
#         # console.log "#{@key}_percent"
#         unless current is NaN
#             # updated_percent = parseFloat(parent["#{@key}_percent"],2)
#             updated_percent = parent["#{@key}_percent"]
#             # console.log updated_percent+.1
#             if updated_percent > 1
#                 Docs.update Template.parentData()._id,
#                     $set:
#                         "#{@key}_percent":1
#             else
#                 Docs.update Template.parentData()._id,
#                     $set:
#                         "#{@key}_percent":updated_percent+.01
#         else
#             Docs.update parent._id,
#                 $set:
#                     "#{@key}_percent":0
#     'click .down_emotion': ->
#         # console.log @key
#         parent = Template.parentData()
#         # console.log parent
#         # updated_percent = parseInt(parent["#{@key}_percent"])
#         updated_percent = parent["#{@key}_percent"]
#         # console.log updated_percent
#         Docs.update Template.parentData()._id,
#             $set:
#                 "#{@key}_percent":updated_percent-.01
        
# Template.home.events
#     'click .ticker': ->
#         if Session.equals('ticker_view','small')
#             Session.set('ticker_view', 'med')
#         else if Session.equals('ticker_view','med')
#             Session.set('ticker_view', 'large')
#         else if Session.equals('ticker_view','large')
#             Session.set('ticker_view', 'small')
            
#     'click .set_sort_points': -> Session.set('sort_key', 'points')
#     'click .set_sort_timestamp': -> Session.set('sort_key', '_timestamp')
#     'click .set_sort_views': -> Session.set('sort_key', 'views')
#     # 'click .unselect_group_tag': -> 
#     #     Session.set('skip',0)
#     #     # console.log @
#     #     picked_tags.remove @valueOf()
#     #     # window.speechSynthesis.speak new SpeechSynthesisUtterance picked_tags.array().toString()

#     # 'click .select_tag': -> 
#     #     # results.update
#     #     # console.log @
#     #     # window.speechSynthesis.cancel()
#     #     window.speechSynthesis.speak new SpeechSynthesisUtterance @name
#     #     # if @model is 'group_emotion'
#     #     #     selected_emotions.push @name
#     #     # else
#     #     # if @model is 'group_tag'
#     #     picked_tags.push @name
#     #     $('.search_group_tag').val('')
#     #     Session.set('skip_value',0)

#     'click .unpick_time_tag': ->
#         picked_time_tags.remove @valueOf()
#     'click .pick_time_tag': ->
#         picked_time_tags.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
        

#     'click .unselect_time_tag': ->
#         picked_time_tags.remove @valueOf()
#     'click .select_time_tag': ->
#         picked_time_tags.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
        
#     'click .unpick_emotion': ->
#         picked_emotion.remove @valueOf()
#     'click .pick_emotion': ->
#         picked_emotion.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
        

#     'click .unpick_people_tag': ->
#         picked_people_tags.remove @valueOf()
#     'click .pick_people_tag': ->
#         picked_people_tags.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
        

#     'click .unpick_timestamp_tag': ->
#         picked_timestamp_tags.remove @valueOf()
#     'click .pick_timestamp_tag': ->
#         picked_timestamp_tags.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
        
#     'click .unpick_location_tag': ->
#         picked_location_tags.remove @valueOf()
#     'click .pick_location_tag': ->
#         picked_location_tags.push @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name

#     'click .add_post': ->
#         new_id = 
#             Docs.insert 
#                 model:'post'
#                 group:Router.current().params.group
#         Router.go "/#{Router.current().params.group}/p/#{new_id}/edit"
#     'keyup .search_group_tag': (e,t)->
#          if e.which is 13
#             val = t.$('.search_group_tag').val().trim().toLowerCase()
#             # window.speechSynthesis.speak new SpeechSynthesisUtterance val
#             picked_tags.push val   
#             t.$('.search_group_tag').val('')
        
        
        
        
# Template.tag_selector.onCreated ->
#     @autorun => Meteor.subscribe('doc_by_title', @data.name.toLowerCase())
# Template.tag_selector.helpers
#     selector_class: ()->
#         term = 
#             Docs.findOne 
#                 title:@name.toLowerCase()
#         if term
#             if term.max_emotion_name
#                 switch term.max_emotion_name
#                     when 'joy' then " basic green"
#                     when "anger" then " basic red"
#                     when "sadness" then " basic blue"
#                     when "disgust" then " basic orange"
#                     when "fear" then " basic grey"
#                     else "basic grey"
#     term: ->
#         res = 
#             Docs.findOne 
#                 title:@name.toLowerCase()
#         if res and res.metadata
#             # console.log res.metadata.image
#             res
            
# Template.tag_selector.events
#     'click .select_tag': -> 
#         # results.update
#         # console.log @
#         # window.speechSynthesis.cancel()
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
#         # if @model is 'group_emotion'
#         #     selected_emotions.push @name
#         # else
#         # if @model is 'group_tag'
#         picked_tags.push @name
#         $('.search_group_tag').val('')
#         Session.set('skip_value',0)

#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @name
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance picked_tags.array().toString()
#         # Session.set('group_loading',true)
#         # Meteor.call 'search_group', @name, ->
#         #     Session.set('group_loading',false)
#         # Meteor.setTimeout( ->
#         #     Session.set('toggle',!Session.get('toggle'))
#         # , 5000)
        
        
        

# Template.unselect_tag.onCreated ->
#     @autorun => Meteor.subscribe('doc_by_title_small', @data.toLowerCase())
    
# Template.unselect_tag.helpers
#     term: ->
#         found = 
#             Docs.findOne 
#                 # model:'wikipedia'
#                 title:@valueOf().toLowerCase()
#         found
# Template.unselect_tag.events
#     'click .unselect_tag': -> 
#         Session.set('skip',0)
#         # console.log @
#         picked_tags.remove @valueOf()
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance picked_tags.array().toString()
    

# Template.flat_tag_selector.onCreated ->
#     # @autorun => Meteor.subscribe('doc_by_title_small', @data.valueOf().toLowerCase())
# Template.flat_tag_selector.helpers
#     selector_class: ()->
#         term = 
#             Docs.findOne 
#                 title:@valueOf().toLowerCase()
#         if term
#             if term.max_emotion_name
#                 switch term.max_emotion_name
#                     when 'joy' then " basic green"
#                     when "anger" then " basic red"
#                     when "sadness" then " basic blue"
#                     when "disgust" then " basic orange"
#                     when "fear" then " basic grey"
#                     else "basic grey"
#     term: ->
#         Docs.findOne 
#             title:@valueOf().toLowerCase()
# Template.flat_tag_selector.events
#     'click .select_flat_tag': -> 
#         # results.update
#         # window.speechSynthesis.cancel()
#         # window.speechSynthesis.speak new SpeechSynthesisUtterance @valueOf()
#         picked_tags.push @valueOf()
#         $('.search_group').val('')




# Router.route '/:group/p/:doc_id/edit', (->
#     @layout 'layout'
#     @render 'post_edit'
#     ), name:'post_edit'
# Router.route '/:group/p/:doc_id', (->
#     @layout 'layout'
#     @render 'post_view'
#     ), name:'post_view'

# Template.post_edit.onCreated ->
#     @autorun => Meteor.subscribe 'doc', Router.current().params.doc_id
# Template.post_view.onCreated ->
#     @autorun => Meteor.subscribe 'doc', Router.current().params.doc_id
#     @autorun => Meteor.subscribe 'comments', Router.current().params.doc_id

# Template.post_view.onRendered ->
#     Meteor.call 'log_view', Router.current().params.doc_id, ->
# # Router.route '/posts', (->
# #     @layout 'layout'
# #     @render 'posts'
# #     ), name:'posts'

# Template.post_edit.events
#     'click .delete_post': ->
#         if confirm 'delete?'
#             Docs.remove @_id
#             Router.go "/"

#     'click .publish': ->
#         if confirm 'publish post?'
#             Meteor.call 'publish_post', @_id, =>
