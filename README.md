# docker-spark-jupyter
Jupyter Notebook with Python 3.5 kernel based on cloudera/quickstart

Create and start a container:

```bash
docker run -it -p 8888 -p 8088:8088 -p 8042:8042 -p 4040:4040 -h sandbox -v $(pwd):/root/myproject ceshine/spark-jupyter bash
docker run --hostname=quickstart.cloudera --privileged=true -t -i -p 18080:18080 -p 8888:8888 -p 9999:9999 -p 7180:7180 -p 9898:80 -p 50070:50070 -v $(pwd):/src/myproject ceshine/spark-jupyter /usr/bin/docker-quickstart
```

Inside the container, run (assuming you're inside /src folder):

```bash
jupyter notebook
```

(There is a jupyter_notebook_config.py inside /root which saves you certain amounts of typing. You might want to copy and adapt that script into your project folder.)

Now visit http://<your docker container ip>:8888 and you're good to go!

# Test Notebook

The following code is adapted from [all-spark-notebook of docker-stacks](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook). You can use this notebook to check if the environment is set up correctly.

```Python
import os
# make sure pyspark tells workers to use python3 not 2 if both are installed
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3.5'

import pyspark
conf = pyspark.SparkConf()

# point to mesos master or zookeeper entry (e.g., zk://10.10.10.10:2181/mesos)
conf.setMaster("yarn-client")
# set other options as desired
conf.set("spark.executor.memory", "1g")
conf.set("spark.core.connection.ack.wait.timeout", "1200")

# create the context
sc = pyspark.SparkContext(conf=conf)

# do something to prove it works
rdd = sc.parallelize(range(100000000))
rdd.sumApprox(3)
```

To quote from the original [docker-stack](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook) repo:
> Of course, all of this can be hidden in an IPython kernel startup script, but "explicit is better than implicit." :)
