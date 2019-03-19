## You just found  Nemo!
![http://www.amisvegetarian.com/finding-nemo-clipart-fire-clipart/finding-nemo-clipart-nemo-and-dory-clipart-at-getdrawings-free-for-personal-use-history-clipart/](http://www.amisvegetarian.com/wp-content/uploads/2018/09/finding-nemo-clipart-nemo-and-dory-clipart-at-getdrawings-free-for-personal-use-history-clipart-768x304.jpg)
---
_[image source](http://www.amisvegetarian.com/finding-nemo-clipart-fire-clipart/finding-nemo-clipart-nemo-and-dory-clipart-at-getdrawings-free-for-personal-use-history-clipart/)_
---

### What?
A simple Python module to query html pages (or xml in general) using (almost) all available CSS selectors and rules, that doesn't bore you with weird objects, just plain old lists and dicts.

### Why?
Why if we have [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)?
Because:
* bs4 doesn't support [advanced selectors](https://www.w3schools.com/cssref/css_selectors.asp), as `a:not(.not-this-a)` (*not* selector).
* it gets more into the [lxml](https://lxml.de) performance range.
* I wanted to make something useful *in* Nim.

### How?
* [Nim](https://nim-lang.org) is a very flexible and powerful language that I am delving a bit deeper into.
* [Nimquery](https://github.com/GULPF/nimquery) is a great nim module/package/library that gives us the querying capabilities.
* [Nimpy](https://github.com/yglukhov/nimpy) is an awesome nim module/package/library that builds a python native extension (think numpy or pandas) from a nim module.


### Getting it:

* **Build it on your OS:**
    * Make sure you have [nim and nimble](https://nim-lang.org) installed and working
    * Clone this repo
    * Run `nimble bld` to generate the sharedlib (or `nimble src` to generate C sources and a shellscript for compiling it later, all under `csources`)
    * Run `nimble tst` to test it with a bundled python script
    * And you are good to go!


* **Build it on a docker container (for use with alpine or ubuntu containers)**:
    * Be sure to have **make** and **docker** insalled and working
    * Clone this repo
    * Run `make build` to get the alpine version (for ubuntu, set LINUX = ubuntu) (or `make csources` to generate C sources and a shellscript for compiling it later, all under `csources`)
    * Run `make test` to test it with the bundled python script on the same container used to build
    * There you have your `nemo.so` file to put into your desired container!

* **Prebuilt binaries (macosx, alpine and ubuntu only, for the lazy ones)**:
    * [macosx](https://github.com/yvendruscolo/nemo/releases/tag/0.1.0-macosx)
    * [alpine](https://github.com/yvendruscolo/nemo/releases/tag/0.1.0-alpine)
    * [ubuntu](https://github.com/yvendruscolo/nemo/releases/tag/0.1.0-ubuntu)

### Usage:
```python
import nemo # assuming this is in the module's path

queries = [
    'body span a:not(.first-item)',
    # all 'a's inside 'span's in 'body' that are not in '.first-item' class
    '[href$=".pdf"]',
    # all links to pdfs
    'p, span'
    # all of 'p's and 'span's
]

results = dict(nemo.find(some_html, queries)) 
# a dict mapping from the query-string to a list of the findings,
# where each finding is a dict with attributes and content on key 'text', like:
{
    'body span a:not(.first-item)' : [{'tag':'a', 'text':'hi', 'class':'last-item'}],
    '[href$=".pdf"]':[
        {'tag':'a', 'href':'link-to-pdf'},
        {'tag':'a', 'href':'link-to-other-pdf'}
    ],
    'p, span':[
    # loads of elements, or maybe none, who knows
    ]
}
```