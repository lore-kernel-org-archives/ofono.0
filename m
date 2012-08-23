Content-Type: multipart/mixed; boundary="===============0767884460015223026=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] call-forwarding: class applied is the class given by
 SS code
Date: Thu, 23 Aug 2012 13:32:43 -0500
Message-ID: <5036774B.4040801@gmail.com>
In-Reply-To: <50364CA7.1070804@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0767884460015223026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

<snip>

>>> + /*
>>> + * Some modems don't understand all classes very well, particularly
>>> + * the older models. So if the bearer class is the default, we
>>> + * just use the more commonly understood value of 7 since BEARER_SMS
>>> + * is not applicable to CallForwarding conditions according to 22.004
>>> + * Annex A
>>> + */
>>> + if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
>>> + cls =3D BEARER_CLASS_DEFAULT;
>>> +
>>
>> Strictly speaking this is wrong. You cannot modify the cls here as it is
>> used to generate the reply in cf_ss_control_reply. Since
>> BEARER_CLASS_SS_DEFAULT !=3D BEARER_CLASS_DEFAULT you will generate the
>> wrong result.
>>
>
> OK, but I don't understand why we intend to generate a reply including
> classes for which we don't know the status?
>
> With BEARER_CLASS_SS_DEFAULT, we are considering the classes
> DataSync/DataAsync/Fax/Sms/Voice.

For some bizarre reason 22.030 specifies that all bearers are queried in =

the case that the mmi service code is omitted.  That means SMS as well. =

  However, half the bearers are not even applicable to call forwarding.

When reporting the results we report all bearers that were queried, even =

if some of them are not applicable or not known.  This is because we do =

not want to require the calling application to have any intelligence in =

this area.  It should simply display the results as given by oFono.

>
> But by default, the query is asking the status only for
> BEARER_CLASS_DEFAULT (Data/Fax/Voice).
> So, why, don't we match strictly the reply with the query?

We do, but querying with class is broken on many modems, hence the =

comment and why we optimize this case.  If we pass in an explicit mmi =

service code then that is what will be used instead.

If your question is why we always query with the default, the answer is =

why not?  Default literally means Voice, Data, Fax.  Where Data is =

equivalent to DataAsync | DataSync in 27.007.  So in effect we get a =

full set of results and we return only the applicable set to the =

application.  Just because the GCF testing methodology is broken in this =

area does not mean that this approach is incorrect.

Regards,
-Denis

--===============0767884460015223026==--

