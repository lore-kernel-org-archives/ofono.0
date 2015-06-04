Content-Type: multipart/mixed; boundary="===============6764387796954921192=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problems provisioning APN from SIMs
Date: Fri, 05 Jun 2015 00:50:09 +0200
Message-ID: <28A32924-FC04-49AD-97CA-4AC835D0ED2E@holtmann.org>
In-Reply-To: <5570CA31.6070002@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6764387796954921192==
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
> =

> I am thinking it may be preferable to use the registered IIN number from
> the ICCID - http://www.controlf.net/iccid/
> =

> This seems a more controlled way of providing the uniqueness needed to
> me and presumably it's easy enough to read the ICCID out, if it's not
> already being read out.

and I stand corrected here. The TS.25 (formerly known as SE13) is just for =
collection of operator and networks if the need arises by the equipment to =
map them.

The actual MCC and MNC assignments are ITU T E.212 and the (U)SIM Header of=
 the ICCID is ITU T E.118 document.

And as a side note, the (U)SIM Header is between 6 and 7 digits. The MNC is=
 between 2 and 3 digits.

Regards

Marcel


--===============6764387796954921192==--

