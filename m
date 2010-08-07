Content-Type: multipart/mixed; boundary="===============4812099414927431391=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv2] STE-driver: Terminating voice call in state
 DIALING/ALERTING.
Date: Fri, 06 Aug 2010 19:22:38 -0500
Message-ID: <4C5CA74E.40107@gmail.com>
In-Reply-To: <AANLkTikmnTjmDBZO3ui3n=MQmnjEumg2kjHYzFX_aTTQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4812099414927431391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>>> +/* HACK: for temporary backwards compatibility */
>>> +#define hangup_all hangup
>>> +     void (*hangup_all)(struct ofono_voicecall *vc,
>>> +                     ofono_voicecall_cb_t cb, void *data);
>>> +     void (*hangup_active)(struct ofono_voicecall *vc,
>>
>> We'll need to figure out how to migrate to the new driver API a bit more
>> sanely.
> =

> Should we s/hangup/hangup_active in all drivers and skip this hack then?
> Or did you have something else in mind?

That sounds good.  Break this up into two patches, one renaming hangup
to hangup_active and the second one introducing hangup_all.

> =

> How do we proceede with this change. I am very happy if you carry on from=
 here,
> or would you like me to to submit a patch-set with these changes,
> including s/hangup/hangup_active in drivers/*/voicecall.c?

Go ahead and re-submit the fixed up patch set and I will take care of
the rest.

Regards,
-Denis

--===============4812099414927431391==--

