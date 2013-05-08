Template.hello.greeting = () ->
  "salary #{player_salaries_2012[0].team}"

margin = {top: 20, right: 20, bottom: 30, left: 40}
width = 960 - margin.left - margin.right
height = 500 - margin.top - margin.bottom
x = d3.scale.linear().range([0, width])
y = d3.scale.ordinal().rangeRoundBands([0, height], 0.1)

xAxis = d3.svg.axis().scale(x).orient('top')
yAxis = d3.svg.axis().scale(y).orient('left')

svg = d3.select('body').append('svg')
  .attr('width', width + margin.left + margin.right)
  .attr('height', height + margin.top + margin.bottom)

svg.append('g')
  .attr('transform', "translate(#{ margin.left} , #{margin.top} )")

x.domain([0, d3.max(player_salaries_2012, (d) -> d.base_salary) ])
y.domain(player_salaries_2012.map( (d) -> d.last_name) )

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
  .attr('dy', '71.em')
  .text("Some text!")

svg.selectAll('.bar')
  .data(player_salaries_2012)
  .enter().append('rect')
  .attr('class', 'bar')
  .attr('x', 0)
  .attr('width', (d) -> x(d.base_salary))
  .attr('y', (d) -> y(d.last_name))
  .attr('height', y.rangeBand())
