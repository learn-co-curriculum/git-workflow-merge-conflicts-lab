# Git Merge Conflicts

## Learning Goals

- Demonstrate steps for merge conflict resolution
- Execute resolving a merge conflict

## Important Update

In order to complete this lab, please be sure to clone it from the following source:

https://github.com/learn-co-curriculum/git-workflow-merge-conflicts-lab

This is required because our teaching system works to make sure we don't deploy
"broken git repositories" to our learners. But we're trying to teach you to work with...
broken git repositories 😂. Cloning from the URL above, into a new directory is the
best way to complete this lab.

## Introduction

We've discussed how merge conflicts happen and how we can solve them. Let's work
through a scenario using characters from [Back to the Future][] to resolve some
issues with conflicting Git histories!

[Back to the Future]: https://www.imdb.com/title/tt0088763/

Marty McFly and Doc Brown just finished their student profiles for Flatiron
School. Now they need to merge their profiles into the `master` branch so that
they'll have a completed profile page.

__This is what we will be working towards:__

![The Goal](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/goal)

## Demonstrate Steps for Merge Conflict Resolution

On the `master` branch, there is a placeholder profile in place. The
`index.html` page on that branch looks like this:

![avatar-placeholder-master-branch](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/master-branch)

Doc's finished profile is in the `doc-brown` branch. The index page on his
branch looks like this:

![doc-browns-branch](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/doc-brown-branch)

Meanwhile, Marty's finished profile is stored in the `marty-mcfly` branch. His
index page on his branch looks like this:

![marty-mcflys-branch](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/marty-mcfly-branch)

You are going to merge both branches onto the master branch and resolve the
merge conflicts.

To accomplish this, you're going to be following six steps, listed below:

1. Make sure you have all three branches
2. Switch to the master branch
3. Merge Doc's branch into the master branch. This will merge "cleanly"
4. Merge Marty's branch in. This ***will not*** merge cleanly due to a "merge
   conflict"
4. Fix the merge conflict
5. Delete Doc and Marty's branches on your computer
6. Verify that Doc and Marty's branches have been integrated to your local
   `master` branch.

### Step 1: Confirm You Have Both Branches

Remember to fork then clone down this repo. Then change directories into it using:

- `cd git-merge-conflicts-< your cohort identifier >`

The first step is to see how many branches you have locally. Run `git branch`
from your terminal to see all of the branches. The output should look like this:

```bash
$ git branch
* master
```

To fetch the  `doc-brown` or `marty-mcfly` remote branches, run the following
commands in order:

- `git checkout -t origin/doc-brown`
- `git checkout -t origin/marty-mcfly`

This creates a local tracking-branch on your computer that matches the
`doc-brown` and `marty-mcfly` branches on GitHub. Let's verify this by
re-running the `git branch` command. The output should look like this:

```bash
$ git branch
  doc-brown
* marty-mcfly
  master
```

If you don't have all three branches, get help.

As you can see, the `marty-mcfly` branch is starred and highlighted. This is
Git's way of telling you which branch you're on. Git "put" us "on" this branch
when we issued that last `checkout` command. Therefore, you're on the
`marty-mcfly` branch. Since we want to merge _into_ `master` we need to "get"
back "on" it.

### Step 2: Navigate Into The `master` Branch

Remember, checkout allows you to switch between branches that are on your local
machine. It's time to check out the `master` branch:

- `git checkout master`

You should now be in the `master` branch. Remember, you can confirm you're on
the master branch if it's starred and highlighted when you run `git branch`:

```bash
$ git branch
  doc-brown
  marty-mcfly
* master
```

From the `master` branch, if you are using the in-browser IDE, you can open the
index page and take a look by running `httpserver` (or, if you are using a local
environment, open the file by running `open index.html`). You should see a web
page with just a placeholder avatar. Marty and Doc should not be there.

### Step 3: Merge!

You're going to add both the `doc-brown` branch and the `marty-mcfly` branch to
the master branch using `git merge`. Merge the `doc-brown` branch first by running:

```bash
git merge doc-brown -m "merge doc brown"
```

Here, we're saying: "Integrate the differences between `master` and `doc-brown`
_back_ into `master`."

When you merge `doc-brown` into your `master` branch, your terminal should print
a readout that looks something like this:

```bash
Updating 7d220f6..bb73c64
Fast-forward
 img/students/doc_brown_index_profile.jpg    | Bin 0 -> 32589 bytes
 img/students/student_name_background.jpg    | Bin 72485 -> 0 bytes
 img/students/student_name_index_profile.jpg | Bin 17565 -> 0 bytes
 img/students/student_name_profile.jpg       | Bin 12632 -> 0 bytes
 index.html                                  |  23 ++++++++++++++++++++++-
 5 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 img/students/doc_brown_index_profile.jpg
 delete mode 100644 img/students/student_name_background.jpg
 delete mode 100644 img/students/student_name_index_profile.jpg
 delete mode 100644 img/students/student_name_profile.jpg
 ```

This readout confirms that you've merged all of Doc Brown's profile information
into the `master` branch. Take a look at the index page by again running `open
index.html` in the terminal. It's important to keep looking at `index.html` to
make sure that it looks exactly how you want it to look.

__The `index.html` page should look like this:__

![Doc Brown Merge](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/add-doc-brown)

Now try merging in Marty McFly's profile information into the master branch. You
probably already are, but ensure that you are currently on your `master` branch
(type `git branch`). Then run:

```bash
git merge marty-mcfly -m "Merge marty mcfly"
```

Here, we're saying: "Integrate the differences between `master` and
`marty-mcfly` _back_ into `master`."

