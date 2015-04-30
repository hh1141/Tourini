module UnionHack
  def union(relations, opts={})
    query = 'SELECT '+ (opts[:distinct] ? 'DISTINCT ' : '' ) +'* FROM ((' + relations.map { |r| r.ast.to_sql }.join(') UNION (') + ')) AS t'
    query << " ORDER BY #{opts[:order]}" if opts[:order]
    query << " LIMIT #{opts[:limit]}" if opts[:limit]
    find_by_sql(query)
  end
end
