require(extrafont)
require(ggplot2)
font_import(pattern = "GIL", prompt = FALSE)  # Import Gill family
loadfonts(device="win")  # Load them all
fonts()  # See what fonts are available

zp1 <- ggplot(data = iris,
              aes(x = Sepal.Length, y = Sepal.Width, label = Species))
zp1 <- zp1 + geom_text(family = "Gill Sans MT")
zp1 <- zp1 + theme(text=element_text(family="Gill Sans Ultra Bold"))
print(zp1)
