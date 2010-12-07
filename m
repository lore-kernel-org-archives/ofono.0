Content-Type: multipart/mixed; boundary="===============1543234865305892356=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH 2/4] modem: add EmergencyMode property
Date: Tue, 07 Dec 2010 18:33:45 +0200
Message-ID: <AANLkTinLasRE-FfDkRqwFFW5fpCedKVh2iiuzy1BwyDz@mail.gmail.com>
In-Reply-To: <4CF942DE.4010004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1543234865305892356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Andras,

2010/12/3 Denis Kenzior <denkenz@gmail.com>:
> <snip>
>> +static void modem_change_online(struct ofono_modem *modem,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum modem_state new_state)
>> +{
>> + =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection();
>> + =C2=A0 =C2=A0 enum modem_state old_state =3D modem->modem_state;
>> + =C2=A0 =C2=A0 ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE=
_ONLINE;

I'd define a new enum modem_state for emergency mode, MODEM_STATE_EMERGENCY.

>> + =C2=A0 =C2=A0 DBG("old state: %d, new state: %d", old_state, new_state=
);
>> +
>> + =C2=A0 =C2=A0 if (new_online =3D=3D modem->online)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> You check for online not being equal here
>
>> +
>> + =C2=A0 =C2=A0 modem->modem_state =3D new_state;
>> + =C2=A0 =C2=A0 modem->online =3D new_online;
>> +
>> + =C2=A0 =C2=A0 ofono_dbus_signal_property_changed(conn, modem->path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_MODEM_INTERFA=
CE, "Online",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BOOLEAN, =
&modem->online);
>> +
>> + =C2=A0 =C2=A0 notify_online_watches(modem);
>> +}
>> +
>> +static void emergency_online_cb(const struct ofono_error *error, void *=
data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_modem *modem =3D data;
>> +
>> + =C2=A0 =C2=A0 DBG("modem: %p", modem);
>> +
>> + =C2=A0 =C2=A0 if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
modem->modem_state !=3D MODEM_STATE_ONLINE)
>
> And perform essentially the same check here... =C2=A0Seems wasteful
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modem_change_online(modem, M=
ODEM_STATE_ONLINE);
>> +}
>> +
>> +static void emergency_offline_cb(const struct ofono_error *error, void =
*data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_modem *modem =3D data;
>> + =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection();
>> + =C2=A0 =C2=A0 const char *path =3D ofono_modem_get_path(modem);
>> + =C2=A0 =C2=A0 gboolean state =3D FALSE;
>> +
>> + =C2=A0 =C2=A0 DBG("modem: %p", modem);
>> +
>> + =C2=A0 =C2=A0 if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
modem->modem_state =3D=3D MODEM_STATE_ONLINE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modem_change_online(modem, m=
odem->modem_state_pre_emergency);
>
> Same comment as above
>
>> +
>> + =C2=A0 =C2=A0 modem->emergency--;
>> +
>> + =C2=A0 =C2=A0 ofono_dbus_signal_property_changed(conn, path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_MODEM_INTERFA=
CE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Emergency",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_BOOLEAN,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &state);
>> +}
>> +
>> +void ofono_modem_inc_emergency(struct ofono_modem *modem)
>> +{
>> + =C2=A0 =C2=A0 DBusConnection *conn =3D ofono_dbus_get_connection();
>> + =C2=A0 =C2=A0 const char *path =3D ofono_modem_get_path(modem);
>> + =C2=A0 =C2=A0 gboolean state =3D TRUE;
>> +
>> + =C2=A0 =C2=A0 DBG("modem: %p", modem);
>> +
>> + =C2=A0 =C2=A0 modem->emergency++;
>> + =C2=A0 =C2=A0 if (modem->emergency > 1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 ofono_dbus_signal_property_changed(conn, path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OFONO_MODEM_INTERFACE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 "Emergency",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DBUS_TYPE_BOOLEAN,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &state);
>> +
>> + =C2=A0 =C2=A0 modem->modem_state_pre_emergency =3D modem->modem_state;
>> +
>> + =C2=A0 =C2=A0 if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> So my only major concern left is here actually. =C2=A0If we activate an
> emergency call and a set_property(Online, blah) is active, we get into
> some funny race conditions. =C2=A0I mentioned these to Pekka on IRC. =C2=
=A0But
> basically the worst one is if we have an Online=3DFalse operation pending.
> =C2=A0In this case your call proceeds, but then gets terminated shortly
> thereafter by the offline procedure ;)

That is a tricky problem. I'd say the most straightforward way is to
return an error if there is a pending operation and push these
problems up the stack. In any case dialer has to retry ecall if user
tries to make the emergency call just after or before moving device to
offline / removing SIM card / etc. However, I'm not sure if we can
propagate the error in all cases where ofono_modem_inc_emergency()
gets called.

In order to manage the worst case in best possible manner, I'd check
for set_online in progress here. Return FALSE from
ofono_modem_get_online() immediately after the set_online(FALSE) call
is made. Also, check the emergency state again in after set_online
callback response. The online/offline watches should be called before
the set_online() call. (I have no idea what we will do should
set_online(FALSE) fail)?

-- =

Pekka.Pessi mail at nokia.com

--===============1543234865305892356==--

