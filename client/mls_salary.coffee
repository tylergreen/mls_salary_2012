Template.salaries.rendered = ->

  margin = {top: 50, right: 50, bottom: 50, left: 130}
  width = 960 - margin.left - margin.right
  height = 500 - margin.top - margin.bottom

  x = d3.scale.ordinal()
    .rangeRoundBands([0, width], 0.1)

  y = d3.scale.linear()
    .range([height, 0])

  xAxis = d3.svg.axis()
    .scale(x)
    .orient('bottom')

  yAxis = d3.svg.axis()
    .scale(y)
    .orient('left')

  svg = d3.select('body').select('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', "translate(#{ margin.left} , #{margin.top} )")

  x.domain(player_salaries_2012.map( (d) -> d.last_name) )
  y.domain([0, d3.max(player_salaries_2012, (d) -> d.base_salary) ])

  svg.append('g')
    .attr('class', 'x axis')
    .attr('transform', "translate(0, #{height})")
    .call(xAxis)

  svg.append('g')
      .attr('class', 'y axis')
      .call(yAxis)
    .append("text")
      .attr('transform', 'rotate(-90)')
      .attr('y', 6)
      .attr('dy', '.71em')
      .text("Some text!")

  svg.selectAll('.bar')
    .data(player_salaries_2012)
    .enter().append('rect')
    .attr('class', 'bar')
    .attr('x', (d) -> x(d.first_name))
    .attr('width', x.rangeBand())
    .attr('y', (d) -> y(d.base_salary))
    .attr('height', (d) -> height - y(d.base_salary))
