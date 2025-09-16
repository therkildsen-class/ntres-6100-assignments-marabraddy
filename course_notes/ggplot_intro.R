library(tidyverse)

mpg
?mpg

?cars
cars

View(mpg)

head(cars, 4)
tail(cars)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) + 
  geom_smooth() +
  facet_wrap(~ class)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) + 
  geom_smooth() +
  facet_wrap(~ year, nrow = 2) +
  theme_classic()





plot1 <- ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping=aes (color=class, size=cyl), shape=1) +
  geom_smooth() +
  facet_wrap(~year, nrow=2) +
  theme_minimal()


ggsave(filename = "course_notes/hwy_vs_displ.png", width = 8, height = 4)

?ggsave

plot1

ggsave("course_notes/hwy_vs_displ.png", plot1, width = 8, height = 4)





