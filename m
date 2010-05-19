Content-Type: multipart/mixed; boundary="===============8023335360075799040=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Reg. Request for ISI modem details
Date: Wed, 19 May 2010 13:16:23 +0300
Message-ID: <AANLkTim4IwhMMB24XPErnRlgrUT56h6NSEpAJYFna6W1@mail.gmail.com>
In-Reply-To: <AANLkTilBZeUuhyUa9_HhFrkByeTPLdACcUP1Tnyv6Dg4@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8023335360075799040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/5/19 satya kishore <satyakishore.kalva@gmail.com>:
> I trying to find the modem source code in oFono source code. I am unable =
to
> get it. Here in oFono code we got only interface to the ISI modem.

The modem firmware is not open source.

> Where can I get the oFono ISI modem related information like source code =
or
> any libraries.=C2=A0 Is it open source ?

We have the ISI client library in gisi/, and a modem driver for ISI
modems in drivers/isimodem, and a plugin to use that driver with Nokia
phones over USB in plugins/usbpnmodem. We're also working on an N900
plugin at the moment.

> And also I am happy if provide the required information regarding plug-ins
> and its licensing issues. Can we use proprietary plug-ins in oFono stack.

oFono is GPLv2, including all plugins. Proprietary plugins are not allowed.


Cheers,
Aki

P.S. Please subscribe to the list, as this list requires membership to post.

--===============8023335360075799040==--

