if Meteor.isClient
    Router.route '/', (->
        @redirect('/r/Superstonk')
    )

    # Router.route '/', (->
    #     @layout 'layout'
    #     @render 'home'
    #     ), name:'home'


Router.configure
    layoutTemplate: 'layout'
    notFoundTemplate: 'not_found'
    loadingTemplate: 'splash'
    trackPageView: false

Router.route '/chart', (->
    @layout 'layout'
    @render 'ticker'
    ), name:'chart'
Router.route '/profile', (->
    @layout 'layout'
    @render 'profile'
    ), name:'profile'
Router.route '/floor', (->
    @layout 'layout'
    @render 'floor'
    ), name:'floor'
Router.route '/fun', (->
    @layout 'layout'
    @render 'fun'
    ), name:'fun'

# Router.onBeforeAction(force_loggedin, {
#     # only: ['admin']
#     except: [
#         'register'
#         'login'
#         'verify-email'
#         'forgot_password'
#         'event_view'
#         'delta'
#     ]
#     })


Router.route '*', -> @render 'not_found'

# Router.route '/user/:username/m/:type', -> @render 'profile_layout', 'user_section'

Router.route '/techanal/', (->
    @render 'techanal'
    ), name:'techanal'
Router.route '/timeline/', (->
    @render 'timeline'
    ), name:'timeline'