```text
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

Yikes! Now we have a merge conflict! Why did this happen? Well, both Doc Brown
and Marty McFly took `master` at the same moment in the Git history. This idea
has become commonplace in sci-fi films but they "branched" reality. They
started "two" timelines from that point. In those separate "timelines," they
changed the same thing. We merged in the changes from Doc Brown's timeline to
`master` but now we're trying to merge in Marty McFly's _same changes_ from
_his_ timeline. Git needs us to help it decide how to integrate these two
timelines. That's what all merge conflicts are: Git telling us it's not sure
how to move forward and it needs our help! Nobody said reweaving the fabric of
time would be easy!

__This is what `index.html` should look like with the merge conflict:__

![Merge Conflict!](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/git-merge-conflicts/merge-conflict)

### Step 4: Fix the Conflicts

Open up the `index.html` file. Scroll down to around line 114 and 137. You
should see something that looks like this:

```html
<<<<<<< HEAD
  <!-- Begin Profile -->
  <li class="home-blog-post">
    <div class="blog-thumb">
      <img width="304" height="304" class="prof-image" src="img/students/doc_brown_index_profile.jpg" class="attachment-blog-thumb wp-post-image" alt="doc brown">
    </div>

   <div class="blog-title">
      <div class="big-comment">
        <h3>Doc Brown</h3>
      </div>
      <p class="home-blog-post-meta">"Great Scott!"</p>
    </div>
    <div class="clear"></div>

    <div class="excerpt">
      <p>Doctor Emmett Lathrop "Doc" Brown was the inventor of the DeLorean time machine. Doc's role models were scientists, as evidenced by the names of his dogs and the portraits of Isaac Newton and Albert Einstein found inside his laboratory.</p>
    </div>
    <div class="clear"></div>
  </li>
  <!-- End Profile -->
=======
>>>>>>> marty-mcfly
... (MORE CODE) ...
```

#### Identify the Commits to Merge

Remember, Git does its best to merge the code, but sometimes it just doesn't
work. You need to complete the merge yourself by manually adjusting the code.
Git gives you a few hints to help us out:

- `<<<<<<< HEAD` - the beginning of the original branch (`master`)
- `=======` - the end of the original branch/the beginning of the branch being merged in (`marty-mcfly`)
- `>>>>>>> marty-mcfly` - the end of the new branch ( `marty-mcfly`)

Take your time and shift the code around, separating the `MARTY MCFLY` and `DOC
BROWN` code blocks. Use the markers from git as a guide.

**Hint:** You can also use the HTML tags as guides. If one section ends with an
opening `<a>` tag, look for the closing `</a>` tag in the next section.

When you're done the code should look something like this:

 ```html
<!-- Begin MARTY MCFLY -->
<li class="home-blog-post">
  <div class="blog-thumb">
    <a href="students/marty_mcfly.html">
      <img width="304" height="304" class="prof-image" src="img/students/marty_mcfly_index_profile.jpg" class="attachment-blog-thumb wp-post-image" alt="doc brown">
    </a>
  </div>

... (MORE CODE) ...

</li>
<!-- End MARTY MCFLY -->

<!-- Begin DOC BROWN -->
<li class="home-blog-post">
  <div class="blog-thumb">
    <a href="students/doc_brown.html">
      <img width="304" height="304" class="prof-image" src="img/students/doc_brown_index_profile.jpg" class="attachment-blog-thumb wp-post-image" alt="doc brown">
    </a>
  </div>

... (MORE CODE) ...

</li>
<!-- End DOC BROWN -->
 ```

Open the page with `httpserver` (or `open index.html`). The page should look
like the picture at the very top of this readme.

If everything is looking good, we're ready to commit the changes before moving on.

- run `git add .` to stage all changes made in `index.html`
- run `git commit -am "merge marty and doc index pages"` to commit, or finalize, these changes

### Step 5: Confirm the Changes Are Correct

Almost done! The next and last step is to confirm that the `master` branch has
everything we need.

Confirm that `index.html` in the `master` branch has the following for both Doc
Brown and Marty McFly:

- profile images
- profile names
- descriptions

Once you have that, make sure you're still on the master branch. Now delete the
`doc-brown` and `marty-mcfly` branches:

- run `git branch -D doc-brown` to delete the `doc-brown` branch
- run `git branch -D marty-mcfly` to delete, you guessed it, the `marty-mcfly` branch

That's it! Open up `index.html` in your browser to see your beautiful work!

![YAY](http://i.giphy.com/J1WfRHBFj8lFK.gif)

### Step 6: Wrap Up

Remember, while your computer has these updates, GitHub has no idea that you
made them. These are all local. Typically, the next step would be to create a
branch off of your _local_ master with `git checkout -b wip-marty-and-doc-added
master`, push that branch with, `git push origin wip-marty-and-doc-added` and
then create a pull request to merge `wip-marty-and-doc-added` to the remote
`master` branch.

## Conclusion

Congrats on fixing your first merge conflict! This is a topic that takes a
while to get a hang of. As you edit more text you'll learn to be better at
understanding why Git is asking you for help. It's an intermediate-level Git
skill, so if it's not easy right now, that's OK. The important thing to
understand is that developers can split timelines and decide to edit the same
material so that Git needs our help to integrate things during merges.

## Resources

- [Git Branching - Basic Branching and Merging](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging)
- [Stack Overflow - Best (and safest) way to merge a git branch into master](http://stackoverflow.com/questions/5601931/best-and-safest-way-to-merge-a-git-branch-into-master)
