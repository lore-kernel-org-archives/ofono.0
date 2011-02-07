Content-Type: multipart/mixed; boundary="===============3049490406643923180=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 03/12] gprs: core support for IPv6
Date: Mon, 07 Feb 2011 10:12:15 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2985E3@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <4D4C3C49.2000807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3049490406643923180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +struct pri_context;
> > +
> >  struct ofono_gprs_context {
> >  	struct ofono_gprs *gprs;
> > +	struct pri_context *pri;
> >  	enum ofono_gprs_context_type type;
> > -	ofono_bool_t inuse;
> =

> I don't see how getting rid of this is not a good idea.  As =

> soon as the
> context driver is assigned to a context being activated we set it as
> 'inuse'.  If you don't set this variable then it is possible =

> to pick the
> same driver, even if that driver is busy but has not started =

> to set its
> settings yet.

The pri pointer points to the owner of the context driver. It is assigned w=
hen the context driver is allocated and cleared when the context driver is =
released. Therefore, the inuse flag becomes redundant. It is enough to chec=
k if pri !=3D NULL to know if the context is in use.

> > +static gboolean assign_context(struct pri_context *ctx)
..
> > +static void release_context(struct pri_context *ctx)
..
> For something like this I'd really like to see it in a separate patch.
> You're moving the function and also modifying the =

> implementation.  It is
> much easier to review a patch set if you move a function in one patch
> and then modify its behavior in another.  Same with =

> release_context.  It
> is probably a good idea to put the common code in here, but modify the
> behavior as a part of a different patch.

Ok, I'll split it out. I decided to do this when in the middle of making my=
 changes I noticed that the release code is actually copy pasted many times=
 over.

> Ideally this patch should be at least 2:
> - For moving assign_context and factoring out common code into
> release_context
> - The rest of this patch + modifications to the two above.

Will do.

> > +static struct context_settings *get_settings(struct =

> ofono_gprs_context *gc)
> > +{
> > +	if (gc =3D=3D NULL || gc->pri =3D=3D NULL)
> > +		return NULL;
> > +
> > +	if (gc->pri->settings =3D=3D NULL)
> > +		gc->pri->settings =3D g_try_new0(struct =

> context_settings, 1);
> > +
> =

> I appreciate the lazy allocation, however you get into trouble if the
> driver calls one of the _set functions but still returns a failure in
> the callback.  Overall this seems a more complicated approach than
> returning values in the callback of activate_primary.

Oops. I thought I had the failure path covered but this bit changed from th=
e RFC patches. The lazy allocation is a remnant from having separate dicts =
for IPv4 and IPv6 settings. I'll get rid of it.

> > +void ofono_gprs_context_set_interface(struct =

> ofono_gprs_context *gc,
> > +					const char *interface)
> > +{
> > +	struct context_settings *settings =3D get_settings(gc);
> > +
> > +	if (settings =3D=3D NULL || settings->interface !=3D NULL)
> > +		return;
> =

> I'd let the driver call these functions as often as they want and just
> take the last value.

Ok. Makes sense.

Regards,

	MikaL

--===============3049490406643923180==--

