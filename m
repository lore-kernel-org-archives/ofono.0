Content-Type: multipart/mixed; boundary="===============5770422139596330056=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Add radio access atom and driver API
Date: Wed, 03 Feb 2010 11:03:34 -0600
Message-ID: <9b1cac641002030903v571c09a7s248f6aff8cfe05df@mail.gmail.com>
In-Reply-To: <1265188917.2557.132.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5770422139596330056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On Wed, Feb 3, 2010 at 3:21 AM, Aki Niemi <aki.niemi@nokia.com> wrote:
> ke, 2010-02-03 kello 01:04 +0100, ext Denis Kenzior kirjoitti:
>> It might be helpful to include the API documentation too. =C2=A0One thin=
g I don't
>> like is the name RadioAccess. =C2=A0The connotation is a bit too low-lev=
el.
>> Perhaps BandSelection? RadioBandSelection?
>
> I thought about this quite a bit, but this was the best name I could
> come up with. RadioAccessSelection, maybe, but then that'd be too
> specific if we wanted to add a property.
>
> And I think we definitely need to add at least one property here, a
> boolean "Active" for when the radio link is active. This is used by
> applications as a power saving measure to time their non-urgent data
> traffic to only when the radio link is in CELL_DCH state already.

How about we keep this simple and not try to overstuff this interface?
 Name it something like RadioPreferences or RadioSettings or
BandSettings, and put two things on here:
- Selection of technology 2G/3G/Dual
- Perhaps selection of band

The DCH state can go to some other interface and discussed in detail there.

>> > +void ofono_radio_access_mode_notify(struct ofono_radio_access
>> > =C2=A0*radio_access, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int mode);
>>
>> Why do we have this function, can the radio mode be changed outside oFon=
o's
>> control?
>
> This can happen if you are using the phone as a modem on the desktop,
> and you change the setting on the phone.

Then you're opening up a huge can of worms here.  Most interfaces will
be utterly and completely broken if you allow modem access outside
oFono's control.

In fact this whole approach seems wrong to me.  Why should we bother
querying the setting at all?  Simply read it from storage (default it
to something sane, like 2G+3G if no setting exists) and always send
the set_mode at startup.  Then get rid of the notify function, this
has to be taken care of by the ModemEmulator.

>
>> > +static DBusMessage *ra_get_properties(DBusConnection *conn, DBusMessa=
ge
>> > =C2=A0*msg, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0void *data)
>> > +{
>> > + =C2=A0 =C2=A0 struct ofono_radio_access *ra =3D data;
>> > + =C2=A0 =C2=A0 DBusMessage *reply;
>> > + =C2=A0 =C2=A0 DBusMessageIter iter;
>> > + =C2=A0 =C2=A0 DBusMessageIter dict;
>> > +
>> > + =C2=A0 =C2=A0 const char *mode =3D radio_access_mode_to_string(ra->m=
ode);
>> > +
>> > + =C2=A0 =C2=A0 reply =3D dbus_message_new_method_return(msg);
>> > + =C2=A0 =C2=A0 if (!reply)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> > +
>> > + =C2=A0 =C2=A0 dbus_message_iter_init_append(reply, &iter);
>> > +
>> > + =C2=A0 =C2=A0 dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRA=
Y,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_PROPERTIE=
S_ARRAY_SIGNATURE,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &dict);
>> > +
>> > + =C2=A0 =C2=A0 ofono_dbus_dict_append(&dict, "Mode", DBUS_TYPE_STRING=
, &mode);
>> > +
>> > + =C2=A0 =C2=A0 dbus_message_iter_close_container(&iter, &dict);
>> > +
>> > + =C2=A0 =C2=A0 return reply;
>>
>> The pattern used in the past was to query the mode from get_properties i=
f it
>> was not cached. =C2=A0Once the mode was cached, we set a flag and always=
 returned
>> the cached value. =C2=A0I would do it the same way in this case to minim=
ize flood of
>> queries at modem startup.
>
> I noticed call-forwarding was using it. However, when you have more than
> one property to cache, of which some are optional, that initial chain of
> queries to fill the cache gets a little nasty.

Again, I maintain this is a symptom of trying to overstuff the
interface.  Please keep it simple.

>
> I've not seen problems in practice in filling the cache at modem
> startup. (That's something CSD does.)
>

First of all you're dealing with sane modems.  Most modems are not as
nice and shiny as the Nokia ones.  Secondly, the goal for oFono is
performance, particularly at startup.  If something should not need to
be queries at startup, then don't.

>> Is querying the mode even a good idea? =C2=A0Perhaps this should be yet =
another
>> setting, stored by IMSI.
>
> AFAIK, this is not an IMSI specific setting; it persists over a SIM
> swap.

Unless there's a very specific use case for why it should be a
per-modem setting, I suggest to make it per-IMSI.  GPRS settings are
also not stored on a per-SIM basis on most mobile phones.  Quite
frankly that makes no sense.  Lets not step on a rake yet again.

Regards,
-Denis

--===============5770422139596330056==--

