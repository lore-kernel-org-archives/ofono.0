Content-Type: multipart/mixed; boundary="===============8280859894915046400=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] mbm: add quirks for Dell D5530
Date: Wed, 25 Aug 2010 20:40:17 +0200
Message-ID: <1282761617.6841.55.camel@localhost.localdomain>
In-Reply-To: <4C756104.90504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8280859894915046400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>>>> Dell D5530 is an OEM version of F3507g. It has an annoying habit of
> >>>>> announcing itself to world with its own name. It also crashes upon
> >>>>> processing received cbs messages.
> >>>>> ---
> >>>>>  plugins/mbm.c |   55 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++--
> >>>>>  1 files changed, 53 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/plugins/mbm.c b/plugins/mbm.c
> >>>>> index c9b0ea4..1c2b9a8 100644
> >>>>> --- a/plugins/mbm.c
> >>>>> +++ b/plugins/mbm.c
> >>>>> @@ -53,9 +53,15 @@ static const char *cfun_prefix[] =3D { "+CFUN:",=
 NULL };
> >>>>>  static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> >>>>>  static const char *none_prefix[] =3D { NULL };
> >>>>>  =

> >>>>> +enum mbm_variant {
> >>>>> +	MBM_GENERIC,
> >>>>> +	MBM_DELL_D5530,		/* OEM of F3507g */
> >>>>> +};
> >>>>> +
> >>>>>  struct mbm_data {
> >>>>>  	GAtChat *modem_port;
> >>>>>  	GAtChat *data_port;
> >>>>> +	enum mbm_variant variant;
> >>>>>  	guint poll_source;
> >>>>>  	guint poll_count;
> >>>>>  	gboolean have_sim;
> >>>>> @@ -137,9 +143,50 @@ static gboolean init_simpin_check(gpointer use=
r_data)
> >>>>>  	return FALSE;
> >>>>>  }
> >>>>>  =

> >>>>> +static void d5530_notify(GAtResult *result, gpointer user_data)
> >>>>> +{
> >>>>> +	DBG("D5530");
> >>>>> +}
> >>>>> +
> >>>>
> >>>> Should we really bother with this one? Or you're trying to be like
> >>>> Marcel and waste some processing time with unused unsolicited
> >>>> notifications? :)
> >>>
> >>> I think we should until we have this all figured out. More debug outp=
ut
> >>> is always a good thing.
> >>>
> >>> And yes, essentially there is some processing wasted, but then again,
> >>> this hardware is so damn stupid broken it deserves to be punished ;)
> >>>
> >>
> >> I have to disagree, I can understand if you take the unsolicited
> >> notification and break it down somewhat (like we used to with OCTI,
> >> OWCTI, etc for HSO).  But just printing a debug seems useless.
> > =

> > then lets break it down ;)
> > =

> > 	DBG("D");
> > 	DBG("5");
> > 	DBG("5");
> > 	DBG("3");
> > 	DBG("0");
> > =

> =

> Funny ;)
> =

> I meant more like, if you don't g_at_result_iter_init() in the callback,
> then don't bother registering for it in the first place.

I figured that and I am fine with your argumentation to not do it, but I
just couldn't resit on this one ;)

Regards

Marcel



--===============8280859894915046400==--

