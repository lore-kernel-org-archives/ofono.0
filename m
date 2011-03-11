Content-Type: multipart/mixed; boundary="===============0417139096066900028=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: Enable network time for AT modem
Date: Fri, 11 Mar 2011 13:54:44 -0800
Message-ID: <1299880484.2055.3.camel@aeonflux>
In-Reply-To: <1299848118.2851.5.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0417139096066900028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> > >  drivers/atmodem/network-registration.c |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > =

> > > diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem=
/network-registration.c
> > > index 4913611..2d589f0 100644
> > > --- a/drivers/atmodem/network-registration.c
> > > +++ b/drivers/atmodem/network-registration.c
> > > @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result, gp=
ointer user_data)
> > >  	nd->time.mday =3D mday;
> > >  	nd->time.mon =3D mon;
> > >  	nd->time.year =3D 2000 + year;
> > > +
> > > +	ofono_netreg_time_notify(netreg, &nd->time);
> > >  }
> > >  =

> > >  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
> > =

> > actually this time notification is a bad idea since you will notify
> > twice now. With the firmware that I tested this with, it is guaranteed
> > to always get CTZV and CTZDST and in that order.
> =

> Of course there will be two notifications since there are two distinct
> event CTZV and CTDST. My ifx modem documentation doesn't say that these
> are always bound together so we should not make any implicit assumption.
> Anyway I believe that it is the next level i.e. time plug-in whose job
> it is to check whether it has all the bits and pieces needed to inform
> the Timed or some other client.

that is a clear no here. We are not making every single nettime plugin
responsible for handling this. This needs to be handled either in the
core or in the drivers.

If you are afraid of the IFX modem not sending CTZV + CTZDST all the
time, then you need to handle this with a timeout to trigger notifying
nettime core.

However, I have not seen that yet on any network I have tested this on.
Also asking IFX to confirm the current assumption would just work.

Regards

Marcel



--===============0417139096066900028==--

