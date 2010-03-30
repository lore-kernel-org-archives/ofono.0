Content-Type: multipart/mixed; boundary="===============7956936253373843996=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 20:37:05 +0300
Message-ID: <a32762a21003301037t17c119afq7eec0decc772755c@mail.gmail.com>
In-Reply-To: <201003301113.36166.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7956936253373843996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/30 Denis Kenzior <denkenz@gmail.com>:
> The answer is that exposing this as a property is not going to happen bec=
ause
> it is fundamentally wrong. =C2=A0And in effect it already is exposed, e.g=
. the fact
> that modem object is present in oFono. =C2=A0You have several options her=
e:

So I think what you are saying is that if a modem object exists, it is
available. That is, the HW has been powered up and initialized
properly. And that the Powered property is about whether or not the
modem's cellular is active (RF on/off).

If this is the case, then I think it'll do.

There is a corner case when the modem is borked and cannot be properly
powered but needs to be taken to a care point (not that that ever
happens IRL ;), and I would rather see this indicated explicitly
rather than implicitly by ModemManager returning an empty list of
modems.

> - Create an oFono plugin to listen to an external daemon and create/destr=
oy
> the modem object appropriately

This is what we were doing previously with N900: sscd would power up
the modem, and we would find out about it via netlink in the isimodem
driver.

> - Create an oFono plugin that will replace the external daemon and
> create/destroy the modem object appropriately

... and this seems like the best way forward here now.

> - Implement this properly in the kernel driver and signal device presence=
 via
> netlink / udev / etc

I don't think this makes sense, really.

Cheers,
Aki

--===============7956936253373843996==--

