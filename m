Content-Type: multipart/mixed; boundary="===============4758544803407463711=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: RE: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 11:44:54 +0200
Message-ID: <1299577494.23123.7.camel@apaila-ThinkPad-T410>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802E706C6@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4758544803407463711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On Tue, 2011-03-08 at 10:59 +0200, ext Jeevaka.Badrappan(a)elektrobit.com
wrote:
> Hi Antti,
> =

> ofono-bounces(a)ofono.org wrote:
> > ---
> >  drivers/atmodem/network-registration.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/atmodem/network-registration.c
> > b/drivers/atmodem/network-registration.c
> > index 4913611..2d589f0 100644
> > --- a/drivers/atmodem/network-registration.c
> > +++ b/drivers/atmodem/network-registration.c
> > @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result,
> >  	gpointer user_data) nd->time.mday =3D mday;
> >  	nd->time.mon =3D mon;
> >  	nd->time.year =3D 2000 + year;
> > +
> > +	ofono_netreg_time_notify(netreg, &nd->time);
> >  }
> > =

> >  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
> =

> Since the fix is more to do with the ifx modem, it would be nice if we
> have the
> commit message changed to reflect that.

I suppose the person applying the patch can do the modifications to the com=
mit message if needed. =


> Whenever there is a timezone change, CTZV, CTZDST and XNITZINFO URCs
> will be reported. That is the main
> reason behind calling the ofono_netreg_time_notify from CTZDST. Are you
> pretty sure
> this is not the case?

I don't know the details of ifx modem internals. If the time changes, is
it always guaranteed that CTZDST is sent and that CTZDST comes after the
CTZV? All I know that when testing NITZ with ifx modem, the time
notification is not emitted without my fix.

BR,
  Antti


--===============4758544803407463711==--

