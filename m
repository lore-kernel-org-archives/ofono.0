Content-Type: multipart/mixed; boundary="===============9169650695778448588=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] cdmaphonesim: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 16:32:15 -0600
Message-ID: <4D0FD96F.1090400@gmail.com>
In-Reply-To: <4D0FD043.90003@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169650695778448588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

>>
>> Have you considered adding a CDMA/GSM selector to phonesim.conf instead?
>>   So e.g. a new configuration key called 'Type' where type can be 'gsm'
>> or 'cdma'.
>>
>> That way you can share much of the phonesim plugin plumbing and only
>> populate the atoms differently...
>>
> =

> We thought about this briefly but decided not pursuing that path at this
> stage of CDMA development mainly due to following reasons: a). We think
> it may make more sense to let CDMA development evolving a bit more on
> its own and then evaluate to see for which part it makes sense
> to merge. We are afraid merging too early will make the phonesim.c code
> looking ugly with a lot of if/else down the road. We are planning to
> evaluate things like this when we have at least a few CDMA atoms
> implemented. b). We definitely would like to cause as little disruption
> to GSM as possible at this stage of CDMA development.

Ok I'm still waffling on this one but I can accept a temporary cdma
phonesim plugin for now.

Can you make sure to strip it down some more? For instance you can omit
Multiplexer and Modem configure key handling.

And having a separate configure option for cdma phonesim seems unneeded.
 Lump this one with --enable-phonesim.

Regards,
-Denis

--===============9169650695778448588==--

