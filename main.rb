require 'set'

$matrix = []
$memo = {}
$startIdx = 0

def tsp(i, s)
  if s.empty?
    return $matrix[i][$startIdx] 
  end

  minCost = Float::INFINITY
  minIdx = -1

  s.each do |j|
    scopy = s.dup
    scopy.delete(j)
    cost = $matrix[i][j] + tsp(j, scopy)
    if cost < minCost
      minCost = cost
      minIdx = j
    end
  end

  $memo[[i, s]] = [minIdx, minCost]
  return minCost
end

def get_path
  res = [$startIdx]
  s = Set.new(0...$matrix.length) - [$startIdx]
  current = $startIdx
  minCost = tsp($startIdx, s)

  while !s.empty?
    key = [current, s]
    next_city, _ = $memo[key]
    res << next_city
    s.delete(next_city)
    current = next_city
  end

  return res, minCost
end

# MAIN PROGRAM

puts "Travelling Salesman Problem Solver using Dynamic Programming"
puts "Input number of city (N): "

n = gets.to_i
puts "Enter the adjacency matrix (each row on a new line):"
n.times do
    row = gets.split.map(&:to_i)
    $matrix << row
end

puts "Your adjacent matrix: "
$matrix.each { |row| puts row.join(" ") }

path, cost = get_path

puts "Minimum cost: #{cost}"
puts "Optimal path: #{path.join(' -> ')} -> #{$startIdx}"