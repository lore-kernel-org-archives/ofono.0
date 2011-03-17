Content-Type: multipart/mixed; boundary="===============3785696032949372328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Thu, 17 Mar 2011 10:00:45 -0500
Message-ID: <4D82221D.3070401@gmail.com>
In-Reply-To: <1300350356.8348.76.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3785696032949372328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>>
>> So correct me if I'm wrong, but I don't think we can do that.  the
>> current cf_conditions implementation stores all conditions, which could
>> be unrelated to voice; and if my interpretation of 22.004 is correct you
>> can have something like this:
>>
>> Activate CFB for all services to Number 1
>> Activate CFU for Data services to Number 2
>>
>> Which results in cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] not
>> being NULL and you reporting CFB for voice incorrectly.
>>
>> You are probably safer using is_cfu_enabled() function.
> =

> As far as I know scenario you describe cannot happen with oFono. There
> is no data related conditions in the call forwarding API. Sure, you can
> set data forwarding on using SS API, but I don't see how data forwarding
> states could be shown in call forwarding API when all states in API
> start with word "voice". Also according to comments in code fax and data
> are not supported. =

>

It can.  oFono stores _all_ conditions in its lists.  However, it
filters them when reporting the conditions in get_properties or signals.
 This is why is_cfu_enabled function looks the way it does.  So a
scenario like this is fully possible.  Not to mention that the CFs are
queried for all services by default.

Regards,
-Denis

--===============3785696032949372328==--

