# Mathematical [Group Theory](https://en.wikipedia.org/wiki/Group_theory#:~:text=In%20mathematics%20and%20abstract%20algebra,with%20additional%20operations%20and%20axioms.) demonstration apps in R.  

* [Isomorphism between SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub>](https://github.com/apiyarali/GroupTheory-R/blob/master/README.md#isomorphism-between-sl2f4-and-a5)
* [Dihedral Group Enhanced App](https://github.com/apiyarali/GroupTheory-R/blob/master/README.md#dihedral-group-enhanced-app-)
* [Dihedral Group D4 App](https://github.com/apiyarali/GroupTheory-R/blob/master/README.md#dihedral-group-d4-app)
   
## <ins>Isomorphism between SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub></ins>

**Link to Published App: [Isomorphism between SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub>](https://alipiyarali.shinyapps.io/IsoF4/)**

> **Introduction**

>> In this project, we explore the [isomorphism](https://en.wikipedia.org/wiki/Group_isomorphism) between two mathematical groups: SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub>. At first glance, these two groups might seem completely different, but they actually have the same structure! Here's a simple explanation of the connection between them.

> **What is [SL<sub>2</sub>](https://en.wikipedia.org/wiki/SL2(R))[(F<sub>4</sub>)](https://en.wikipedia.org/wiki/F4_(mathematics))?**

>> SL<sub>2</sub>(F<sub>4</sub>) is a group that consists of 2x2 matrices with entries from the field F<sub>4</sub> (a small set of numbers, specifically {0, 1, 2, 3}). The elements of this group follow a special rule: their "determinant" must always be 1. Matrices in SL<sub>2</sub>(F<sub>4</sub>) are combined by multiplying them together.

> **What is [A<sub>5</sub>](https://groupprops.subwiki.org/wiki/Alternating_group:A5)?**

>> A<sub>5</sub> is a group of "even" permutations of five numbers. Imagine you have five numbers, say {1, 2, 3, 4, 5}, and you can rearrange them (swap the numbers around). However, A<sub>5</sub> only allows you to rearrange the numbers in a way that involves an even number of swaps. There are exactly 60 different ways to arrange these five numbers in A<sub>5</sub>.

> **The Isomorphism**

>> Even though SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub> look totally different (one is about matrices, the other is about rearranging numbers), they actually have a one-to-one relationship with each other. This means there is a way to match the elements from SL<sub>2</sub>(F<sub>4</sub>) with the elements of A<sub>5</sub> such that the group operations (like multiplying matrices or swapping numbers) behave in exactly the same way.

>>> **In simpler terms**:

>>> SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub> are like two different puzzles, but they’re secretly the same puzzle. One puzzle is about grids (matrices), and the other is about rearranging numbers.

>>> Both puzzles have 60 possible solutions (elements).

>>> For every move you make in SL<sub>2</sub>(F<sub>4</sub>), there is a matching move in A<sub>5</sub>, and the result is the same.

> **Conclusion**

>> The isomorphism between SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub> shows that even though these two groups seem very different, they are structurally the same. They are just different ways of organizing the same underlying structure, which is why we say they are isomorphic.

## <ins>[Dihedral Group](https://en.wikipedia.org/wiki/Dihedral_group#Elements) D6 Enhanced App </ins>

**Link to Published App: [Dihedral Group D6](https://alipiyarali.shinyapps.io/GroupD6Enhanced/)**

> **Introduction**

>> The Group D6 Enhanced app demonstrates the symmetry group of a regular hexagon, known as the Dihedral Group D6, through the permutations of the numbers 1 through 6. This app provides a powerful visualization tool for understanding group theory concepts, including subgroups, cosets, conjugation, and the generation of subgroups.

> **What is Dihedral Group D6?**

>> Dihedral Group D6 represents the symmetries of a regular hexagon. It includes rotations and reflections that map the hexagon onto itself. The group has 12 elements, corresponding to the 6 rotations and 6 reflections of the hexagon.

>> In this app, the elements of D6 are represented as permutations of the numbers 1 through 6. This allows you to see how each symmetry operation (rotation or reflection) affects the positions of the vertices of the hexagon.

> **Features**

>> 1. Group Elements
>> The app allows you to explore the elements of D6 by clicking on buttons representing these elements under the Elements of Group heading. You can multiply two elements by clicking on them to see the resulting element of the group.

>> 2. Subgroups
>> The app displays all the subgroups of D6, allowing you to see the smaller groups that are contained within D6.

>> 3. Cosets
>> You can explore the cosets of subgroups, which are the "shifts" of the subgroup elements within the group.

>> 4. Conjugation
>> The app demonstrates conjugation, showing how elements of D6 interact with each other when combined in a particular way.

>> 5. Generation of Subgroups
>> You can also generate subgroups from a single element, allowing you to see which elements are produced by repeated operations on a starting element.

> **How to Use**

>> Multiplying Group Elements: Click on the elements listed under the Elements of Group heading to multiply them together.

>> Subgroups and Cosets: Explore the subgroups, cosets, and conjugation by clicking on the corresponding buttons under their respective headings.

>> Generate Subgroups: Click on the buttons under the Generation of Subgroups heading to generate new subgroups.

> **Conclusion**

>> This app provides an interactive and intuitive way to understand the Dihedral Group D6 and its properties. By visualizing symmetries as permutations, you can easily explore the group's structure, including its elements, subgroups, cosets, conjugation, and subgroup generation. It's a valuable tool for anyone studying group theory or interested in the symmetries of regular polygons.

## <ins>[Dihedral Group](https://en.wikipedia.org/wiki/Dihedral_group) D4 App</ins>

**Link to Published App: [Dihedral Group D4](https://alipiyarali.shinyapps.io/GroupD4/)**

> **Introduction**

>> The Group D4 app demonstrates the Dihedral Group D4, which represents the symmetries of a square. This group consists of rotations and reflections that map the square onto itself. The app provides an interactive way to explore these symmetries and understand how they correspond to elements of the group.

> **What is Dihedral Group D4?**

>> Dihedral Group D4 represents the symmetries of a square. It includes 8 elements: 4 rotations and 4 reflections. The rotations are by multiples of 90 degrees, and the reflections are across the diagonals and the midpoints of the sides of the square.

>> In this app, you can apply these symmetries (rotations and flips) to see how the square changes. Each operation corresponds to an element of the D4 group.

> **Features**

>> 1. Group Operations
>> The app allows you to apply rotations and reflections to the square by clicking on the buttons in the left-side navigation. You can choose from the 4 rotations (0°, 90°, 180°, and 270°) and 4 reflections (across the horizontal, vertical, and two diagonal axes).

>> 2. Interactive Visualizations
>> As you click on the buttons for rotations or flips, the square will change to show the resulting symmetry operation. This helps visualize how each element of the D4 group affects the square.

> **How to Use**

>> Apply Rotations: Click on the buttons under the Rotations section in the left-side navigation to rotate the square by 0°, 90°, 180°, or 270°.

>> Apply Reflections: Click on the buttons under the Reflections section to flip the square across the horizontal, vertical, or diagonal axes.

>> Explore Symmetries: Observe how each operation corresponds to an element of the D4 group and how the square's symmetries work.

> **Conclusion**

>> This app offers an interactive tool for exploring the Dihedral Group D4 and the symmetries of a square. By applying rotations and reflections, users can see how the square behaves under the different elements of the group. It’s an excellent tool for visualizing group theory concepts and understanding the symmetry operations of polygons.
