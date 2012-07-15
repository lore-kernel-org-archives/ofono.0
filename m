Content-Type: multipart/mixed; boundary="===============6731224681210453178=="
MIME-Version: 1.0
From: Brian Ruptash <bruptash@gmail.com>
Subject: RE: SIM Insertion Notification
Date: Sun, 15 Jul 2012 14:42:00 +0200
Message-ID: <000001cd6287$3b37ebc0$b1a7c340$@gmail.com>
In-Reply-To: <500151BE.5010102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6731224681210453178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> On 07/14/2012 11:31 AM, Ruptash, Brian wrote:
> > I'm running ofono 1.7, with a Cinterion PH8-P plugin I wrote and will
> submit once I've fully tested it.  One problem I have is I never receive
> notification of SIM insertion, i.e. the Present propertyChanged.  Looking
> at the code it seems pretty obvious why, unless I'm (probably) missing
> something.
> >
> > All the plugins, including mine, do similar to the following:
> >
> >      static void ph8_pre_sim(struct ofono_modem *modem)
> >      {
> >          struct ph8_data *data =3D ofono_modem_get_data(modem);
> >          struct ofono_sim *sim;
> >
> >          ofono_devinfo_create(modem, 0, "atmodem", data->app);
> >          sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION_PH8,
> >                      "atmodem", data->app);
> >
> >          if (sim&&  data->have_sim =3D=3D TRUE)
> >              ofono_sim_inserted_notify(sim, TRUE);
> >      }
> >
> > The call to ofono_sim_create() probes the atmodem driver, which ends
> with:
> >
> >      g_idle_add(at_sim_register, sim);
> >
> > So the subsequent call to ofono_sim_inserted_notify() will fail, as
> at_sim_register() is called later when it is scheduled.
> >
> > The logs bear this out, so I'm at a loss to understand how anyone
> receives a SIM notification... What am I missing here?
> =

> Everything is working as it should, what exactly is the problem?  You
> can call ofono_sim_inserted_notify before the atom is registered, but
> that means the Present property will be 'True' when you perform the
> initial GetProperties call.
> =

> This is meant for devices which do not support SIM hot-swap (e.g. most
> USB devices and many earlier phones where the SIM is behind the battery).

Thanks for the clarification, Denis.  That's what started me looking at the
Present propertyChanged, as I'd thought all property changes would be
signalled without the need for a GetProperties first.

I'm using ofono-qt, and the only notifications I get are propertyChanged's
for CardIdentifier, PreferredLanguages, SubscriberIdentity,
MobileCountryCode and MobileNetworkCode.  I never get Present or any of the
other properties.

Turns out it's a problem with ofono-qt; it only does a GetProperties once
when instantiating the SimManager, which is most likely before the interface
is even available.  It never does it again, including when the SIM interface
becomes available or if the SIM validity changes which could indicate a SIM
swap.  I fixed this and all's working fine now, I'll forward my changes to
the ofono-qt maintainer.

Thanks again.

-- Brian



--===============6731224681210453178==--

