Content-Type: multipart/mixed; boundary="===============6055489454722817829=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 12:30:43 -0300
Message-ID: <20100427153043.GA3374@vigoh>
In-Reply-To: <1272356128.17421.6781.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6055489454722817829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bastien,


* Bastien Nocera <hadess@hadess.net> [2010-04-27 09:15:28 +0100]:

> On Mon, 2010-04-26 at 22:20 -0300, Gustavo F. Padovan wrote:
> > Hi all,
> > =

> > I'm starting the DUN Client implementation for the Linux Stack. DUN is
> > the Bluetooth dial-up network profile. It makes possible share internet
> > connection between two Bluetooth devices. That is my Google Summer of C=
ode
> > project for this year.
> =

> Does this project include anything that will be reusable by non-oFono
> based projects? Native BT PPP line discipline would have been nice.
> =


Yes, oFono will be only the Agent, you can implement a new one if you
want. Also oFono already does the PPP line discipline, so we don't need
to duplicate such feature in BlueZ.

-- =

Gustavo F. Padovan
http://padovan.org

--===============6055489454722817829==--

