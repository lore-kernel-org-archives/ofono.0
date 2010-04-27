Content-Type: multipart/mixed; boundary="===============2653579470893266912=="
MIME-Version: 1.0
From: Bastien Nocera <hadess@hadess.net>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 15:40:50 +0000
Message-ID: <1272382844.17421.6792.camel@localhost.localdomain>
In-Reply-To: <20100427153043.GA3374@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2653579470893266912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-27 at 12:30 -0300, Gustavo F. Padovan wrote:
> Hi Bastien,
> =

> =

> * Bastien Nocera <hadess@hadess.net> [2010-04-27 09:15:28 +0100]:
> =

> > On Mon, 2010-04-26 at 22:20 -0300, Gustavo F. Padovan wrote:
> > > Hi all,
> > > =

> > > I'm starting the DUN Client implementation for the Linux Stack. DUN is
> > > the Bluetooth dial-up network profile. It makes possible share intern=
et
> > > connection between two Bluetooth devices. That is my Google Summer of=
 Code
> > > project for this year.
> > =

> > Does this project include anything that will be reusable by non-oFono
> > based projects? Native BT PPP line discipline would have been nice.
> > =

> =

> Yes, oFono will be only the Agent, you can implement a new one if you
> want.

The ppp implementation in NetworkManager already works for me.

>  Also oFono already does the PPP line discipline, so we don't need
> to duplicate such feature in BlueZ.

I thought BT PPP line discipline was a kernel feature.


--===============2653579470893266912==--

