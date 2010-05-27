Content-Type: multipart/mixed; boundary="===============8991367624325409046=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Add: set_online and post_online methods to isimodem
 driver
Date: Thu, 27 May 2010 07:48:21 -0500
Message-ID: <201005270748.21704.denkenz@gmail.com>
In-Reply-To: <AANLkTilgxwBpRZHSUB1oVNAhVELPLPFnOaKVdxpLFYIo@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8991367624325409046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> 2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> >> +static bool mtc_state_cb(GIsiClient *client, const void *restrict dat=
a,
> >> +                             size_t len, uint16_t object, void *opaqu=
e)
> >
> > We don't use bools in oFono, please fix this to use gboolean or an int.
> =

> Huh?
> =

> int ofono_modem_set_boolean(struct ofono_modem *modem,
> 				const char *key, bool value);
> bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key);

Then that is a bug and needs to be fixed to use ofono_bool_t.  Things do =

sometimes fall through the cracks...

> =

> There are also some inconsistent usage of ofono_bool_t and
> dbus_bool_t, mostly they are assumed to be the same type.
> =


Patches are welcome.

Regards,
-Denis

--===============8991367624325409046==--

