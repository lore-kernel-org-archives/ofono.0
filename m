Content-Type: multipart/mixed; boundary="===============2628216856799525371=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Thu, 25 Apr 2013 14:47:33 -0300
Message-ID: <20130425174733.GB20988@samus>
In-Reply-To: <5178E8DD.2070107@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2628216856799525371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03:27 Thu 25 Apr, Denis Kenzior wrote:
> Hi Johan, Vinicius,
> =

> On 04/25/2013 04:37 AM, Johan Hedberg wrote:
> >Hi Mikel,
> >
> >On Thu, Apr 25, 2013, Mikel Astiz wrote:
> >>On Tue, Apr 23, 2013 at 7:28 PM, Johan Hedberg<johan.hedberg@gmail.co=
m>  wrote:
> >>>Hi Marcel,
> >>>
> >>>On Tue, Apr 23, 2013, Marcel Holtmann wrote:
> >>>>>I don't completely understand the rationale of wanting to make BlueZ=
's
> >>>>>clients so fragile. You could in theory get new services way after
> >>>>>pairing if this is configurable on the remote side. You could also g=
et
> >>>>>the result of calling Device1.Connect() instead of Device1.Pair() in
> >>>>>BlueZ.
> >>>>>
> >>>>>On the other hand, we do delay the response to Device1.Pair() until =
SDP
> >>>>>is complete so delaying the Paired property would in a way be consis=
tent
> >>>>>with that. I'll look into how simple this would be. We already track=
 the
> >>>>>completion of SDP for each device internally with a svc_resolved boo=
lean
> >>>>>so probably a new flag to indicate that "Paired" still needs to be
> >>>>>emitted should be all the extra context tracking we need.
> >>>>
> >>>>the pairing procedure is special and we should try to avoid any
> >>>>pointless round trips or wake ups for the clients here. We do know
> >>>>that we are running SDP after pairing anyway. So lets just wait for it
> >>>>to finish. Especially if we do that already anyway for Device1.Pair().
> >>>
> >>>This ended up being quite simple to do, so I just pushed a mostly
> >>>untested patch for this to bluez.git. It'd be good if someone could
> >>>verify that it actually ends up helping the situation with oFono.
> >>>
> >>
> >>How do remotely-initiated connections fit into this?
> >>
> >>We've seen devices that try to connect profiles immediately after
> >>pairing, I believe before the discovery is complete.
> >
> >Both the NewConnection() (including the authorization of the incoming
> >L2CAP/RFCOMM connect request) and the Paired property would even then be
> >delayed until our side has completed its full service discovery.
> >
> =

> So should we be reverting commit 456b8c9723b9b73c3ea4cadc8c6f84ca90675f9a?

I guess so. Without that commit this problem doesn't exist.

> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============2628216856799525371==--

