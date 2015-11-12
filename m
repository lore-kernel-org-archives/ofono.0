Content-Type: multipart/mixed; boundary="===============5279594264847811570=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: Udevng plugin seems to fail sometimes?
Date: Thu, 12 Nov 2015 09:39:13 +0000
Message-ID: <56445E49.4030607@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5279594264847811570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am using oFono in an embedded environment, and I seem to have =

encountered a problem with the udevng plugin. It seems that the =

udev_monitor sometimes fails to init, so when the modem in the =

environment has started, oFono cannot find it. I can see the modem with =

'lsusb' if I log in to the embedded system, but when I list the modems =

in oFono I get an empty list.

I have verified that when this happens udev is running in the system, =

and that a sane file descriptor is received when creating the IOChannel =

used for the monitor. Yet, the channel is closed almost immediately. My =

best guess is that udev sends some sort of HUP.

oFono is started automatically by systemd, but in a much later target =

than udev.

The issue appears too sporadically to be able to debug this properly, so =

I am wondering if anyone else has seen this issue?

While trying to understand myself exactly what is going on I haven't =

managed to come across anything on google, or in other programs' source =

code, suggesting that the setup code for the monitor is doing something =

wrong. So, I also wonder if anyone has any suggestions on what kind of =

traces I shall try to print to gain an understanding of what is happening?

Thank you in advance for any assistance.

Best regards // John Ernberg
--===============5279594264847811570==--

