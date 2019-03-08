import nemo

selectors = [
  """a[href^="/year/"]""", #easy
  """time""", #easier
  """.rating""", #let's check
  #oops, there are 13 of those... but which one?
  """.rating:not(.rating-list)""" #the one the is not a rating-list!
]

with open("index.html", "r") as html:
  year, duration, bad_rating, rating = nemo.find(html.read(), selectors)
  assert year[1][0]["text"] == "2003"
  assert duration[1][0]["text"].strip() == "100 min"
  assert len(bad_rating[1]) == 13
  assert rating[1][0]["text"] == "8.1/10"
  print("Test passed")