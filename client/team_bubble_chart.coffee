team_salaries = (salaries) ->
 teams = _.groupBy(player_salaries_2012, (d) -> d.team)
 console.log(teams)
 _.pairs(teams).map(([k,v]) -> {name: k, value: v.map((x) -> x.base_salary).reduce((x,y) -> x + y), children: v})


Template.team_bubble_chart.rendered = ->
  d3.selectAll('svg').remove()

  data =
      name: 'MLS'
      base_salary: 0
      children: team_salaries(player_salaries_2012)

  height = 1000
  width = 1200

  bubble = d3.layout.pack()
    .value( (d) -> d.base_salary / 50000)
    .size([width , height ])
    .padding(0.5)
    .sort(null)

  svg = d3.select('body').append('svg')
    .attr('width', width)
    .attr('height', height)
    #.append('g')
      #.attr('transform', 'translate(-500,-50)')

  nodes = bubble.nodes(data)

  node = svg.selectAll('.node')
    .data(nodes)
    .enter()
    .append('g')
    .attr('class', 'node')
    .attr('transform', (d) -> "translate(#{d.x }, #{d.y})")

  node.append('g')
    .attr('transform', 'translate(-50, 0)')
    .append('text')
    .text((d) -> if d.name == 'MLS' then '' else d.name)
    .attr('font-size', (d) -> "#{d3.max([d.value / 4, 5])}px")

  node.append('circle')
    .attr('r', (d) -> d.r)
    .style('fill', 'blue')
    .attr('opacity', 0.5)
