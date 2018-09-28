Content-Type: multipart/mixed; boundary="===============1410022576212137015=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/gprs: added autoattach handling
Date: Fri, 28 Sep 2018 07:41:24 +0200
Message-ID: <CAKSBH7GAHVsX1J6ESLcVS5_7D0B5VsCrxzpy7zCqJZ4WQsX7cw@mail.gmail.com>
In-Reply-To: <8a93003d-85dd-0c00-1710-9db8c5bb8c81@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1410022576212137015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 5:49 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hii Giacinto,
>
> On 09/23/2018 12:21 AM, Giacinto Cifelli wrote:
> > In case of LTE modem, attaching manually is normally unneeded.
> > Forcing a detach (in case of gprs-context activation failure) is
> > actually a mistake, also because this will also trigger a technology
> > reselection and a possible invalid state, especially for LTE-only
> > modems.
>
> Okay, so it sounds like the core src/gprs.c logic is not taking
> technology into account.   Should this be fixed there?
>
> >
> > This simple patch adds a flag to skip the AT+CGATT=3Dx command.
> > The flag is to be set by vendor-specific options.
> >
> > By default the behavior remains unchanged.
> > ---
> >   drivers/atmodem/gprs.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> > index 6e01738a..fc0d8aa3 100644
> > --- a/drivers/atmodem/gprs.c
> > +++ b/drivers/atmodem/gprs.c
> > @@ -59,6 +59,7 @@ struct gprs_data {
> >       gboolean has_cereg;
> >       gboolean has_c5greg;
> >       gboolean nb_inds;
> > +     gboolean auto_attach; /* for LTE modems & co */
> >       int attached;
> >       int cgreg_status;
> >       int cereg_status;
> > @@ -88,9 +89,15 @@ static void at_gprs_set_attached(struct ofono_gprs *=
gprs, int attached,
> >                                       ofono_gprs_cb_t cb, void *data)
> >   {
> >       struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> > -     struct cb_data *cbd =3D cb_data_new(cb, data);
> > +     struct cb_data *cbd;
> >       char buf[64];
> >
> > +     if (gd->auto_attach) {
> > +             CALLBACK_WITH_SUCCESS(cb, data);
> > +             return;
> > +     }
> > +
>
> You can't really do that though.  It is fully possible for a modem to
> roam off LTE onto 3G and not be attached...  So we still need tosend
> +CGATT in this case.

You can't really do that, either. It is possible that the module hops
off LTE for a CSFB call of for a simple SMS, and the current logic
will send immediately AT+CGATT=3D0 which will wreak havoc: the contexts
that should be handed-over or suspended are released, and the module
is never able to return to LTE because forced to detach.
I didn't see the call drop in my tests, but it is not impossible that
some modules would also do that as a consequence.
I didn't test on the move or with a simulator, but I suppose also in
case of HO LTE->3G we have the same scenario.

For Gemalto modules it is kind of mandatory to let the module handle
the attach by itself if it supports LTE, and I believe also for other
vendors, hence the autoattach flag.

Maybe the data-roaming logic should move from attach to context activation.
Also the operators expect it to work this way nowadays, even for
pre-LTE modules.

>
> > +     cbd =3D cb_data_new(cb, data);
> >       snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
> >
> >       if (g_at_chat_send(gd->chat, buf, none_prefix,
> >
>
> Regards,
> -Denis

--===============1410022576212137015==--

