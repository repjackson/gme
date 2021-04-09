# if Meteor.isClient
#     # Router.route '/', (->
#     #     @layout 'layout'
#     #     @render 'home'
#     #     ), name:'home'

#     # Template.finance_bar.onRendered ->
#     #     Meteor.setTimeout ->
#     #         finance_stat = Docs.findOne model:'finance_stat'
#     #         if finance_stat
#     #             percent = 20000/finance_stat.total_expense_sum
#     #             console.log percent
#     #             $('.progress').progress({
#     #                   percent: percent
#     #             });
#     #     , 2000
    
#     Template.home.onCreated ->
#         # @autorun => Meteor.subscribe 'articles', ->
#         # @autorun -> Meteor.subscribe('home_tag_results',
#         #     selected_tags.array()
#         #     selected_location_tags.array()
#         #     selected_authors.array()
#         #     Session.get('view_purchased')
#         #     # Session.get('view_incomplete')
#         #     )
#         # @autorun -> Meteor.subscribe('home_results',
#         #     selected_tags.array()
#         #     selected_location_tags.array()
#         #     selected_authors.array()
#         #     Session.get('view_purchased')
#         #     # Session.get('view_incomplete')
#         #     )
#         # @autorun => Meteor.subscribe 'model_docs', 'home_doc'

#     Template.home.helpers
#         articles: ->
#             Docs.find
#                 model:'post'
#                 group:'gme'
                
    
#     Template.home.events
#         'keydown .find_username': (e,t)->
#             # email = $('submit_email').val()
#             if e.which is 13
#                 email = $('.submit_email').val()
#                 if email.length > 0
#                     Docs.insert
#                         model:'email_signup'
#                         email_address:email
#                     $('body')
#                       .toast({
#                         class: 'success'
#                         position: 'top right'
#                         message: "#{email} added to list"
#                       })
#                     $('.submit_email').val('')