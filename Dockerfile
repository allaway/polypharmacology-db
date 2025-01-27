FROM sagebionetworks/shiny-base:release-1.0
USER root
RUN apt-get install -y default-jdk
RUN R CMD javareconf
USER shiny
# This is the expected application installation folder
WORKDIR /srv/shiny-server/app
COPY --chown=shiny ./ ./
# renv restore
RUN Rscript -e "install.packages(c('renv'), repos='http://cran.rstudio.com/'); renv::restore()"
RUN Rscript -e "install.packages(c('conflicted','rjson'), repos='http://cran.rstudio.com/')"
