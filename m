Content-Type: multipart/mixed; boundary="===============4710665236090915710=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: SIM Insertion Notification
Date: Sun, 15 Jul 2012 13:01:04 -0300
Message-ID: <1342368064.6450.3.camel@aeonflux>
In-Reply-To: <000001cd6287$3b37ebc0$b1a7c340$@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4710665236090915710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Brian,

> > > I'm running ofono 1.7, with a Cinterion PH8-P plugin I wrote and will
> > submit once I've fully tested it.  One problem I have is I never receive
> > notification of SIM insertion, i.e. the Present propertyChanged.  Looki=
ng
> > at the code it seems pretty obvious why, unless I'm (probably) missing
> > something.
> > >
> > > All the plugins, including mine, do similar to the following:
> > >
> > >      static void ph8_pre_sim(struct ofono_modem *modem)
> > >      {
> > >          struct ph8_data *data =3D ofono_modem_get_data(modem);
> > >          struct ofono_sim *sim;
> > >
> > >          ofono_devinfo_create(modem, 0, "atmodem", data->app);
> > >          sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION_PH8,
> > >                      "atmodem", data->app);
> > >
> > >          if (sim&&  data->have_sim =3D=3D TRUE)
> > >              ofono_sim_inserted_notify(sim, TRUE);
> > >      }
> > >
> > > The call to ofono_sim_create() probes the atmodem driver, which ends
> > with:
> > >
> > >      g_idle_add(at_sim_register, sim);
> > >
> > > So the subsequent call to ofono_sim_inserted_notify() will fail, as
> > at_sim_register() is called later when it is scheduled.
> > >
> > > The logs bear this out, so I'm at a loss to understand how anyone
> > receives a SIM notification... What am I missing here?
> > =

> > Everything is working as it should, what exactly is the problem?  You
> > can call ofono_sim_inserted_notify before the atom is registered, but
> > that means the Present property will be 'True' when you perform the
> > initial GetProperties call.
> > =

> > This is meant for devices which do not support SIM hot-swap (e.g. most
> > USB devices and many earlier phones where the SIM is behind the battery=
).
> =

> Thanks for the clarification, Denis.  That's what started me looking at t=
he
> Present propertyChanged, as I'd thought all property changes would be
> signalled without the need for a GetProperties first.
> =

> I'm using ofono-qt, and the only notifications I get are propertyChanged's
> for CardIdentifier, PreferredLanguages, SubscriberIdentity,
> MobileCountryCode and MobileNetworkCode.  I never get Present or any of t=
he
> other properties.
> =

> Turns out it's a problem with ofono-qt; it only does a GetProperties once
> when instantiating the SimManager, which is most likely before the interf=
ace
> is even available.  It never does it again, including when the SIM interf=
ace
> becomes available or if the SIM validity changes which could indicate a S=
IM
> swap.  I fixed this and all's working fine now, I'll forward my changes to
> the ofono-qt maintainer.

coming to think about this, it is actually an issue with our API at this
moment. When you add a modem, we do send you the current properties with
it, but when just an interface gets added, we don't. We should give you
the current properties in one go as well.

The API is stable, so we can not fix this until the next major version,
but a switch to D-Bus ObjectManager would clearly make this a lot simple
for application developers. Something for oFono 2.x series.

Regards

Marcel



--===============4710665236090915710==--

