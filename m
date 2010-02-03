Content-Type: multipart/mixed; boundary="===============1127429617298254562=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/3] Add radio access atom and driver API
Date: Wed, 03 Feb 2010 11:21:57 +0200
Message-ID: <1265188917.2557.132.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <201002021804.04244.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1127429617298254562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ke, 2010-02-03 kello 01:04 +0100, ext Denis Kenzior kirjoitti:
> It might be helpful to include the API documentation too.  One thing I do=
n't
> like is the name RadioAccess.  The connotation is a bit too low-level.
> Perhaps BandSelection? RadioBandSelection?

I thought about this quite a bit, but this was the best name I could
come up with. RadioAccessSelection, maybe, but then that'd be too
specific if we wanted to add a property.

And I think we definitely need to add at least one property here, a
boolean "Active" for when the radio link is active. This is used by
applications as a power saving measure to time their non-urgent data
traffic to only when the radio link is in CELL_DCH state already.

In fact, perhaps I should add that now while at it.

> I really prefer mode to be an enum here.  There's no standard to reference
> here...

Sure, should that go to include/types.h or src/common.h?

> > +void ofono_radio_access_mode_notify(struct ofono_radio_access
> >  *radio_access, +                                     int mode);
>
> Why do we have this function, can the radio mode be changed outside oFono=
's
> control?

This can happen if you are using the phone as a modem on the desktop,
and you change the setting on the phone.

> > +static DBusMessage *ra_get_properties(DBusConnection *conn, DBusMessage
> >  *msg, +                                      void *data)
> > +{
> > +     struct ofono_radio_access *ra =3D data;
> > +     DBusMessage *reply;
> > +     DBusMessageIter iter;
> > +     DBusMessageIter dict;
> > +
> > +     const char *mode =3D radio_access_mode_to_string(ra->mode);
> > +
> > +     reply =3D dbus_message_new_method_return(msg);
> > +     if (!reply)
> > +             return NULL;
> > +
> > +     dbus_message_iter_init_append(reply, &iter);
> > +
> > +     dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> > +                                     OFONO_PROPERTIES_ARRAY_SIGNATURE,
> > +                                     &dict);
> > +
> > +     ofono_dbus_dict_append(&dict, "Mode", DBUS_TYPE_STRING, &mode);
> > +
> > +     dbus_message_iter_close_container(&iter, &dict);
> > +
> > +     return reply;
> =

> The pattern used in the past was to query the mode from get_properties if=
 it
> was not cached.  Once the mode was cached, we set a flag and always retur=
ned
> the cached value.  I would do it the same way in this case to minimize fl=
ood of
> queries at modem startup.

I noticed call-forwarding was using it. However, when you have more than
one property to cache, of which some are optional, that initial chain of
queries to fill the cache gets a little nasty.

I've not seen problems in practice in filling the cache at modem
startup. (That's something CSD does.)

> Is querying the mode even a good idea?  Perhaps this should be yet another
> setting, stored by IMSI.

AFAIK, this is not an IMSI specific setting; it persists over a SIM
swap.

I'll create an updated set shortly.

Cheers,
Aki


--===============1127429617298254562==--

