Content-Type: multipart/mixed; boundary="===============2539725964163322174=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 2/3] sim800: add udev detection
Date: Wed, 19 Sep 2018 22:10:00 +0200
Message-ID: <20180919201000.GE3536@turing>
In-Reply-To: <72714607-51ea-ca77-42fc-77ed237030e0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2539725964163322174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 03:03:57PM -0500, Denis Kenzior wrote:
Hi,

> Hi,
> =

> >>
> >>So I'm confused now.  If sim800 is a serial device, why do you have all=
 this
> >>here?  Shouldn't this be handled by setup_serial_modem ?
> >>
> >
> >Because the modem was seen through a serial/USB converter, my kernel see=
s it as a USB device. So I used this function.
> >Should this be coded in a more generic way ?
> >
> =

> Yes, you should use the setup_serial_modem bits and the UDEV rule outlined
> in patch 3 should take care of the detection.
> =


All right, I'll change the detection and setup in next patch set.

> Regards,
> -Denis

Regards
Clem

--===============2539725964163322174==--

