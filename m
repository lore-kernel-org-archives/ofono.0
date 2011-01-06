Content-Type: multipart/mixed; boundary="===============3079065091834212989=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 13:28:30 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C123F83@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1294272721.2521.34.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3079065091834212989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > Behavior of the function :
> >
> > List all the context and try to find correct APN
> =

> we have to be careful to only match against APN=3D=3DAPN and Username=3D=
=3D"" +
> Password=3D=3D"".
> =

> The username and password option is pretty much pointless, but it is
> present and we do support it. So we need to make sure the APN matching
> sensible. Or does the network provide us with additional information
> about the username + password as well?

Network doesn't provide login/password information, the UE shall provide it=
 if needed. I'm not aware of any case where we can have network initiated c=
onnection with an APN usually used with authentication.
If the connection requires a login/password then it's UE initiated procedur=
e.

If you think it's safer to check against Login/Password anyway, it's OK for=
 me.

> =

> > If such context is not found create a new one with "Internet" type.
> =

> I don't really agree that we should create a context if no match is
> found. I think the better sensible strategy is to hold this information
> internally and only map it to a context once the user or provisioning
> creates it.
> =

> Also oFono will create at least one Internet context automatically. And
> in the future that might be auto-provisioned.
> =

> Another option would be to introduce the concept of temporary context
> where the lifetime is mandated by the network.

I agree with Denis, I think for now we can assume that it's either Internet=
 or IMS (well-known APN).

Later if we see operators doing something else we ll adapt.
So I propose to keep this behavior for now, until we see a real need for so=
mething else.

Regards,

Redouane.

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3079065091834212989==--

