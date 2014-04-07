Content-Type: multipart/mixed; boundary="===============8726841664994922261=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono not "recognizing" some USB dongles
Date: Sun, 06 Apr 2014 20:52:09 -0500
Message-ID: <534204C9.8050403@gmail.com>
In-Reply-To: <CAM5ihG8GmDMNE+oJRtuaoi5Jg5KUKOSieUKdosq4SYQw9SstgQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8726841664994922261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jer=C3=B4nimo,

<snip>

> After that, I've changed "setup_huawei" at plugins/udevng.c to force
> Pcui to point to ttyUSB2, but then I got stuck at the next AT commnad,
> 'ATI': =

> ofonod[241]: src/modem.c:get_modem_property() modem 0x1909b0 property Mod=
em
> ofonod[241]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
> ofonod[241]: src/modem.c:get_modem_property() modem 0x1909b0 property Pcui
> ofonod[241]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
> ofonod[241]: Modem: > ATE0 +CMEE=3D1\r
> ofonod[241]: PCUI: > ATE0 +CMEE=3D1\r
> ofonod[241]: Modem: < \r\nOK\r\n
> ofonod[241]: PCUI: < \r\nOK\r\n
> ofonod[241]: PCUI: > ATI\r
> =


Try switching the PCUI and Modem ports?  E.g. run PCUI on ttyUSB0 and
vice versa.

> So, can anyone give me a clue of what to do next?

Not much I can suggest besides tracing what ports / commands makes this
hardware work and try to replicate.

Regards,
-Denis


--===============8726841664994922261==--

