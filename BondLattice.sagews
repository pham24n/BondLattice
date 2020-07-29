︠294e85d9-4f2b-4890-9bf3-601446611312︠
#Resources: http://sheaves.github.io/Partitions-and-Posets/?fbclid=IwAR1qSC68BwATlr1oqOVyMB6gyensrXy65HZNl_IjWZ_IKwx8Hqpw17A5kpU

#number of vertices in the graph
#modify this
N = 4

#modify the adjacency list for your graph
adjacency_list = {
    1: set([2,4]),
    2: set([1,3]),
    3: set([2,4]),
    4: set([1,3]),
}

#generate all set partitions
def Partition_Poset(X):
    return Poset((SetPartitions(X),lambda q,p: q in p.refinements()))

#change the design of the Hasse diagram
def p_label(p):
    out = ""
    for block in p:
        for elm in block:
            out += str(elm)
        out += "|"
    return out[:-1]

#check if the set partition is valid (non-crossing and all the elements in the blocks are connected)
def is_valid(set_partition):
    #return true if all the blocks have one element
    if are_all_blocks_len_1(set_partition):
        return true
    else:
        #check if the set partition is non-crossing
        if set_partition.is_noncrossing():
            #loop through all the blocks to check if all the elements are connected
            for el in set_partition:
                if len(el) == 1:
                    continue
                el_ls = list(el)
                if not is_connected(el_ls):
                    return false
            return true
        return false

#check if a set partition is crossing
def is_crossing(set_partition):
    if not set_partition.is_noncrossing():
        return true
    return false

#check if all blocks are of length 1
def are_all_blocks_len_1(set_partition):
    for el in set_partition:
        if not len(el) == 1:
            return false
    return true

#check if all the elements in el_ls are connected
#the algorithm is based on Depth First Search algorithm
def is_connected(el_ls, encountered = None):
    if encountered is None:
        encountered = set()
        encountered.add(el_ls[0])
        return is_connected(el_ls[1:], encountered)
    if (len(el_ls) == 0):
        return true
    for el in encountered:
        for x in range(len(el_ls)):
            if el_ls[x] in adjacency_list.get(el):
                encountered.add(el_ls[x])
                return is_connected(el_ls[:x]+el_ls[x+1:], encountered)
    return false

# test for is_connected
# element_ls = {1,2,4}
# element_ls = list(element_ls)
# print(is_connected(element_ls))


#generate bond lattice
def bond_lattice():
    Po = Partition_Poset(N) #generate all set partitions
    Po_ls = list(Po) #create a list of Po because it is easier to work with list
    new_Po_ls = [] #a list containing only the valid set partitions (all the set partitions of the bond lattice)

    #loop through all the set partitions, add it to new_Po_ls if the set partition is valid
    for set_partition in Po_ls:
        if is_valid(set_partition):
#             print(set_partition)
            new_Po_ls.append(set_partition)
    
    new_poset = Po.subposet(new_Po_ls)

    return new_poset
    

def get_parking_functions(poset):
    maximalChains = poset.maximal_chains() #get a list of all the maximal chains in the bond lattice


    for max_chain in maximalChains:
        label = []
        for i in range(len(max_chain)-1):
            is_covered = max_chain[i]
            cover = max_chain[i+1]
            merging_blocks = []

            for el in is_covered:
                if not el in cover:
                    merging_blocks.append(el)

            label.append(get_label(merging_blocks[0], merging_blocks[1]))
        print("parking function is ", label)
    

# get a list of set partitions of the bond lattice
# for set_partition in Po_ls:
#     if is_valid(set_partition):
#         print(set_partition)
#         new_Po_ls.append(set_partition)

# get all the crossing elements
# set_partition_test = SetPartition([[1], [2, 4, 5, 6], [3], [7]])
# print(is_crossing(set_partition_test))





def get_label(block1, block2):
    min_el = max(min(block1), min(block2))
    max_block = block2 if min_el in block1 else block1
    max_block = list(max_block)
    max_block.sort(reverse = True)
    for i in max_block:
        if i < min_el:
            return i


poset = bond_lattice()

#get all the parking functions of the bond lattice
get_parking_functions(poset)

#draw a Hasse diagram of the bond lattice
poset.plot(element_labels = {x:p_label(x) for x in poset},vertex_size=1270,vertex_shape=None)



︡dc46d058-f273-4005-b972-bf1ed64a148f︡{"done":true}
︠f96a4eca-0b0a-4367-92c0-fcd59423fade︠

︡94b5f62e-c168-4bfd-b2ae-989c4bcdd52b︡
︠211fc5f4-e222-4b89-8886-589bf78f736d︠

︡08b313ee-9713-4566-a0e2-948845513628︡
︠bf030880-d5aa-40ad-b17d-f3753d2f28dc︠

︡7d3f7c3e-56dd-4b5b-8c46-b0c95a05d901︡
︠725ea8b9-2078-43e2-9385-1791283dc872︠

︡5cd4088f-d94b-4e23-9190-534f743b5a17︡
︠5cb6b9b0-6512-4a55-80a1-9dfa867e42b0︠

︡cafabb14-bfd3-448b-9706-7a6f89909f5f︡{"done":true}









