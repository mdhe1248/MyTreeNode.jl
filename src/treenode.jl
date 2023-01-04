using AbstractTrees

"""
TreeNode
"""
struct TreeNode
  val::Int
	children::Vector{TreeNode}
  TreeNode(val::Int, children::Vector{TreeNode}=TreeNode[]) = new(val, children)
end

AbstractTrees.children(t::TreeNode) = t.children
AbstractTrees.nodevalue(t::TreeNode) = t.val


"""
Merge two trees
"""
function mergetree(a, b)
  if a.val == b.val
		c = vcat(a.children, b.children)
	else
		error("For merge, `val`s have to macth")
	end
	return(TreeNode(a.val, c))
end

"""
Merge tree `b` into tree `a`
"""
function mergetree!(a, b)
  if a.val == b.val
		push!(a.children, b.children...)
	else
		error("For merge, `val`s have to macth")
	end
	return(a)
end

function _mergetree(a, b) #Not used
  trees_a = collect(PreOrderDFS(a))
	trees_b = collect(PreOrderDFS(b))
  t = 0
  for t_a in trees_a, t_b in trees_b
	  if isequal(t_a.val, t_b.val)
	    t = mergetree(t_a, t_b)
    end
	end
  return(t)  
end

"""
Append tree `b` into tree `a`.
"""
function appendtree!(a, b)
	trees = collect(PreOrderDFS(a))
  for tree in trees
  	if tree.val == b.val
    	mergetree!(tree,b)
  	end
	end
  return(trees)
end

"""
IDTree

Modified from "https://github.com/JuliaCollections/AbstractTrees.jl/blob/master/test/examples/idtree.jl"
Each node has a unique ID, making them easy to reference. Node children are ordered.
Node type only implements `children`, so serves to test default implementations of most functions.
"""
struct IDTree
    nodes::Dict{Int,TreeNode}
    root::TreeNode
end

"""
Modified from "https://github.com/JuliaCollections/AbstractTrees.jl/blob/master/test/examples/idtree.jl"
Given a tree root, add an ID (Dictionary key) to every node.
Leaf nodes may be represented by ID only.
"""
function IDTree(root)
    nodes = Dict{Int, TreeNode}()
    for node in PreOrderDFS(root)
        haskey(nodes, node.val) && error("Duplicate node ID $(node.val)")
        nodes[node.val] = node
    end
    return IDTree(nodes, root)
end



#### IDTree
##struct IDTreeNode
##    id::Int
##    children::Vector{IDTreeNode}
##
##    IDTreeNode(id::Integer, children::Vector{IDTreeNode}=IDTreeNode[]) = new(id, children)
##end
##
##AbstractTrees.children(node::IDTreeNode) = node.children
##AbstractTrees.printnode(io::IO, node::IDTreeNode) = print(io, "#", node.id)
##
##"""
##    IDTree
##Basic tree type used for testing.
##Each node has a unique ID, making them easy to reference. Node children are ordered.
##Node type only implements `children`, so serves to test default implementations of most functions.
##"""
##struct IDTree
##    nodes::Dict{Int,IDTreeNode}
##    root::IDTreeNode
##end
##
##_make_idtreenode(id::Integer) = IDTreeNode(id)
##_make_idtreenode((id, children)::Pair{<:Integer, <:Any}) = IDTreeNode(id, _make_idtreenode.(children))
##
##"""
##    IDTree(x)
##Create from nested `id => children` pairs. Leaf nodes may be represented by ID only.
##"""
##function IDTree(x)
##    root = _make_idtreenode(x)
##    nodes = Dict{Int, IDTreeNode}()
##
##    for node in PreOrderDFS(root)
##        haskey(nodes, node.id) && error("Duplicate node ID $(node.id)")
##        nodes[node.id] = node
##    end
##
##    return IDTree(nodes, root)
##end

#tree = IDTree(1 => [
#        2 => [
#            3,
#            4 => [5],
#        ],
#        6,
#        7 => [
#            8 => [
#                9,
#                10,
#                11 => 12:14,
#                15,
#            ],
#        ],
#        16,
#    ])
#
#nodes = [tree.nodes[id] for id in 1:16]
#treesize.(nodes)    == [16, 4, 1, 2, 1, 1, 9, 8, 1, 1, 4, 1, 1, 1, 1, 1]
#treebreadth.(nodes) == [10, 2, 1, 1, 1, 1, 6, 6, 1, 1, 3, 1, 1, 1, 1, 1]
#treeheight.(nodes)  == [ 4, 2, 0, 1, 0, 0, 3, 2, 0, 0, 1, 0, 0, 0, 0, 0]

### Make tree of brain annotaion
##/997/
##/997/8/
##/997/8/567/
##/997/8/567/688/
##/997/8/567/688/695/
##/997/8/567/688/695/315/
### Build tree structure.
#
#a = Pair(997, [Pair(8, [Pair(567, [Pair(688, [Pair(695, [315])])])])])
#a = Pair(997, [Pair(8, [Pair(567, [Pair(688,[])])])])
#b = Pair(688, Pair(695,[]))
#IDTreeNode(b)
#
#t = IDTree(a)
#
#a = IDTreeNode(1, IDTreeNode[IDTreeNode(2, IDTreeNode[])])
#t = [[1,2], [3,4]]
#treesize(t)
#
#
#mutable struct Node{T}
#    data    ::T
#    parent  ::Node{T}
#    children::Vector{Node{T}}
#
#    Node(data::T) where T = new{T}(data)
#
#    function Node(data::T, p) where T
#        n = new{T}(data, p)
#        isdefined(p, :children) ? push!(p.children, n) : p.children = [n]
#        return n
#    end
#end
#
#


