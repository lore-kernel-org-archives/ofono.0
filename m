Content-Type: multipart/mixed; boundary="===============4028319276053568425=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 0/3] Patch Description
Date: Fri, 26 Nov 2010 00:25:49 +0100
Message-ID: <AANLkTikms4W-RTsmWuE9z1h1nRDC9-70+d9Y0j_nZ+Y2@mail.gmail.com>
In-Reply-To: <1290688142-14726-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4028319276053568425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 25 November 2010 13:28, Yang Gu <yang.gu@intel.com> wrote:
> This series of patch is to add provide local info support by requesting t=
he terminal to send time and language info. Please comment on the following=
 aspects as I'm not sure after reading the spec:
> 1. Timezone may be a number in the range -47 through +48. In struct sms_s=
cts, timezone is defined as gint8, thus 0xFF should shand for -1, which is =
a valid input. Thus I think build_dataobj_datetime_timezone() in src/stkuti=
l.c is not correct. But I'm still not sure what value should be passed to o=
Fono when timezone is absent.

I think you're right that build_dataobj_datetime_timezone() is wrong.
Also note that sms_decode_scts() and sms_encode_scts() only allow the
range -47 to 47, 48 would return an error.  I'm not sure what the
unknown time zone should be represented as, here are some options:

* 0 (same as no offset)
* 0xff because there's currently no GMT-00:15 time zone on earth
(http://en.wikipedia.org/wiki/List_of_time_zones_by_country)
* 0x80 (a currently unused value could be #defined as unknown time zone)
* the struct could be extended with a .has_tz boolean.

> 2. DBUS_TYPE_BYTE represents an 8-bit unsigned integer, and D-Bus doesn't=
 have a type related to 8-bit signed integer. So what's the best way to rep=
resent a timezone?

Maybe instead of asking D-bus, ofono should use tzset() to retrieve
the time zone information and use localtime() for the other fields?

> 3. Only one byte is used to represent the year. Is the following logic co=
rrect to get the year with one byte?
> if (year_dbus >=3D 2000)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0year =3D year_dbus - 2000;
> else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0year =3D year_dbus - 1900;

I believe this is correct.

Best regards

--===============4028319276053568425==--

