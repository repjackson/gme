@selected_authors = new ReactiveArray []
@selected_location_tags = new ReactiveArray []
@picked_tags = new ReactiveArray []
@picked_domains = new ReactiveArray []
@picked_authors = new ReactiveArray []


# Router.configure
	# progressDelay : 100

Template.body.events
    'click a:not(.select_term)': ->
        $('.global_container')
        .transition('fade out', 250)
        .transition('fade in', 250)
