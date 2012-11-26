Content-Type: multipart/mixed; boundary="===============6878539814202466800=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v0 01/11] hfp_hf: Add HFP external Profile registration
Date: Mon, 26 Nov 2012 13:24:41 +0200
Message-ID: <20121126112441.GA25270@x220>
In-Reply-To: <20121126110841.GA24078@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6878539814202466800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> On Thu, Nov 22, 2012, Claudio Takahasi wrote:
> > +int bluetooth_register_profile(const char *uuid, const char *name,
> > +							const char *object)
> > +{
> > +	DBusMessageIter iter, dict;
> > +	DBusPendingCall *c;
> > +	DBusMessage *msg;
> > +
> > +	DBG("Bluetooth: Registering %s (%s) profile", uuid, name);
> > +
> > +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, "/org/bluez",
> > +			BLUEZ_PROFILE_MGMT_INTERFACE, "RegisterProfile");
> > +
> > +	dbus_message_iter_init_append(msg, &iter);
> > +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &object);
> > +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &uuid);
> > +
> > +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dic=
t);
> > +	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
> > +	dbus_message_iter_close_container(&iter, &dict);
> =

> You're missing the "AutoConnect" dict entry here. Without it HFP will
> not be connected using Device.Connect (only remotely initiated or with
> Device.ConnectProfile).

Actually never mind. I added the auto_connect value to the profile
defaults table on the BlueZ side so this is not needed in the
RegisterProfile method call.

Johan

--===============6878539814202466800==--

