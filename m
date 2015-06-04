Content-Type: multipart/mixed; boundary="===============7735475584585465284=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems provisioning APN from SIMs
Date: Thu, 04 Jun 2015 16:03:27 -0500
Message-ID: <5570BD1F.7000909@gmail.com>
In-Reply-To: <5570B3D5.8080304@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7735475584585465284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 >> Ordering should have nothing to do with it.
>>
>
> Yes, the ordering is relevant. We (like other ofono users I suspect)
> have to allow multiple APNs or the automatic provisioning process fails.
>
> Then, the first context found in serviceproviders.xml is what is used by
> default for the connection.
>
> An example of the problem is that if you use a major telco's SIM card in
> the UK - Vodafone, ofono will then default to using an ASDA mobile
> context because of the ordering, and this will fail.
>
> My feeling is that a larger provider like Vodafone or O2 should be the
> default, not ASDA mobile or GiffGaff, and this should thus come first
> (understanding that the Ofono project does not control this document)

It has been years since I wrote the provisioning plugin, but the intent =

was to fail if looking up MCC/MNC combo resulted in multiple matches. =

So this may be a bug, or you might be using some custom behavior.  But =

in the end, ordering of the entries should not affect the provisioning =

logic.

> Allowing Duplicates - Not by default no, but you have a boolean
> parameter in there and logic to allow for duplicate contexts, which we
> have to enable (as do others I think from my Googling on this) or the
> provisioning support is unusable with the upstream serviceproviders.xml
> as far as I can see.

Then that's the problem.  The intent was never to allow duplicates. =

That boolean was added for tools/lookup-apn only.

>
> I'm not entirely sure how the RilModem fork relates to Ofono but you can
> see they had the same problem
>
> /*
>
> 	* TODO: review with upstream. Default behavior was to
>
> 	* disallow duplicate APN entries, which unfortunately exist
>
> 	* in the mobile-broadband-provider-info db.
>
> 	*/
>
>
> ref: https://github.com/rilmodem/ofono/blob/master/plugins/provision.c#L55
>
> SPN - Thanks. This seems promising. I will investigate the SPN values
> further.

The real fix is to fix mobile-broadband-provider-info.

>
>>>
>>> I suspect our use case is similar to many others. We have a headless
>>> embedded Linux board and we want an installation technician to be able
>>> to put a SIM in, power the unit, and have everything else automated.
>>>
>>> It looks like we may have to implement a custom serviceproviders.xml,
>>> which would be a shame.
>>>
>>> I am wondering if there are any other algorithmic or configuration
>>> alternatives we can look at, such as Ofono trying different contexts
>>> until one works? Or some additional Ofono provisioning configuration?
>>>
>>
>> oFono can use any information present on the SIM to try and figure out
>> the SIM provider.  We already provide MCC, MNC and SPN to the
>> provisioning plugin.
>>
>> However, this really depends on the underlying provisioning database
>> to contain this information and do so in such a way that duplicates
>> are not possible.
>>
>
> I'll have a think about what might be achievable by adding SPN
> information into serviceproviders.xml.
>

Regards,
-Denis


--===============7735475584585465284==--

