Content-Type: multipart/mixed; boundary="===============6318366146946061621=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Tue, 10 Jan 2012 16:37:29 +0100
Message-ID: <4F0C5B39.5090107@linux.intel.com>
In-Reply-To: <4F096BF1.5020406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6318366146946061621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>>>>>    struct speedup_data {
>>>>>>        GAtChat *modem;
>>>>>>        GAtChat *aux;
>>>>>>        gboolean have_sim;
>>>>>>        struct at_util_sim_state_query *sim_state_query;
>>>>>> +    gboolean have_gsm;
>>>>>> +    gboolean have_cdma;
>>>>> It might be a good idea to use a single gboolean, or better yet an en=
um
>>>>> here instead.  There's no point to waste 8 bytes when a single byte
>>>>> can do.
>>>> I did this on purpose for the Huawei driver. We can unify this later o=
n,
>>>> but at this moment I rather see what is actually happening.
>>>>
>>>> Since we keep parsing all capabilities, I wanna avoid that a later one
>>>> overwrites a previous one. That said, just using some flags would be
>>>> better anyway. Especially since we also always have have_sim as well.
>>>>
>>>> However that can be done as a further optimization in the Speedup and
>>>> Huawei drivers.
>>>>
>>> A flagged enum is indeed what I had in mind when I wrote this.  But fair
>>> enough on your reasoning
>> As we are starting thinking about tweaking SIM atom to make it work with
>> CDMA modem,
>> maybe having quickly the flagged enum would be helpful to distinguish if
>> it is a CDMA or GSM modem that is asking for the SIM atom creation.
>>
>> Then where should this enum modem_type take place?
>> Should we tweak the already existing one into modem.h in replacing:
>>
>> OFONO_MODEM_TYPE_HARDWARE =3D 0,
>> OFONO_MODEM_TYPE_HFP,
>> OFONO_MODEM_TYPE_SAP,
>>
>> by
>>
>> OFONO_MODEM_TYPE_UNKNOWN_HARDWARE =3D 0,
>> OFONO_MODEM_TYPE_GSM_HARDWARE =3D 1,
>> OFONO_MODEM_TYPE_CDMA_HARDWARE =3D 2,
>> OFONO_MODEM_TYPE_HFP =3D 4,
>> OFONO_MODEM_TYPE_SAP =3D 8,
>>
>> Then we have just to specify the modem_type in creating the SIM atom to
>> use its limited functionnalities when we have CDMA modem
>> e.g. manage only PIN protection.
> No, the type information is a kludge that will hamper us in the end, so
> I am against any such changes.  Even the current modem_type enum took
> some convincing and it is meant to be used as a hint for external
> applications, not used internally by oFono core in any way

We can have a private enum modem type into plugin, but we won't be able =

to use it into any atoms.
Maybe by deduction we can add an enum sim_type into sim.h store the type =

into the plugin data and pass it at SIM atom creation.
What do you think?

Kind regards,
Guillaume

--===============6318366146946061621==--

