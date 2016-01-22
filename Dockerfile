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

FROM windowsservercore
RUN mkdir C:\busybox
ADD http://frippery.org/files/busybox/busybox.exe /busybox/
RUN setx /M PATH "C:\busybox;%PATH%"
RUN powershell busybox.exe --list ^|%{$nul = cmd /c mklink C:\busybox\$_.exe busybox.exe}
ENTRYPOINT ["C:/busybox/busybox.exe"]
