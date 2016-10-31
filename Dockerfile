# escape=`

# Source: http://frippery.org/busybox/
# This Dockerfile builds a (32-bit) busybox image which is suitable for
# running many of the integration-cli tests for Docker against a Windows
# daemon. It will not run on nanoserver as that is 64-bit only.
#
# John Howard (IRC jhowardmsft, Email john.howard@microsoft.com)
#
# To build: docker build -t busybox .
# To publish: Needs someone with publishing rights
#
# http://github.com/jhowardmsft/busybox

FROM microsoft/windowsservercore
SHELL ["powershell", "-command"]
# /tmp is created as it's needed by CI tests in Docker.
RUN mkdir C:\tmp; mkdir C:\busybox; setx /M PATH $('C:\busybox;'+$env:PATH)
ADD http://frippery.org/files/busybox/busybox.exe c:\busybox\
RUN busybox.exe --list | %{New-Item -Path C:\busybox\$_.exe -ItemType SymbolicLink -Value C:\busybox\busybox.exe}
ENTRYPOINT ["C:\\busybox\\busybox.exe"]
