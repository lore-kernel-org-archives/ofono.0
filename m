Content-Type: multipart/mixed; boundary="===============1572788481235396352=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 15:39:52 -0300
Message-ID: <20130423183951.GB11434@samus>
In-Reply-To: <20130423172859.GA30582@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1572788481235396352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 20:28 Tue 23 Apr, Johan Hedberg wrote:
> Hi Marcel,
> =

> On Tue, Apr 23, 2013, Marcel Holtmann wrote:
> > > I don't completely understand the rationale of wanting to make BlueZ's
> > > clients so fragile. You could in theory get new services way after
> > > pairing if this is configurable on the remote side. You could also get
> > > the result of calling Device1.Connect() instead of Device1.Pair() in
> > > BlueZ.
> > > =

> > > On the other hand, we do delay the response to Device1.Pair() until S=
DP
> > > is complete so delaying the Paired property would in a way be consist=
ent
> > > with that. I'll look into how simple this would be. We already track =
the
> > > completion of SDP for each device internally with a svc_resolved bool=
ean
> > > so probably a new flag to indicate that "Paired" still needs to be
> > > emitted should be all the extra context tracking we need.
> > =

> > the pairing procedure is special and we should try to avoid any
> > pointless round trips or wake ups for the clients here. We do know
> > that we are running SDP after pairing anyway. So lets just wait for it
> > to finish. Especially if we do that already anyway for Device1.Pair().
> =

> This ended up being quite simple to do, so I just pushed a mostly
> untested patch for this to bluez.git. It'd be good if someone could
> verify that it actually ends up helping the situation with oFono.

This indeed helps with the issue of receiving UUIDs property after the
Paired. Thanks.

It should be noted that we have BlueZ releases without this fix, that can
crash oFono, it may be worth considering this patch for this reason.

The issue with NewConnection() arriving before the "Paired" property changed
signal remains.

> =

> Johan
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


Cheers,
-- =

Vinicius

--===============1572788481235396352==--

