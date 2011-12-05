Content-Type: multipart/mixed; boundary="===============0464313425493363332=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC_v1 2/2] sierra: Add SIM state polling
Date: Mon, 05 Dec 2011 15:43:43 +0100
Message-ID: <1323096223.26198.55.camel@aeonflux>
In-Reply-To: <4ED8C066.4030808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0464313425493363332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> - The sierra driver does not instantiate any gprs_context drivers, so =
it
> >> isn't even capable of GPRS in its current state.  Sending the&C0
> >> command is only needed if you are planning to use PPP and probably
> >> belongs in a separate patch.
> >>
> > =

> > I didn't see the gprs context was never created into sierra plugin, do
> > we have a reason for that?
> > =

> =

> Probably just an oversight.

actually the TTY allocation for the Sierra modems are a bit funny. They
have one channel that is capable of doing PPP and the others are just
app1, app2, app3 channels. However only when issuing ATI it will tell
you what channel is which.

Regards

Marcel



--===============0464313425493363332==--

