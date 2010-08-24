Content-Type: multipart/mixed; boundary="===============8696633365090187839=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About Gatmux
Date: Tue, 24 Aug 2010 12:02:19 +0200
Message-ID: <1282644139.6841.15.camel@localhost.localdomain>
In-Reply-To: <4C73953A.3080102@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8696633365090187839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> In DLC establish phase, 27.010 have said if the station wish to =

> establish a DLC, if the responding station is ready to establish the =

> connection it will reply with a UA frame with the F-bit set to 1. If the =

> responding station is not ready or unwilling to establish the particular =

> DLC it will reply with a DM frame with the F-bit set to 1.
> =

> But in function gsm0710_packet, i can't find the corresponding =

> processing, so does retransmit processing.
> =

> So does Gatmux support this, or it will support?

I can't answer that. It is too long time ago, I was working on MUX
details. If you feel the current code is wrong or incomplete then please
send a patch to fix it.

Regards

Marcel



--===============8696633365090187839==--

