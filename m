Content-Type: multipart/mixed; boundary="===============0365533249498738859=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH 4/5] cdmaphonesim: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 15:14:40 -0800
Message-ID: <4D0FE360.1050608@nokia.com>
In-Reply-To: <4D0FD96F.1090400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0365533249498738859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/20/2010 02:32 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
>>>
>>> Have you considered adding a CDMA/GSM selector to phonesim.conf instead?
>>>    So e.g. a new configuration key called 'Type' where type can be 'gsm'
>>> or 'cdma'.
>>>
>>> That way you can share much of the phonesim plugin plumbing and only
>>> populate the atoms differently...
>>>
>>
>> We thought about this briefly but decided not pursuing that path at this
>> stage of CDMA development mainly due to following reasons: a). We think
>> it may make more sense to let CDMA development evolving a bit more on
>> its own and then evaluate to see for which part it makes sense
>> to merge. We are afraid merging too early will make the phonesim.c code
>> looking ugly with a lot of if/else down the road. We are planning to
>> evaluate things like this when we have at least a few CDMA atoms
>> implemented. b). We definitely would like to cause as little disruption
>> to GSM as possible at this stage of CDMA development.
>
> Ok I'm still waffling on this one but I can accept a temporary cdma
> phonesim plugin for now.
>

As you can see I am also waffling on this. :-) I will stick with =

separate cdma phonesim plugin for now.

> Can you make sure to strip it down some more? For instance you can omit
> Multiplexer and Modem configure key handling.
>

Yes, I will strip it down more.

> And having a separate configure option for cdma phonesim seems unneeded.
>   Lump this one with --enable-phonesim.
>

Yes, I will do this.

> Regards,
> -Denis

Regards,
Lei

--===============0365533249498738859==--

