team_salaries = (salaries) ->

 teams = _.groupBy(player_salaries_2012, (d) -> d.team)
 console.log(teams)
 _.pairs(teams).map(([k,v]) -> {name: k, value: v.map((x) -> x.base_salary).reduce((x,y) -> x + y), children: v})


Template.team_bubble_chart.rendered = ->

  mls_data =
      name: 'MLS'
      base_salary: 0
      children: team_salaries(player_salaries_2012)

  height = 1000
  width = 1000

  unsorted_bubble = ->
    d3.layout.pack()
      .value( (d) -> d.base_salary / 50000)
      .size([width , height ])
      .padding(0.5)
      .sort(null)

  sorted_bubble = ->
    d3.layout.pack()
      .value( (d) -> d.base_salary / 50000)
      .size([width , height ])
      .padding(0.5)
      .sort(d3.ascending)

  svg = d3.select('.chart_area').append('svg')
      .attr('width', width)
      .attr('height', height)

  on_button = svg.append('rect')
    .attr('x', 60)
    .attr('y', 60)
    .attr('width', 60)
    .attr('height', 60)
    .style('fill', 'blue')

  off_button = svg.append('rect')
    .attr('x', 0)
    .attr('y', 60)
    .attr('width', 60)
    .attr('height', 60)
    .style('fill', 'green')

  on_button.on('click', -> sort_bubbles(true))
  off_button.on('click', -> sort_bubbles(false))

  bubble = unsorted_bubble()

  node_pack = bubble.nodes(mls_data)

  node = svg.selectAll('.node')
      .data(node_pack)
      .enter()
      .append('g')
      .attr('class', 'node')
      .attr('transform', (d) -> "translate(#{d.x }, #{d.y})")

  node.append('text')
    .text((d) -> if d.name == 'MLS' then '' else d.name)
    .attr('font-size', (d) -> "#{d3.max([d.value / 4, 5])}px")

  node.append('circle')
      .attr('r', (d) -> d.r)
      .style('fill', 'blue')
      .attr('opacity', 0.5)

  node
      .on('mouseover', ->
        d3.select(@).style('fill', 'yellow')
          .select('circle').style('fill', 'dark-blue'))

      .on('mouseout', ->
        d3.select(@).style('fill', 'black')
          .select('circle').style('fill', 'blue'))

  sort_bubbles = (sortp) ->
    if sortp
      bubble = unsorted_bubble()
    else
      bubble = sorted_bubble()

    node_pack = bubble.nodes(mls_data) # recompute nodes

    svg = d3.select('.chart_area').select('svg')

    node = svg.selectAll('.node')
      .data(node_pack)
      .transition()
      .attr('transform', (d) -> "translate(#{d.x }, #{d.y})")
