Template.salaries.rendered = ->

  data = _.sortBy(player_salaries_2012, (d) -> d.base_salary).reverse()
  margin = {top: 100, right: 100, bottom: 50, left: 300}
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

  svg = d3.select('body').select('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', "translate(#{ margin.left} , #{margin.bottom} )")

  x.domain([0, d3.max(data, (d) -> d.base_salary) ])
  y.domain(data.map( (d) -> d.last_name) )

  svg.append('g')
    .attr('class', 'x axis')
    .call(xAxis)

  svg.append('g')
      .attr('class', 'y_axis')
      .call(yAxis)
    .append("text")
      .attr('y', 6)
      .attr('dy', '.25em')
      .attr('transform', "translate(0, -50 )")
      .text("Base Salary in $")

  svg.selectAll('.bar')
    .data(data)
    .enter().append('rect')
    .attr('class', 'bar')
    .attr('y', (d) -> y(d.last_name))
    .attr('height', y.rangeBand())
    .attr('x', 0)
    .attr('width', (d) -> x(d.base_salary))
