tidyverse_update() # to check if a package is up-to-date
library(tidyverse)
Sys.setenv(LANGUAGE="en") # to set environment language to english
install.packages(c("nycflights13", "gapminder", "Lahman"))
dput(mtcars) # to copy a reproducible data set

# importing data mpg from ggplot2 library
ggplot2::mpg
str(mpg)

# graph template
ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
###  Example   ####
# plot to check fuel efficiency based on engine size
# result revealed that as engine size increases, fuel efficiency reduces.
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))

# plot 2
ggplot(data=mpg)+
  geom_point(mapping=aes(x=hwy, y=cyl))

#plot 3
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv))

# plot 4 add random noise for better visualization: not always encouraged ###
#plot 3
ggplot(data=mpg)+
  geom_jitter(mapping=aes(x=displ, y=hwy))


### Aesthetic Mappings: allows additional variable to a 2-dim plot#####
# Aesthetics include things like the size, the shape, or the color of your points #
# Plot 1 using aesthetic ####
ggplot(data=mpg)+
  geom_point(mapping= aes(x=displ, y=hwy, colour=class))

# Plot 2 using aesthetic ####
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, alpha=class))

# Plot 3 using aesthetic ####
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, shape=class))

# plot 4 manually assigning aesthetic: set it after aes(), ####
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy),colour="blue")

# plot 5 using aesthetics #####
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ<5))


#### Facets: splits plots into subplots that each display one subset of the data ###
#### Plot 1; facet by a single variable use facet_wrap ### facet only accepts discrete variable
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~class, nrow=2) # nrow specifies the no. of facet division


#### Plot 2; facet by combo of 2 variables use facet_grid ###
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .) # facet without using row format

### changing the geom Plot 1 ####
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy))

### changing the geom Plot 2 and adding aesthetic ####
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy, group=drv))

### changing the geom Plot 3 and adding aesthetic ####
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy, colour=drv), 
              show.legend = F)

### display multiple geoms in the same plot ###
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(x=displ, y=hwy))
##### OR ########
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_smooth()+
  geom_point()

### display multiple geoms in the same plot + aesthetic ###
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(x=displ, y=hwy, colour=class))
###### OR #######
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping=aes(colour=class))+
  geom_smooth()

##### display multiple geoms in the same plot + aesthetic in both levels  #####
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(colour=class))+
  geom_smooth(data = filter(mpg, class=="subcompact"),se=F)

ggplot(data = mpg,mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se=F)# setting se=F will remove shadow from smooth plot


### Bar Chart #####
ggplot2::diamonds

#### frequency of diamonds cut ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut))
####  OR #####
ggplot(data=diamonds)+
  stat_count(mapping=aes(x=cut))

#### To assign specific height to bar chart ###
demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity")


#### Proportion of diamonds cut ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, y=..prop.., group=1))

### using summarize function to get summary of bar charts ###
ggplot(data=diamonds)+
  stat_summary(mapping=aes(x=cut, y-depth),
               fun.ymin=min,
               fun.ymax=max,
               fun.y=median)

#### Colour Bar chart ####
ggplot(data = diamonds)+
  geom_bar(mapping=aes(x=cut, colour=cut))
#### colour Plot 2 ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=cut))

#### Adding another variable through Aesthethic (stacked) ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=clarity))

#### show distinct colour separation
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")
#### OR ######
ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill= NA,position = "identity")

### easier way of comparing stacked variable ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=clarity), position="fill")

### comparing variables side by side ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=clarity),position="dodge")+
 
### comparing variables side by side and flip coordinates ####
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=clarity),position="dodge")+
  coord_flip()

### boxplot  ####
ggplot(data=mpg)+
geom_boxplot(mapping=aes(x=class, y=cty))
  
### To flip boxplot coordinates  ####
ggplot(data=mpg)+
  geom_boxplot(mapping=aes(x=class, y=cty))+
  coord_flip()

library(maps)
#### plotting a Map data ####
nz<-map_data("nz")
ggplot(nz, mapping=aes(long,lat,group=group))+
  geom_polygon(fill="white", colour="black")

#### plotting Map for spatial data:  ####
nz<-map_data("nz")
ggplot(nz, mapping=aes(long,lat,group=group))+
  geom_polygon(fill="white", colour="black")+
  coord_quickmap()

### world map plot ####
world<-map_data("world")
ggplot(data=world, mapping=aes(long, lat, group=group))+
  geom_polygon(fill="white", colour="black")

#### plot of pie chart with coord_polar function ####
bar<- ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = cut),show.legend = FALSE,width = 1)+
  theme(aspect.ratio = 1)+
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()

### exercise, turn stacked bar to pie chart ###
stacked<-ggplot(data = diamonds, mapping=aes(x=cut, fill=clarity))+
  geom_bar(alpha=1/5, position="identity")+
  labs(x = NULL, y = NULL)
stacked+coord_flip()
stacked+coord_polar()
##### OR #####
ggplot(data = diamonds, mapping=aes(x=cut, fill=clarity))+
  geom_bar(alpha=1/5, position="identity")+
  coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()+
  geom_abline()+
  coord_fixed() # coord_fixed make the graph apperance (crop) smaller


##### Web graphing using Plotly ####
library("plotly")
ggplotly(stacked)
ggplotly(stacked+coord_flip())
a<-ggplot(data=world, mapping=aes(long, lat, group=group))+
  geom_polygon(fill="white", colour="black")
ggplotly(a)

#### steps to output ggplot on plotly ###
### save ggplot code as an object, then use ggplotly to plot it ####
b<-ggplot(data = mpg,mapping=aes(x=displ, y=hwy, colour=drv))+
  geom_point()+
  geom_smooth(se=F)
ggplotly(b)

##### plotly 2 ####
c<-ggplot(data=diamonds, mapping=aes(x=cut, fill=clarity))+
  geom_bar(alpha=1/5, position="identity")+
  coord_flip()
ggplotly(c)

#### plotly 3 ####
d<-ggplot(data = mpg)+
  geom_boxplot(mapping=aes(x=class, y=hwy), colour="blue")
ggplotly(d)

#### plotly 4 ####
e<-ggplot(data = mpg)+
  geom_boxplot(mapping=aes(x=trans, y=hwy), colour="green")+
  coord_flip()
ggplotly(e)
