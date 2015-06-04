Content-Type: multipart/mixed; boundary="===============2653154961520658128=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problems provisioning APN from SIMs
Date: Fri, 05 Jun 2015 00:30:43 +0200
Message-ID: <06BB02E7-AFCD-4DEA-A99A-DC57B1283E35@holtmann.org>
In-Reply-To: <5570CA31.6070002@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2653154961520658128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

>>>> Ordering should have nothing to do with it.
>>>> =

>>> =

>>> Yes, the ordering is relevant. We (like other ofono users I suspect)
>>> have to allow multiple APNs or the automatic provisioning process fails.
>>> =

>>> Then, the first context found in serviceproviders.xml is what is used by
>>> default for the connection.
>>> =

>>> An example of the problem is that if you use a major telco's SIM card in
>>> the UK - Vodafone, ofono will then default to using an ASDA mobile
>>> context because of the ordering, and this will fail.
>>> =

>>> My feeling is that a larger provider like Vodafone or O2 should be the
>>> default, not ASDA mobile or GiffGaff, and this should thus come first
>>> (understanding that the Ofono project does not control this document)
>> =

>> It has been years since I wrote the provisioning plugin, but the
>> intent was to fail if looking up MCC/MNC combo resulted in multiple
>> matches. So this may be a bug, or you might be using some custom
>> behavior.  But in the end, ordering of the entries should not affect
>> the provisioning logic.
>> =

>>> Allowing Duplicates - Not by default no, but you have a boolean
>>> parameter in there and logic to allow for duplicate contexts, which we
>>> have to enable (as do others I think from my Googling on this) or the
>>> provisioning support is unusable with the upstream serviceproviders.xml
>>> as far as I can see.
>> =

>> Then that's the problem.  The intent was never to allow duplicates.
>> That boolean was added for tools/lookup-apn only.
>> =

>>> =

>>> I'm not entirely sure how the RilModem fork relates to Ofono but you can
>>> see they had the same problem
>>> =

>>> /*
>>> =

>>>    * TODO: review with upstream. Default behavior was to
>>> =

>>>    * disallow duplicate APN entries, which unfortunately exist
>>> =

>>>    * in the mobile-broadband-provider-info db.
>>> =

>>>    */
>>> =

>>> =

>>> ref:
>>> https://github.com/rilmodem/ofono/blob/master/plugins/provision.c#L55
>>> =

>>> SPN - Thanks. This seems promising. I will investigate the SPN values
>>> further.
>> =

>> The real fix is to fix mobile-broadband-provider-info.
> =

> Yes I would agree with that.
> =

> As I come to investigate this, I find I am concerned about using the
> Service Provider Name as I can't see any registry for those names, it's
> free text for display purposes, so I assume it is at least possible it
> might change without warning,
> whereas there does seem to be a registry for MCC/MNC (e.g.
> http://www.mcc-mnc.com/)

actually the TS.25 database from GSMA is the authority. Seems to have over =
1800 entries at the moment, but a lot of operators are listed more than onc=
e. I think it is a combination of band + MCC + MNC.

The SPN is indeed free form and can change at any time (even during a phone=
 call). They are however a really good indication when you want to differen=
tiate MNVO. But it means you have to update your database. However that nee=
ds to happen anyway since even MCC and MNC change all the time. I think tha=
t TS.25 updates twice per month.

So some operators are actually assigned parts of the IMSI to their MNVO. I =
have seen operator documents clearly identifying which part of their ISMI p=
ool is for MNVO a, b, c etc. However that is the exception and not the rule=
. However one big operator could be easily and clearly identified if you ge=
t their documents.

> I am thinking it may be preferable to use the registered IIN number from
> the ICCID - http://www.controlf.net/iccid/
> =

> This seems a more controlled way of providing the uniqueness needed to
> me and presumably it's easy enough to read the ICCID out, if it's not
> already being read out.

As you saw by yourself, that is not going to help. The ICCID is pretty much=
 useless in this regard. It is listed in the TS.25 database, but I have no =
idea how accurate that is. Some operators only list the first 2 digits and =
some have no entry at all.

Keep in mind that TS.25 does not list MNVO and with that I am thinking that=
 ICCID prefix is free to assign by the operator. Same as the decision to us=
e parts of the IMSI to identify a MVNO. Some of them might really do not ca=
re at all and just map this internally without visibility to the user equip=
ment.

The reason why you can write your own provision plugin and create your own =
database is exactly this. oFono does not want to be in this business. That =
is up to the end product to put a proper database in place or write a smart=
er plugin that can use extra information from the device or SIM card. It is=
 plugin based for that exact reason. And I am surely providing something be=
tter than mobile-broadband-provider-info is easy and worth while doing. It =
is just not an oFono objective.

One thing we spent a lot of time on is to get the MNC length correct. Since=
 it can be 2 or 3 digits, we do make sure that whatever modem quirk it take=
s, we read the right value from the SIM card. Without this you would be in =
an even worse position.

Regards

Marcel


--===============2653154961520658128==--

