Content-Type: multipart/mixed; boundary="===============8512294237217614070=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: ofono with serial modem
Date: Fri, 02 Dec 2011 11:52:30 +0100
Message-ID: <CAC+thW1qhfujn7NDmcWKHiY-BXtUYfvYE12VQdfHwL-k=B7SJg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8512294237217614070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi! I'm new to the list and ofono project. In these days I'm trying to
figure out if ofono can help me with some embedded projects involving
M2M GPRS connections on serial modems.
I have a few questions I was not able to give an answer to, neither
from wiki nor from doc files in source code. Hope not to bother with
too newbish questions here!

1. Are non-hot-pluggable serial modem supported by ofono? I believe
they should run with the atmodem driver: is this correct?

2. Is udev detection the only way to let ofono know about a modem? If
I'm not wrong, I read about support for some kind of static
configuration in the past (modem.conf file), but it seems gone in
these days. I'm definitely fine with udev: just need some hints on how
to setup a rule to let ofono know I have a pretty standard AT modem
on, say, ttyS0. I looked at ofono.rules, but I think it deals mainly
with usb modem.

3. ofono looks very promising for its integration with d-bus. I'm
looking forward to be able to have different applications to manage
GPRS context activation/deactivation while, i.e., monitoring signal
strength and maybe asynchronous notifications by the modem itself. Are
these tasks in the ofono's scope or not?

Thanks in advance for any clarifications!

Regards,
Andrea

--===============8512294237217614070==--

