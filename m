Content-Type: multipart/mixed; boundary="===============2526153731632971844=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/gprs: added autoattach handling
Date: Fri, 28 Sep 2018 08:40:49 -0500
Message-ID: <f692c73a-dce4-4401-5621-bea86571f70b@gmail.com>
In-Reply-To: <CAKSBH7GAHVsX1J6ESLcVS5_7D0B5VsCrxzpy7zCqJZ4WQsX7cw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2526153731632971844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> You can't really do that though.  It is fully possible for a modem to
>> roam off LTE onto 3G and not be attached...  So we still need tosend
>> +CGATT in this case.
> =

> You can't really do that, either. It is possible that the module hops
> off LTE for a CSFB call of for a simple SMS, and the current logic

It may be the logic is flawed here.  Or the event sequence causes GPRS =

to thrash about and cause a detach.  I wonder if this can be fixed in =

the gprs core atom itself?

E.g. for a CSFB / SMS, we should see something like:

+CREG: 1, foo, bar, 7 // Home network, EUTRAN
+CREG: 1, baz, bea, 2
+CGREG: 1, baz, bea, 2

> will send immediately AT+CGATT=3D0 which will wreak havoc: the contexts
> that should be handed-over or suspended are released, and the module

So if we're sending a +CGATT=3D0 in that event sequence, then it is likely =

a bug.  Can you actually share an AT command trace / debug log of what =

is happening?  export OFONO_AT_DEBUG=3D1 prior to running oFono.

> is never able to return to LTE because forced to detach.
> I didn't see the call drop in my tests, but it is not impossible that
> some modules would also do that as a consequence.
> I didn't test on the move or with a simulator, but I suppose also in
> case of HO LTE->3G we have the same scenario.

The problem is that every vendor handles CGATT slightly differently.  It =

is a bit of a mess, but yes it sounds like we are doing something wrong =

here.

> =

> For Gemalto modules it is kind of mandatory to let the module handle
> the attach by itself if it supports LTE, and I believe also for other
> vendors, hence the autoattach flag.

Well, this is a bit of a strange situation actually.  So the original =

RoamingAllowed logic was introduced because some networks actually =

charged roaming fees when the Modem was attached (not even context =

activated) to the PS network.  So the RoamingAllowed hammer was added to =

make sure that if the user enabled that option, no attach would be =

attempted while roaming.

This still in theory applies to LTE-capable devices: even if we drop =

from LTE to 3G to make a phone call, we should still detach if the =

setting applies.  So the question is why does +CGATT affect anything in =

the LTE state?  In some sense I don't think it was meant to affect LTE =

state.

However, I think the fundamental problem is that 27.007 never provided =

us the right command to actually tell the modem what to do.  We really =

just needed a hint out to the modem not to auto-attach while roaming, =

something that mapped to RoamingAllowed setting.  Unfortunately the =

+CGATT was the only thing available.

> =

> Maybe the data-roaming logic should move from attach to context activatio=
n.
> Also the operators expect it to work this way nowadays, even for
> pre-LTE modules.

So honestly I was never happy with the RoamingAllowed stuff, nor the =

logic that drove it.  But at this point we're kind of stuck with it for =

1.x.  The question is, can this be fixed somehow?

If not, then we can consider starting oFono 2.x branch and dropping =

RoamingAllowed from the D-Bus API.  This would also allow us to fix some =

other long-standing issues with the D-Bus API as well.  However, this is =

quite a major step with its own consequences...

Regards,
-Denis

--===============2526153731632971844==--

