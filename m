Content-Type: multipart/mixed; boundary="===============6965007360686975259=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Fri, 05 Feb 2010 00:01:16 +0200
Message-ID: <a32762a21002041401y57ad45abob5e5bc22bc54292@mail.gmail.com>
In-Reply-To: <201002041428.41922.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6965007360686975259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/2/4 Denis Kenzior <denkenz@gmail.com>:
>> +typedef void (*ofono_radio_settings_mode_query_cb_t)(const struct
>> =C2=A0ofono_error *error, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum ofono_radio_access=
_mode mode,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *data);
>
> I still say this part is not required.
>
>> +
>> +struct ofono_radio_settings_driver {
>> + =C2=A0 =C2=A0 const char *name;
>> + =C2=A0 =C2=A0 int (*probe)(struct ofono_radio_settings *rs, unsigned i=
nt vendor, void
>> =C2=A0*data); + =C2=A0 =C2=A0void (*remove)(struct ofono_radio_settings =
*rs);
>> + =C2=A0 =C2=A0 void (*query_mode)(struct ofono_radio_settings *rs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_radio_settings_mode_query_cb_t cb, void *=
data);
>
> Neither is query_mode. =C2=A0This is a local modem setting, not a network=
 setting.
> There's simply no reason to query it when oFono can store the settings.

Even with storage, it's needed the very first time a new SIM card is
inserted, no?

> Lets just add ability to read the mode setting from storage and set it at
> interface startup.

I can agreee to storing SIM data, but for other settings that are
anyway saved on the modem's non-volatile memory, this seems wrong.
oFono is aimed to be usable also on the desktop using tethering, which
means most of the time these settings are touched on the phone.

(As an aside, I have right now two N900s connected to my laptop via
USB, and was just making calls between them using oFono and d-feet.)

>> + =C2=A0 =C2=A0 void (*set_mode)(struct ofono_radio_settings *rs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ofono_radio_access_mode mode,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_radio_settings_mode_set_cb_t cb, void *da=
ta);
>
> Should this be called something else? E.g. set_technology or set_rat_mode.

Makes sense.

>> +#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
>> +#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
>> +
>
> Double define?

Too much coffee.

> Otherwise it looks good to me.

Cool. I will make the changes and push in a bit.

Cheers,
Aki

--===============6965007360686975259==--

