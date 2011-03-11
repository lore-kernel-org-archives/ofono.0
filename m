Content-Type: multipart/mixed; boundary="===============4984578900277744892=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH] atmodem: Enable network time for AT modem
Date: Fri, 11 Mar 2011 14:55:18 +0200
Message-ID: <1299848118.2851.5.camel@apaila-ThinkPad-T410>
In-Reply-To: <1299604359.2497.5.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4984578900277744892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-03-08 at 09:12 -0800, ext Marcel Holtmann wrote:
> Hi Antti,
> =

> >  drivers/atmodem/network-registration.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/n=
etwork-registration.c
> > index 4913611..2d589f0 100644
> > --- a/drivers/atmodem/network-registration.c
> > +++ b/drivers/atmodem/network-registration.c
> > @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result, gpoi=
nter user_data)
> >  	nd->time.mday =3D mday;
> >  	nd->time.mon =3D mon;
> >  	nd->time.year =3D 2000 + year;
> > +
> > +	ofono_netreg_time_notify(netreg, &nd->time);
> >  }
> >  =

> >  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
> =

> actually this time notification is a bad idea since you will notify
> twice now. With the firmware that I tested this with, it is guaranteed
> to always get CTZV and CTZDST and in that order.

Of course there will be two notifications since there are two distinct
event CTZV and CTDST. My ifx modem documentation doesn't say that these
are always bound together so we should not make any implicit assumption.
Anyway I believe that it is the next level i.e. time plug-in whose job
it is to check whether it has all the bits and pieces needed to inform
the Timed or some other client.

BR,
  Antti =



--===============4984578900277744892==--

