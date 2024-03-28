# Source: http://frippery.org/busybox/
# This Dockerfile builds a (32-bit) busybox images which is suitable for
# running many of the integration-cli tests for Docker against a Windows
# daemon. It will not run on nanoserver as that is 64-bit only.
#
# John Howard (IRC jhowardmsft, Email john.howard@microsoft.com)
#
# To build: docker build -t busybox .
# To publish: Needs someone with publishing rights
#
# http://github.com/jhowardmsft/busybox

FROM mcr.microsoft.com/windows/servercore:ltsc2022
# combining the RUN steps to reduce the layer size
RUN mkdir C:\tmp && mkdir C:\bin \
    && curl -fsSLO http://frippery.org/files/busybox/busybox.exe \
    && setx /M PATH "C:\bin;%PATH%" \
    && powershell C:\busybox.exe --list ^|%{$nul = cmd /c mklink C:\bin\$_.exe C:\busybox.exe}
CMD ["sh"]
