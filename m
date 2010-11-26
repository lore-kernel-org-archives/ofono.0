Content-Type: multipart/mixed; boundary="===============4561182357641596296=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 0/3] Patch Description
Date: Fri, 26 Nov 2010 11:29:24 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473306DEEA7@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTikms4W-RTsmWuE9z1h1nRDC9-70+d9Y0j_nZ+Y2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4561182357641596296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>andrzej zaborowski
>Sent: Friday, November 26, 2010 7:26 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 0/3] Patch Description
>
>Hi Yang,
>
>On 25 November 2010 13:28, Yang Gu <yang.gu@intel.com> wrote:
>> This series of patch is to add provide local info support by requesting =
the terminal to
>send time and language info. Please comment on the following aspects as I'=
m not
>sure after reading the spec:
>> 1. Timezone may be a number in the range -47 through +48. In struct sms_=
scts,
>timezone is defined as gint8, thus 0xFF should shand for -1, which is a va=
lid input.
>Thus I think build_dataobj_datetime_timezone() in src/stkutil.c is not cor=
rect. But I'm
>still not sure what value should be passed to oFono when timezone is absen=
t.
>
>I think you're right that build_dataobj_datetime_timezone() is wrong.
>Also note that sms_decode_scts() and sms_encode_scts() only allow the
>range -47 to 47, 48 would return an error.  I'm not sure what the
>unknown time zone should be represented as, here are some options:
>
>* 0 (same as no offset)
>* 0xff because there's currently no GMT-00:15 time zone on earth
>(http://en.wikipedia.org/wiki/List_of_time_zones_by_country)
>* 0x80 (a currently unused value could be #defined as unknown time zone)
>* the struct could be extended with a .has_tz boolean.

Personally I'd prefer has_tz Boolean, which is consistent with other struct=
s. =


>
>> 2. DBUS_TYPE_BYTE represents an 8-bit unsigned integer, and D-Bus doesn't
>have a type related to 8-bit signed integer. So what's the best way to rep=
resent a
>timezone?
>
>Maybe instead of asking D-bus, ofono should use tzset() to retrieve
>the time zone information and use localtime() for the other fields?

If we don't need to ask D-Bus, we'd not bother defining the situation when =
timezone is absent. Denis, what's the requirement here?
Andrew, thanks for the comments in the other mail thread. I accept them all=
, but I will modify the patch until we're clear on this requirement. =



Regards,
-Yang

--===============4561182357641596296==--

