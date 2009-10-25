Content-Type: multipart/mixed; boundary="===============7361474283100316383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sat, 24 Oct 2009 22:43:58 -0500
Message-ID: <200910242243.59094.denkenz@gmail.com>
In-Reply-To: <fb249edb0910241702p2467ef4fgd09b9e42216dcfa7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7361474283100316383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Lets suppose status=3Dregistered arrives and we're already attached.  H=
ere
> > attached will be set to FALSE, Attached property will be set to false a=
nd
> > emitted.  gprs_netreg_update will presumably reset Attached back to Tru=
e.
>
> Now I see it and you're absolutely right to be alerted, I set
> "attached" to the reverse of what it should be set to.  We're attached
> when we're either in REGISTERED or ROAMING state.  If I had done it
> right then the logic would look simple (I suppose):

I still don't believe that it works.  Suppose we're attached and registered=
.  =

Now we get an indication that we're in 'searching' state.  set attach to tr=
ue, =

compare with stored value (true).  Ah, don't do anything -> not good.

You also emit a signal that outright lies as to the current state.  Suppose =

we're registered and just the cellid / lac / technology changes.  This =

function still gets triggered and does a funky dance of emitting signals an=
d =

calling into the driver to attach / detach.

>
> If either we already knew that we were in that state then there's
> nothing to do.  Otherwise we set the D-Bus property to reflect current
> state and call gprs_netreg_update to figure out if this is the state
> we really wanted to be in.

This part is fine, but lets make it easy to understand, e.g. do all of this =

inside gprs_netreg_update.

>
> If the notification indicates we were detached we will also need to
> reset all current contexts to inactive here, originally I did this in
> the driver.

Yes, this is one of the parts I forgot to port over :(

> This is a policy question, what do we do when the user disallowed
> roaming but the modem wants to roam?  If we decide that we will not
> retry to attach until the user pokes us again then "Powered" really
> should be reset to false because even if the conditions you listed are
> met we still won't attach.  Maybe instead we should do the retries
> with increasing timeouts like you mentioned in another message, and
> then "Powered" should stay set.

Resetting Powered in the core leads to strange situations where after comin=
g =

from an overseas trip you'd need to reset Powered back to on.  I would find =

that annoying.

The nice thing is I don't think we need to play the attach/detach dance.  W=
e =

can take advantage of the netreg atom's information.  If we're roaming ther=
e, =

we will be roaming on GPRS as well.  If we're registered there, then we sho=
uld =

try to attach.

>
> An unrelated thing: you keep the allowed cid range in the core and
> only remember the min and max cid.  However I think (but don't know
> where to check for it) that +CGDCONT=3D? is free to return (1,2) instead
> of (1-2), or even (1-2,5-6,13).  Other AT commands do return ranges
> with this syntax.

You're absolutely correct that the syntax allows this.  My decision here wa=
s =

mostly a  matter of prudence.  I doubt any device actually uses a non-
contiguous cid range.  If/once we do find one that does, we can add a new =

set_sparse_range function (or something) in the core to take care of it.

Regards,
-Denis

--===============7361474283100316383==--

