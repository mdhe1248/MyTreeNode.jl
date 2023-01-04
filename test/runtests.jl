using MyTreeNode
using Test

@testset "MyTreeNode.jl" begin
## Test: merge
a = TreeNode(1, [TreeNode(2)])
b = TreeNode(1, [TreeNode(3, [TreeNode(4)])])
t = mergetree(a, b)
print_tree(a)
print_tree(b)
print_tree(t)

mergetree!(a, b)
print_tree(a)

## Test: append
using Test
a = TreeNode(1, [TreeNode(2), TreeNode(3)])
b = TreeNode(2, [TreeNode(4)])
print_tree(a)
print_tree(b)
appendtree!(a, b)
print_tree(a)

a = TreeNode(1, [TreeNode(2), TreeNode(3, [TreeNode(4), TreeNode(5)])])
b = TreeNode(3, [TreeNode(6), TreeNode(7)])
print_tree(a)
print_tree(b)
appendtree!(a, b)
print_tree(a)

a = TreeNode(1, [TreeNode(2), TreeNode(3, [TreeNode(4), TreeNode(5)])])
b = TreeNode(5, [TreeNode(6)])
print_tree(a)
print_tree(b)
appendtree!(a, b)
print_tree(a)

a = TreeNode(1, [TreeNode(2), TreeNode(3, [TreeNode(4), TreeNode(5)])])
b = TreeNode(1, [TreeNode(6), TreeNode(7)])
print_tree(a)
print_tree(b)
appendtree!(a, b)
print_tree(a)

end
