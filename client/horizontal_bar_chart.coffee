Template.horizontal_bar_chart.rendered = ->

  d3.selectAll('svg').remove()
  data = _.sortBy(player_salaries_2012, (d) -> d.base_salary).reverse()
  margin = {top: 0, right: 100, bottom: 50, left: 100}
  width = 1000 - margin.left - margin.right
  height = 5000 - margin.top - margin.bottom

  y = d3.scale.ordinal()
    .rangeBands([0, height], 0.1)
    #.rangeRoundBands([0, width], 0.1)

  x = d3.scale.linear()
    .range([0, width])

  xAxis = d3.svg.axis()
    .scale(x)
    .ticks(4)
    .orient('top')

  yAxis = d3.svg.axis()
    .scale(y)
    .orient('left')

  svg = d3.select('body').append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', "translate(#{ margin.left} , #{margin.bottom} )")

  x.domain([0, d3.max(data, (d) -> d.base_salary) ])
  y.domain(data.map( (d) -> d.name))

  #svg.append('g')
  #  .attr('class', 'x axis')
  #  .call(xAxis)

  svg.append('g')
      .attr('class', 'y_axis')
      .call(yAxis)

  svg.selectAll('.bar')
    .data(data)
    .enter().append('rect')
    .attr('class', 'bar')
    .attr('y', (d) -> y(d.name))
    .attr('height', y.rangeBand())
    .attr('x', 0)
    .attr('width', (d) -> x(d.base_salary))

  console.log('y')
  console.log(y.rangeBand())

  svg.selectAll('.salary_label')
    .data(data)
    .enter()
    .append('text')
      .attr('x', (d) -> x(d.base_salary) + 10) # improve
      .attr('y', (d) -> y(d.name) + 5) # improve
      .attr('font-size', "#{y.rangeBand() - 1}px") # improve
      .text((d) -> "$#{d.base_salary}")

  svg.selectAll('.tick')
    .attr('font-size',  "#{y.rangeBand()}px")
