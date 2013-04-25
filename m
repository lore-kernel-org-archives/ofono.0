Content-Type: multipart/mixed; boundary="===============3832261908445076776=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Thu, 25 Apr 2013 12:37:53 +0300
Message-ID: <20130425093753.GA8845@x220.ger.corp.intel.com>
In-Reply-To: <CANT-zCWa2CZa8YC7WXcFymBCiKnYmgKyDH3aceXpViPdo8hhFQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3832261908445076776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On Thu, Apr 25, 2013, Mikel Astiz wrote:
> On Tue, Apr 23, 2013 at 7:28 PM, Johan Hedberg <johan.hedberg@gmail.com=
> wrote:
> > Hi Marcel,
> >
> > On Tue, Apr 23, 2013, Marcel Holtmann wrote:
> >> > I don't completely understand the rationale of wanting to make BlueZ=
's
> >> > clients so fragile. You could in theory get new services way after
> >> > pairing if this is configurable on the remote side. You could also g=
et
> >> > the result of calling Device1.Connect() instead of Device1.Pair() in
> >> > BlueZ.
> >> >
> >> > On the other hand, we do delay the response to Device1.Pair() until =
SDP
> >> > is complete so delaying the Paired property would in a way be consis=
tent
> >> > with that. I'll look into how simple this would be. We already track=
 the
> >> > completion of SDP for each device internally with a svc_resolved boo=
lean
> >> > so probably a new flag to indicate that "Paired" still needs to be
> >> > emitted should be all the extra context tracking we need.
> >>
> >> the pairing procedure is special and we should try to avoid any
> >> pointless round trips or wake ups for the clients here. We do know
> >> that we are running SDP after pairing anyway. So lets just wait for it
> >> to finish. Especially if we do that already anyway for Device1.Pair().
> >
> > This ended up being quite simple to do, so I just pushed a mostly
> > untested patch for this to bluez.git. It'd be good if someone could
> > verify that it actually ends up helping the situation with oFono.
> >
> =

> How do remotely-initiated connections fit into this?
> =

> We've seen devices that try to connect profiles immediately after
> pairing, I believe before the discovery is complete.

Both the NewConnection() (including the authorization of the incoming
L2CAP/RFCOMM connect request) and the Paired property would even then be
delayed until our side has completed its full service discovery.

Johan

--===============3832261908445076776==--

