Content-Type: multipart/mixed; boundary="===============4100994327756393852=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv3] quectel: handle sim states
Date: Thu, 26 Sep 2019 21:26:16 +0200
Message-ID: <87fdc777-3440-5e07-e2e6-da298d78ed03@geanix.com>
In-Reply-To: <7f027d2d-f323-61e7-eedc-6b7a56c6eb83@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4100994327756393852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 24/09/2019 22.40, Denis Kenzior wrote:
>>> I tried implementing what you suggest - see the attached patch. But I =

>>> still get "SMS not supported by this modem.".
>>>
>>> The attached log shows quectel_post_sim() being called (line 584) way =

>>> before QINISTAT returns 3 (line 686).
>>>
>>> Is this because my SIM isn't locked, and so the =

>>> ofono_sim_inserted_notify() call makes it go all the way?
>>>
>>> I can work around it by calling ofono_sim_inserted_notify() either if =

>>> the SIM is locked, or/and when qinistat returns 3.
>>
>> It also happens on a locked SIM - log attached.
>>
> =

> So in your log:
> =

> ofonod[3982107]: ../git/plugins/quectel.c:sim_watch_cb() 0x610000000d40
> ofonod[3982107]: ../git/src/sim.c:sim_enter_pin_cb() Waiting for =

> ofono_sim_initialized_notify
> =

> So we're supposed to be waiting here for a bit.=C2=A0 Somehow we're not o=
r =

> you're calling ofono_sim_initialized early.=C2=A0 Perhaps the default sim =

> driver is doing this?=C2=A0 Check this first.

Spot on:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers/atmodem=
/sim.c?id=3D93f03865f731fb4b9d368b8e99bd458aa0efca53#n1357

Patches coming up.

// Martin

--===============4100994327756393852==--

