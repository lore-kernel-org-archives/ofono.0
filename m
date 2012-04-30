Content-Type: multipart/mixed; boundary="===============5587051130075550399=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wavecom: add support for Wavecom Q2403/Q2686 modems
Date: Sun, 29 Apr 2012 22:51:17 -0500
Message-ID: <4F9E0C35.2060404@gmail.com>
In-Reply-To: <20120430163747.GA8993@1984>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5587051130075550399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

>>> +	/* AT+CRSM not supported by Q2403. */
>>> +	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q) {
>>> +		unsigned char access[3] =3D { 0x00, 0x00, 0x00 };
>>> +
>>> +		CALLBACK_WITH_SUCCESS(cb, 4, 0, 0, access,
>>> +					EF_STATUS_VALID, data);
>>
>> Why don't you simply return an error here?
> =

> Without it, the modem initialization does not complete.

Can you fallback to CSIM?

<snip>

>>> -	snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
>>> -			store, store, incoming);
>>> +	if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q) {
>>> +		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
>>> +				store, store, incoming);
>>> +	} else {
>>> +		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\"", store);
>>> +	}
>>
>> There is no need for any curly braces.
> =

> You mean for both snprintf, right?
> =


Yep

>>> -		for (mem =3D 0; mem < 3; mem++) {
>>> +		/* Wavecom Q replies something like this:
>>> +		 *
>>> +		 * +CPMS: (("SM","BM","SR"),("SM"))
>>> +		 *
>>> +		 * It does not provide the way income messages are stored.
>>> +		 * 3GPP TS 07.05 allows mem2 and mem3 to be optional.
>>> +		 */
>>
>> Just how old is this modem and what version of 07.05 are you using?
>>
>> For reference, 07.05 version 7.0.1 from July 1999:
>> "
>> +CPMS=3D?
>> +CPMS: (list of supported <mem1>s),(list of supported <mem2>s),
>> (list of supported <mem3>s)
>> "
>>
>> So the comment should probably be changed to indicate that this modem is
>> just broken.
>>
> =

> From: "3.2.2 Preferred Message Storage +CPMS" (TS 07.05 July 1999):
> =

> +CPMS=3D<mem1>[, <mem2>[,<mem3>]]

That is a set operation, we're doing a support query.

<snip>

>>> @@ -1070,7 +1090,8 @@ static void at_cpms_query_cb(gboolean ok, GAtResu=
lt *result,
>>>  				goto out;
>>>  		}
>>>  =

>>> -		if (!sm_supported[2] && !me_supported[2] && !mt_supported[2])
>>> +		if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q &&
>>> +		    !sm_supported[2] && !me_supported[2] && !mt_supported[2])
>>
>> Please don't use spaces for indentation, always tabs
> =

> OK, so you prefer this, right?
> =

>         if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q &&
>                 !sm_supported[2] && !me_supported[2] && !mt_supported[2])
> =


See doc/coding-style.txt

if (... &&
<tab><tab>...)
<tab>Statement

<snip>

>> Are you sure you can't reuse the same behavior as OFONO_VENDOR_WAVECOM
>> quirk inside drivers/atmodem/sim.c?
> =

> Yes, I remember to have tried that. That quirk didn't work for me
> though.

I think we need to dig a bit deeper as to why, the VENDOR_WAVECOM
behavior seems to be addressing exactly this case.

>> This is probably wrong, I suspect we need to add a generic function to
>> register (real) serial tty based modems.
> =

> I should have added some add_wavecom function instead.
> =

> I used that because I noticed that:
> =

> add_sim900
> add_nokiacdma
> add_tc65
> ...
> and so on.
> =

> look the same. So I guess that it is indeed a good idea to remove
> redundant code and provide some generic one.
> =


If they are all the same, then adding a generic function is fine.

<snip>

>>> +OFONO_PLUGIN_DEFINE(wavecom_q, "Wavecom-Q driver", VERSION,
>>> +		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_q_init, wavecom_q_exit)
>>
>> Is there a way to just re-use the wavecom driver instead of creating a
>> brand new one?
> =

> I didn't find any cleaner solution I could like, but if you propose any
> other solution, I'll make it.

Right now to me it seems like the differences between the -Q version is
a slightly different set of quirks.  Can't we query the model / firmware
versions and set the quirks accordingly?

Regards,
-Denis

--===============5587051130075550399==--

