Content-Type: multipart/mixed; boundary="===============7903601336132322226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 09:11:24 -0600
Message-ID: <dfeca1c1-e4ab-a42c-f9b2-92d69b100d55@gmail.com>
In-Reply-To: <e10fa5c9-24ea-3af8-651f-2f43a49670e7@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7903601336132322226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> Ofono does something like this on a tech transition to LTE:
> =

> Active: false
> Attached: false
> ...
> Attached: true
> Active: true
> =


This is from 3G to LTE or the initial registration to LTE?  Do you have =

an ofono-monitor log handy?

> When ofono does Attached: true, connman starts trying to set the context =

> active which seems to result in InProgress.=C2=A0 connman doesn't seem to =

> like the InProgress response and tries again, which ends up pounding the =

> modem hard with "set active" messages until read_settings() returns (on =

> the modem side) and the modem becomes Active (automatically) for real.

That sounds like connman isn't taking InProgress into consideration =

properly.

> =

> Similarly, on a transition from LTE to 3G, connman also tries to =

> activate the context hundreds of times before it settles.=C2=A0 This =

> behaviour is harder to understand:=C2=A0 connman has explicitly requested=
 the =

> activation here and should know that it's in progress...

ofono-monitor log by any chance?  I'm not sure why a switch from LTE to =

3G would cause any changes to Active/Attached states.  It should simply =

twiddle the NetworkRegistration state and that's it, unless the modem is =

reporting things it shouldn't.

> =

> What I think might be an issue here is the interplay between Attached =

> and Active.=C2=A0 For LTE, Attached and Active are synonymous...(???) con=
nman =

> should not be setting Active for these at all.

ConnMan doesn't keep track of the NetworkRegistration state, so it =

doesn't really know about LTE...

> =

> Could ofono have Active set to true before Attached gets set true for =

> the LTE context case so that connman never sees the context as =

> Active:false?=C2=A0 Or is there a better way to handle this?

I don't think that would make sense from an API consistency perspective.

Regards,
-Denis

--===============7903601336132322226==--

