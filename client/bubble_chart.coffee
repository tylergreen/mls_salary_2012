Template.bubble_chart.rendered = ->
  d3.selectAll('svg').remove()

  data =
      name: ''
      value: 10
      children: player_salaries_2012

  height = 1000
  width = 2000

  bubble = d3.layout.pack()
    .value( (d) -> d.base_salary / 50000)
    .sort(null)
    .size([width, height])
    .padding(0.5)

  svg = d3.select('body').append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
      .attr('transform', 'translate(-500,-50)')

  nodes = bubble.nodes(data)
  console.log(nodes)

  node = svg.selectAll('.node')
    .data(nodes)
    .enter()
    .append('g')
    .attr('class', 'node')
    .attr('transform', (d) -> "translate(#{d.x }, #{d.y})")

  console.log(bubble.nodes(data))

  node.append('g')
    .attr('transform', 'translate(-50, 0)')
    .append('text')
    .text((d) -> d.name)
    .attr('font-size', (d) -> "#{d.value / 4 }px")

  node.append('circle')
    .attr('r', (d) -> d.value)
    .style('fill', 'blue')
    .attr('opacity', 0.5)
