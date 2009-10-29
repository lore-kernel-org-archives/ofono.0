Content-Type: multipart/mixed; boundary="===============8273450077643657979=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Added functionality to remove modem from system,
 if needed.
Date: Thu, 29 Oct 2009 11:29:07 -0500
Message-ID: <200910291129.07801.denkenz@gmail.com>
In-Reply-To: <4AE9BFF8.5070202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8273450077643657979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Yea. I haven't looked at that part of the code, only that AT+CRC is the
> first command sent (if i remember right). Our modem sends a ^SYSSTART on
> powerup, what causes ofonod to go back to its initial state?

The core has no idea, everything is up to the modem driver.  Only the drive=
r =

knows when the powered up / down events happened.  The driver is responsibl=
e =

for informing the core.

>
> What is the "normal" start-up string for modems (i was told mc75 doesn't
> really abide the norm) ?

There isn't one, they are all different.

Regards,
-Denis

--===============8273450077643657979==--

