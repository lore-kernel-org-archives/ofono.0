Content-Type: multipart/mixed; boundary="===============7434093039888995233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Patch Description
Date: Fri, 26 Nov 2010 14:44:08 -0600
Message-ID: <4CF01C18.8070403@gmail.com>
In-Reply-To: <AANLkTikms4W-RTsmWuE9z1h1nRDC9-70+d9Y0j_nZ+Y2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7434093039888995233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/25/2010 05:25 PM, andrzej zaborowski wrote:
> Hi Yang,
> =

> On 25 November 2010 13:28, Yang Gu <yang.gu@intel.com> wrote:
>> This series of patch is to add provide local info support by requesting =
the terminal to send time and language info. Please comment on the followin=
g aspects as I'm not sure after reading the spec:
>> 1. Timezone may be a number in the range -47 through +48. In struct sms_=
scts, timezone is defined as gint8, thus 0xFF should shand for -1, which is=
 a valid input. Thus I think build_dataobj_datetime_timezone() in src/stkut=
il.c is not correct. But I'm still not sure what value should be passed to =
oFono when timezone is absent.
> =

> I think you're right that build_dataobj_datetime_timezone() is wrong.
> Also note that sms_decode_scts() and sms_encode_scts() only allow the
> range -47 to 47, 48 would return an error.  I'm not sure what the
> unknown time zone should be represented as, here are some options:
> =

> * 0 (same as no offset)
> * 0xff because there's currently no GMT-00:15 time zone on earth
> (http://en.wikipedia.org/wiki/List_of_time_zones_by_country)
> * 0x80 (a currently unused value could be #defined as unknown time zone)
> * the struct could be extended with a .has_tz boolean.

The has_tz variable gets my vote.  The rest looks ugly, and I don't
really see +48 as a valid value.

> =

>> 2. DBUS_TYPE_BYTE represents an 8-bit unsigned integer, and D-Bus doesn'=
t have a type related to 8-bit signed integer. So what's the best way to re=
present a timezone?
> =

> Maybe instead of asking D-bus, ofono should use tzset() to retrieve
> the time zone information and use localtime() for the other fields?

That is my preference as well.  Perhaps one can use the tm_gmtoff value
from struct tm to figure out the timezone.  See sms_scts_to_time for
more details.

Regards,
-Denis

--===============7434093039888995233==--

