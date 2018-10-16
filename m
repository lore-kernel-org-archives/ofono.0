Content-Type: multipart/mixed; boundary="===============5971969159774429895=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] atmodem/lte: Gemalto vendor specific extension
Date: Tue, 16 Oct 2018 13:06:53 -0500
Message-ID: <860a87d3-266a-2e4d-1a3c-baa0c429cb81@gmail.com>
In-Reply-To: <CAKSBH7Fc4stwyMZnGWpR4VAjMBqWZVR0kuJNCLppL=gzrqj8wA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5971969159774429895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,
>>> +static int gemalto_get_auth_type(enum ofono_gprs_auth_method auth_meth=
od)
>>> +{
>>> +     switch (auth_method) {
>>> +     case OFONO_GPRS_AUTH_METHOD_PAP:
>>> +             return 1;
>>> +     case OFONO_GPRS_AUTH_METHOD_CHAP:
>>> +             return 2;
>>> +     case OFONO_GPRS_AUTH_METHOD_NONE:
>>> +             return 0;
>>> +     }
>>> +
>>> +     return 0;
>>
>> This looks to be exact same enumeration that 27.007 uses...?
> =

> yes, and?
> I still need to convert the enum to int. Is there a function somewhere?

Right.  So what I'm hinting at is that this should be a generic utility =

method inside atutil.c (with no gemalto_ prefix) and you can simply use =

that.

> =

>>
>>> +}
>>> +
>>> +gboolean gemalto_get_auth_command(struct ofono_modem *modem, int cid,
>>> +                             enum ofono_gprs_auth_method auth_method,
>>> +                             const char *username, const char *passwor=
d,
>>> +                             char *buf, guint buflen)
>>> +{
>>> +     int gemalto_auth =3D ofono_modem_get_integer(modem, "GemaltoAuthT=
ype");
>>
>> Why don't you just simply pass the gemalto auth into this function
>> directly instead of having to pass in the modem object?
> =

> Because I need to pass further values in the future.
> I still need handle the auto-provisioned modems.
> I prefer that the calling function doesn't have to know how the buffer
> is filled:
> it will just receive the command.

I wouldn't do it this way, but okay.  I don't much care how the vendor =

specific stuff looks :)  You may want to consider returning a newly =

allocated char * in this case to make the caller's job a bit easier.  I =

get a bit twitchy once the number of function arguments exceeds 5-6.

> =

>>
>>> +     int len;
>>> +     /*
>>> +      * 0x01: use sgauth (0=3Duse cgauth)
>>> +      * 0x02: pwd, user order (0=3Duser, pwd order)
>>> +      * 0x04: always use all: method, user, password
>>> +      */
>>
>> But certain combinations are not valid?  E.g. can we have a +CGAUTH with
>> a wrong username/password order?
> =

> yes, out of the 8 combinations possible, today I have counted 5 (the
> R&D can be very creative sometimes),
> If the point is to enumerate the configurations instead, this is how I
> handled it in a previous submit, but was much worst
> because there were switch-cases with 1, 2, or 3 labels together.
> At least like this it is clear what the code is doing.
> =


Okay, fair enough.  You might want to add a comment about which =

combinations are not possible.

>>
>> Have you considered simply writing a gemalto specific gprs.c driver that
>> will use SGAUTH and using the default atmodem one on the sane devices?
> =

> Even CGAUTH is not completely standard for some models, some require
> all parameters for auth=3DNONE.
> Besides, gemalto doesnt use the CID=3D0 as in the standard.
> =

> There are no sane and insane modems. At most standard and proprietary.

Lol, trust me there are :)  I've seen many insane ones and a few that =

are mostly sane.  The weird situation with +CGAUTH requiring all =

arguments can be VENDOR-ized in the atmodem lte driver easily.  But the =

use of +SGAUTH and stuff probably requires a separate vendor driver =

anyway.  So if you want to just lump this all into =

drivers/gemaltomodem/lte.c I'd be okay with that.

>>
>>> +                     guint cid, enum ofono_gprs_proto proto, const cha=
r *apn,
>>> +                                                     char *buf, guint =
buflen)
>>
>> Why is CGDCONT specific to gemalto?  This looks pretty standard
> =

> CID=3D1 for the default APN (for the current models).
> And because for auto-provisioning models I need to return a totally
> different command in some cases (like: 'AT').
> And there are no cgdcont-building functions around.
> =


I thought the default APN was cid=3D0.

Why don't we create a CGDCONT builder inside atutil.c and you can use =

that.  If you need some special ones then you can write a gemalto =

specific version later that can do something like:

gemalto_get_cgdcont()
{
	if (27007-compliant)
		return at_util_get_cgdcont();

	/* do stuff */
}

>>> +static inline int at_util_convert_signal_strength_cesq(int strength_GS=
M,
>>> +                                     int strength_UTRAN, int strength_=
EUTRAN)
>>> +{
>>> +     int result =3D -1;
>>> +
>>> +     if (strength_GSM !=3D 99)
>>> +             result =3D (strength_GSM * 100) / 63;
>>> +     else if (strength_UTRAN !=3D 255)
>>> +             result =3D (strength_UTRAN * 100) / 96;
>>> +     else if (strength_EUTRAN !=3D 255)
>>> +             result =3D (strength_EUTRAN * 100) / 97;
>>> +
>>> +     return result;
>>> +}
>>> +
>>
>> How is this related to the current patch?
> =

> Sorry, I didn't see it. However I did submit a patch for it on the
> 21.09.2018 on which I have never received any feedback.
> =


There are too many patches flying about.  Just resubmit the relevant series.

Regards,
-Denis

--===============5971969159774429895==--

