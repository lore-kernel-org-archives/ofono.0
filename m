Content-Type: multipart/mixed; boundary="===============6249280405544586915=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 15:14:54 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70106E0FF83@irsmsx504.ger.corp.intel.com>
In-Reply-To: <4D26057B.8030506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6249280405544586915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


My two cents on context activation race: the collision between a network in=
itiated context activation and UE initiated context activation. There is a =
potential issue if the modem and ofono try to assign the same CID at the sa=
me time
Basically the sequence of AT commands looks like the following for the acti=
vation of PDP context:

AT+CGDCONT=3DCID,X,Y,Z
OK
A+CGACT=3D CID,1
OK

The collision can only occur if the +CGDCONT (or +CGDSCONT) command  from O=
fono is sent at the same time as PDP context activation URC from the modem,=
 and both use the same CID.

But in that case, the modem should not reply "OK" to the PDP context config=
uration command, but "ERROR".
And Ofono should not consider that the PDP configuration command as success=
ful.
Moreover, the "OK" for the context configuration and the context activation=
 URC are sent of the same control channel so they cannot be sent in paralle=
l but only in sequence.

Sjur, is that a correct assumption?

Thanks,

Fred

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

--===============6249280405544586915==--

