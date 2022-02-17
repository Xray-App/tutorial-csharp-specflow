# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

RUN apt-get --allow-releaseinfo-change update && \
    apt-get install -y gnupg wget curl unzip --no-install-recommends && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update -y && \
    apt-get install -y google-chrome-stable && \
    CHROMEVER=$(google-chrome --product-version | grep -o "[^\.]*\.[^\.]*\.[^\.]*") && \
    DRIVERVER=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROMEVER") && \
    wget -q --continue -P /chromedriver "http://chromedriver.storage.googleapis.com/$DRIVERVER/chromedriver_linux64.zip" && \
    unzip /chromedriver/chromedriver* -d /chromedriver

#RUN apt-get install -y mono-devel
RUN apt-get --allow-releaseinfo-change update && apt-get install -y dirmngr  apt-transport-https ca-certificates 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/debian stable-buster main" > /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get --allow-releaseinfo-change update &&  apt-get install -y mono-complete  
RUN mono --version

# Create a default user
RUN groupadd --system automation && \
    useradd --system --create-home --gid automation  automation && \
    chown --recursive automation:automation /home/automation

WORKDIR /source

COPY Calculator Calculator/
COPY Calculator.Specs Calculator.Specs/

RUN mkdir -p /source/Calculator.Specs/TestResults
RUN chown -R automation.automation /source
USER automation


# Put Chromedriver into the PATH
ENV PATH /chromedriver:$PATH
# set display port to avoid crash
ENV DISPLAY=:99

WORKDIR /source/SpecFlowCalculator
RUN dotnet restore
RUN dotnet clean
RUN dotnet build
WORKDIR /source/SpecFlowCalculator.Specs
RUN dotnet restore
RUN dotnet clean

WORKDIR /source/SpecFlowCalculator.Specs
ENTRYPOINT ["dotnet", "test"]

