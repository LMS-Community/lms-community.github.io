---
layout: default
title: Add locales to the LMS Docker container
---

# Add locales to the LMS Docker container

If you have problems running the LMS Docker because of missing locales, you can add the following init script to the Docker config folder. In this example the locale `de_DE` is added to the container.

```sh
#!/bin/sh

if locale -a | grep ^de_DE ; then
	echo "Locale de_DE already installed..."
else
	apt-get update && apt-get -y install locales && sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
fi
```

Save this as a script called `custom-init.sh` in the configuration folder and make sure that it has the execution flag set (`chmod +x custom-init.sh`).
