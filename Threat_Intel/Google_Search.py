#!/usr/bin/env python
# cyberfive.co.uk

import sys
from google import google # >= Google-Search-API 1.1.13

query_string = "filetype:{0} inurl:{1} inurl:{2}".format(sys.argv[1], sys.argv[2], sys.argv[3])
num_page = 10

search_results = google.search(query_string, num_page)

for item in search_results:
     print(item.link)
