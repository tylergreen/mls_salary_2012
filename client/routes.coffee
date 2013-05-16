Meteor.Router.add({
  '' : 'home'
  '/horizontal' : 'horizontal_bar_chart',
  '/vertical' : 'vertical_bar_chart',
  '/bubble' : 'bubble_chart',
  '/team_bubble' : 'team_bubble_chart',
  '*' : 'not_found'
  }
)
