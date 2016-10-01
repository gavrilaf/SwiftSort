# SwiftSort

When I was reading perfect book `Introdution to algorithms` from Tomas Cormen, I decided to implement some algorithms. Just for deeper understanding.

But when I started, I thought that would be interesting to measure Swift performance in some simple situations.

And what I got...

For simple measuring I used `selection sort`, because it's simple and slow. So we don't need million iterations to get difference.

### Function call vs scruct method call vs Generic (struct<Int>) 

Compare performance for direct functions and struct methods using Selection sort
```
Function (best=32.4009656906128, worse=44.3990230560303, mean=35.6753528118134)
Struct (best=32.3600172996521, worse=39.0909910202026, mean=34.1559565067291)
Generic struct (best=32.355010509491, worse=43.2620048522949, mean=33.7225139141083)
```

It's nice, performance is the same.

### Direct sort for Int type vs Generic<Int> using Merge sort

Compare performance for direct Int and generic <Int> calls using Merge sort
```
Direct (best=5.80000877380371, worse=8.75002145767212, mean=6.39630198478699)
Generic (best=5.78796863555908, worse=8.31198692321777, mean=6.11533761024475)
```

### Just comparing sorting algorithms (main part)

Compare different sort algorithms performance
```
Selection (best=32.4990153312683, worse=39.4110083580017, mean=34.7992897033691)
Insertion (best=24.5940089225769, worse=59.0589642524719, mean=29.2738890647888)
Merge (best=5.68801164627075, worse=8.97598266601562, mean=6.41078948974609)
Merge+Insertion (window size = 5) (best=1.81394815444946, worse=3.81600856781006, mean=2.10283637046814)
Merge+Insertion (window size = 10) (best=1.33699178695679, worse=3.09300422668457, mean=1.61289870738983)
Deterministic Quicksort (best=0.956952571868896, worse=1.8649697303772, mean=1.03523969650269)
Random Quicksort (best=1.30802392959595, worse=2.72500514984131, mean=1.43631935119629)
Standard Swift Array.sortInPlace (best=0.387966632843018, worse=1.11401081085205, mean=0.455890297889709)
```

So, results are predictible. Quicksort is fastest algorithm.
'Random quicksort' should be faster on reverse sorted arrays, but on random arrays it shows the very close result. 
A bit difference is caused by random number generator.

And the main point.

Swift is `REALLY` fast. Swift standard library sortInPlace uses UnsafePointer and probably uses low level sorting.

But direct pure Swift implementation works with almost the same speed. It's great!

All tests were running on 
- MacBook Pro 2.7 GHz Intel Core i5 16 GB 1867 MHz DDR3
- XCode Version 7.3.1
- Swift 2.2

### Remark 
Generics works fast only when `Whole module optimization` option is turned on. In other cases generics works extremly slow.

### UPDATES
Project updated to Swift 3.0.

New results (comparing sorting algorithms)

```
Selection (best=32.3470234870911, worse=38.7440323829651, mean=34.1400790214539)
Insertion (best=31.9449901580811, worse=39.1849875450134, mean=33.9502185583115)
Merge (best=5.37800788879395, worse=7.59899616241455, mean=5.74513077735901)
Merge+Insertion (window size = 5) (best=1.79803371429443, worse=3.91101837158203, mean=2.08269357681274)
Merge+Insertion (window size = 10) (best=1.42300128936768, worse=2.68799066543579, mean=1.67848110198975)
Deterministic Quicksort (best=1.11699104309082, worse=2.37101316452026, mean=1.20561242103577)
Random Quicksort (best=1.82396173477173, worse=3.36700677871704, mean=1.90734148025513)
Standard Swift Array.sortInPlace (best=0.560998916625977, worse=0.82099437713623, mean=0.602246522903442)
```

Results the same. Swift 2.2 was fast and Swift 3.0 is fast too. But it isn't faster (at least in simple benchmarks)



