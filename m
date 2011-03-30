Content-Type: multipart/mixed; boundary="===============5595831840702295910=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/3] core: notify watches of already registered atoms
Date: Wed, 30 Mar 2011 08:37:22 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D9E23@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D923464.5000401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5595831840702295910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> On 03/29/2011 02:48 AM, Mika Liljeberg wrote:
> > ---
> >  src/modem.c |   16 +++++++++++++++-
> >  1 files changed, 15 insertions(+), 1 deletions(-)
> > =

> > diff --git a/src/modem.c b/src/modem.c
> > index 655994b..d22c718 100644
> > --- a/src/modem.c
> > +++ b/src/modem.c
> > @@ -271,6 +271,9 @@ unsigned int =

> __ofono_modem_add_atom_watch(struct ofono_modem *modem,
> >  					void *data, =

> ofono_destroy_func destroy)
> >  {
> >  	struct atom_watch *watch;
> > +	unsigned int id;
> > +	GSList *l;
> > +	struct ofono_atom *atom;
> >  =

> >  	if (notify =3D=3D NULL)
> >  		return 0;
> > @@ -282,8 +285,19 @@ unsigned int =

> __ofono_modem_add_atom_watch(struct ofono_modem *modem,
> >  	watch->item.destroy =3D destroy;
> >  	watch->item.notify_data =3D data;
> >  =

> > -	return __ofono_watchlist_add_item(modem->atom_watches,
> > +	id =3D __ofono_watchlist_add_item(modem->atom_watches,
> >  					(struct =

> ofono_watchlist_item *)watch);
> > +
> > +	for (l =3D modem->atoms; l; l =3D l->next) {
> > +		atom =3D l->data;
> > +
> > +		if (atom->type !=3D type || atom->unregister =3D=3D NULL)
> > +			continue;
> > +
> > +		notify(atom, =

> OFONO_ATOM_WATCH_CONDITION_REGISTERED, data);
> > +	}
> > +
> > +	return id;
> >  }
> >  =

> >  gboolean __ofono_modem_remove_atom_watch(struct ofono_modem *modem,
> =

> This patch is behavior changing.  Whether this is a good idea =

> or not I'm
> still undecided, though I see its merits.
> =

> However, I don't see how it is fixing anything.  The watches =

> are called
> only upon registration (which means the driver is probed and =

> ready).  So
> even if you create two netreg atoms in hopes of probing the =

> modem type,
> only one should ever register and this code should not be needed.

I do have an actual bug, which this patch fixes. I've been investigating wh=
y, with isiusb, the gprs atom sometimes fails to receive the network regist=
ration status and therefore fails to attach to the GPRS service. It turns o=
ut that the problem comes from the client side code pattern for registering=
 atom watches. The code assumes that there will only be a single atom of th=
e same type (registered or not).

Basically, gprs atom and the alternative netreg atoms are probing in parall=
el and may register themselves in a random order. If gprs finishes first, i=
t will correctly get a call to its watch handler when one of the netreg ato=
ms completes its registration. However, if the order is reversed and gprs f=
inishes after the netreg atom, the following snippet of code tries to find =
the already registered netreg atom:

        netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETR=
EG);

        if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
                netreg_watch(netreg_atom,
                                OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs=
);

The trouble here is that __ofono_modem_find_atom() just returns the first n=
eterg atom it finds, regardless of whether it is registered or not. In this=
 case it happens to be the wrong netreg (wgmodem2.5 version, which fails to=
 probe), even though the other netreg atom is already present and registere=
d. Because of this, the watch funtion is never called.

I realize that there are other ways to fix this. The client side pattern co=
uld be changed to use __ofono_modem_foreach_atom() to look for already regi=
stered atoms, instead of doing the same within the __ofono_modem_add_atom_w=
atch() as in my patch. This would introduce quite a bit of more code. Alter=
natively, an __ofono_modem_find_registered_atom() function could be introdu=
ced to look for a registerd atom of a certain type (might be a good idea to=
 do this in any case). Or isiusb (and any other similar cases) could be rev=
ectored to not probe multiple atoms of the same type in parallel. However, =
we already create multiple GPRS context atoms as a matter of course, so the=
 assumption that there will only be a single instance is no longer valid fo=
r all atom types anyway. IMO, it would be good to get rid of the assumption=
 altogether.

So, I like my patch because it removes a lot of copy-paste code and does no=
t assume anything about how many atoms of a certain type there can be.

Regards,

	MikaL

--===============5595831840702295910==--

