Content-Type: multipart/mixed; boundary="===============9096216517656667241=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 7/7] cdmaphonesim: Add CDMA SMS Support
Date: Wed, 05 Jan 2011 12:05:32 -0600
Message-ID: <4D24B2EC.1000907@gmail.com>
In-Reply-To: <4D24B25E.2080007@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9096216517656667241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

>>> diff --git a/plugins/phonesim.conf b/plugins/phonesim.conf
>>> index 74bb645..8cd9678 100644
>>> --- a/plugins/phonesim.conf
>>> +++ b/plugins/phonesim.conf
>>> @@ -12,3 +12,7 @@
>>>   #[phonesim]
>>>   #Address=3D127.0.0.1
>>>   #Port=3D12345
>>> +
>>> +#[cdmaphonesim]
>>> +#Address=3D127.0.0.1
>>> +#Port=3D12345
>>
>> If we have both phonesim and cdmaphonesim plugins active, we need to
>> make sure they don't interfere with each other.  Perhaps adding a
>> Type=3Dcdma and having cdmaphonesim look for that Type tag and ignore the
>> rest would be a good idea?
>>
> =

> If both phonesim and cdmaphonesim active, they should have to be
> configured with running with different port, right? If so,they should
> not interfere with each other. And, making sure ports are different is
> the job of the end-user, right?

That is correct and not what I was referring to.

> =

> I am a bit lost about the Type attribute. cdmaphonesim is currently
> defined as a separate plugin and by the time cdmaphonesim's
> parse_config() is invoked, it already knows that it is cdma. Thus, I
> don't see why needing another flag indicating this. When you say ignore
> the rest, could you pls be more specific about what to ignore and what's
> the intention of doing that? Sorry, still learning... :-)
> =


So correct me if I'm wrong, but there's a race between cdmaphonesim and
phonesim plugins:

if phonesim starts first it reads phonesim.conf and creates both
phonesim and cdmaphonesim modems.  When cdmaphonesim starts, it tries to
create the modems again, but fails.  Similar situation vice-versa.

This is why I'm suggesting the Type attribute.  Maybe I'm blind and this
race does not happen?

Regards,
-Denis

--===============9096216517656667241==--

