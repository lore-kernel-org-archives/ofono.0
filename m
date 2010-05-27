Content-Type: multipart/mixed; boundary="===============1660810771270375170=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 3/4] Add: set_online and post_online methods to isimodem
 driver
Date: Thu, 27 May 2010 15:34:06 +0300
Message-ID: <AANLkTilgxwBpRZHSUB1oVNAhVELPLPFnOaKVdxpLFYIo@mail.gmail.com>
In-Reply-To: <201005262108.37085.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1660810771270375170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/5/27 Denis Kenzior <denkenz@gmail.com>:
>> +static bool mtc_state_cb(GIsiClient *client, const void *restrict data,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, uint16_t object, void *opaque)
>
> We don't use bools in oFono, please fix this to use gboolean or an int.

Huh?

int ofono_modem_set_boolean(struct ofono_modem *modem,
				const char *key, bool value);
bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key);

There are also some inconsistent usage of ofono_bool_t and
dbus_bool_t, mostly they are assumed to be the same type.

-- =

Pekka.Pessi mail at nokia.com

--===============1660810771270375170==--

