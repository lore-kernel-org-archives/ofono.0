Content-Type: multipart/mixed; boundary="===============5122127565782653786=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Thu, 25 Apr 2013 10:51:58 +0200
Message-ID: <CANT-zCWa2CZa8YC7WXcFymBCiKnYmgKyDH3aceXpViPdo8hhFQ@mail.gmail.com>
In-Reply-To: <20130423172859.GA30582@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5122127565782653786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan, Marcel,

On Tue, Apr 23, 2013 at 7:28 PM, Johan Hedberg <johan.hedberg@gmail.com> =
wrote:
> Hi Marcel,
>
> On Tue, Apr 23, 2013, Marcel Holtmann wrote:
>> > I don't completely understand the rationale of wanting to make BlueZ's
>> > clients so fragile. You could in theory get new services way after
>> > pairing if this is configurable on the remote side. You could also get
>> > the result of calling Device1.Connect() instead of Device1.Pair() in
>> > BlueZ.
>> >
>> > On the other hand, we do delay the response to Device1.Pair() until SDP
>> > is complete so delaying the Paired property would in a way be consiste=
nt
>> > with that. I'll look into how simple this would be. We already track t=
he
>> > completion of SDP for each device internally with a svc_resolved boole=
an
>> > so probably a new flag to indicate that "Paired" still needs to be
>> > emitted should be all the extra context tracking we need.
>>
>> the pairing procedure is special and we should try to avoid any
>> pointless round trips or wake ups for the clients here. We do know
>> that we are running SDP after pairing anyway. So lets just wait for it
>> to finish. Especially if we do that already anyway for Device1.Pair().
>
> This ended up being quite simple to do, so I just pushed a mostly
> untested patch for this to bluez.git. It'd be good if someone could
> verify that it actually ends up helping the situation with oFono.
>

How do remotely-initiated connections fit into this?

We've seen devices that try to connect profiles immediately after
pairing, I believe before the discovery is complete.

Cheers,
Mikel

--===============5122127565782653786==--

