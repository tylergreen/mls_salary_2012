Template.vertical_bar_chart.rendered = ->

  d3.selectAll('svg').remove()
  margin = {top: 50, right: 100, bottom: 50, left: 100}
  width = 1000 - margin.left - margin.right
  height = 300 - margin.top - margin.bottom

  x = d3.scale.ordinal()
    .rangeBands([0, width], 0.1)

  y = d3.scale.linear()
    .range([height, 0])

  xAxis = d3.svg.axis()
    .scale(x)
    .orient('bottom')
    .tickFormat((d) -> '')

  yAxis = d3.svg.axis()
    .scale(y)
    .orient('left')

  svg = d3.select('body').append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', "translate(#{ margin.left} , #{margin.top} )")

  x.domain(player_salaries_2012.map( (d) -> d.name) )
  y.domain([0, d3.max(player_salaries_2012, (d) -> d.base_salary) ])

  svg.append('g')
    .attr('class', 'x axis')
    .attr('transform', "translate(0, #{height})")
    .call(xAxis)

  svg.append('g')
      .attr('class', 'y axis')
      .call(yAxis)
    .append("text")
      .attr('transform', 'rotate(-90) translate(-157)')
      .attr('y', 6)
      .attr('dy', '.71em')
      .text("Base Salary in $")

  svg.selectAll('.bar')
    .data(player_salaries_2012)
    .enter().append('rect')
    .attr('class', 'bar')
    .attr('x', (d) -> x(d.name))
    .attr('width', x.rangeBand())
    .attr('y', (d) -> y(d.base_salary))
    .attr('height', (d) -> height - y(d.base_salary))
    .attr('info', (d) -> "#{d.name} $#{d3.format(',')(d.base_salary)}")

  player_info = svg.append('text')
    .attr('class', 'info')
    .attr('x',20)
    .attr('y',0)
    .text('')

  svg.selectAll('.bar').on('mouseover', ->
    elem = d3.select(@)
    elem.style('fill', 'orange')
    name = elem.attr('info')
    player_info.text(name)
    player_info.attr('x', elem.attr('x'))
    player_info.attr('y', elem.attr('y'))
    )

  svg.selectAll('.bar').on('mouseout', ->
    d3.select(@).style('fill', 'steelblue')
    player_info.text('')
  )
