c = get_config()

c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9999 # or whatever you want; be aware of conflicts with CDH
c.NotebookApp.notebook_dir = u"/src"
