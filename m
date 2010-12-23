Content-Type: multipart/mixed; boundary="===============7686523062550314198=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: oFono release plan?
Date: Thu, 23 Dec 2010 06:59:15 -0800
Message-ID: <1293116355.9439.15.camel@aeonflux>
In-Reply-To: <1293101796.3120.1547.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7686523062550314198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >         - SIM authentication API (EAP-SIM, EAP-AKA, IMS and GBA)
> > Can you please add more light on what is supported. I could not find
> > this info in the todo list. =

> =

> In short, we need to expose certain security services offered by the SIM
> card that utilize the crypto algorithms on the card. This is used for
> instance in voice over LTE authentication procedures. Probably needs to
> be added to the TODO.

right now Andrew is looking into the SIM application discovery with AT
command modems. Once we have that, we can look into what is needed for
using the EAP methods and add details TODO items.

Just adding a simple TODO item entry that we split out later into more
detailed once would be fine with me.

In theory we want an interface that suits all SIM authentication needs.
Besides IMS, the second big user will be WISPr 2.0 for WiFi hotspots.

Regards

Marcel



--===============7686523062550314198==--

