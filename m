Content-Type: multipart/mixed; boundary="===============2397415482702370736=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 3/4] radio settings: document FastDormancy property
Date: Fri, 08 Oct 2010 10:55:48 +0200
Message-ID: <1286528148.6145.198.camel@aeonflux>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7CE20A82@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2397415482702370736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > so how does the future prediction is suppose to work. Are we =

> > shipping a
> > time machine together with oFono ;)
> =

> I would say the heuristic is system dependent. Typical way would be to mo=
nitor events from different input devices. If no events arrive for a specif=
ied time the user is assumed to be inactive. The user might also have some =
explicit way to do this, such as locking the display and keys.

and by that extend we drain the battery since every single component has
to send keep-alive messages around. Or it has to accept that the wakeup
time for its GPRS connection is horrible.

I am not per-se against doing the interface like this, but we have
discussed this in the beginning of the year. And I like to see how we
are planning to use this API to support fast dormancy properly and most
efficient.

So lets take a MeeGo system running on a mobile phone, how would we use
this property for this. What other system components do we have to
monitor? Which are our input sources for this?

Help me to get the full picture of this and how it should be integrated
into a complete system. Just checking of the fast dormancy check box is
not gonna be enough here.

Regards

Marcel



--===============2397415482702370736==--

