Content-Type: multipart/mixed; boundary="===============3176726806156315635=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 13:09:30 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE38C0@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4D0BCDF2.2000702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3176726806156315635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


> Hi Rajesh,
> =

> >> Can you do me a favor and investigate what oFono's =

> behavior should be =

> >> if we receive emergency numbers that are not relevant to the =

> >> currently registered PLMN?  We should also update the task =

> >> description with the above.
> > =

> > The ECC list downloaded from the network are country =

> specific ones, so =

> > this ECC list usually can be notified by any available network not =

> > necessarily by the serving network. The ECC list thats =

> downloaded from =

> > the serving network has to be reset when the phone registers in =

> > another network with a different MCC ( not MNC ), as this =

> ECC list is =

> > country specific not operator specific.
> >
> =

> Sounds reasonable.  Is this relevant only when the ME is =

> registered with the IMSI known or also when the SIM is not =

> present / PIN not entered?

Only when the SIM/USIM is present.

> For these cases, what happens when we're in an area with =

> multiple networks with multiple MCCs.

Good question :)
 =

> Final question, is there a spec that describes this behavior?

3GPP TS 22.101 Section 10

BR,
Rajesh

--===============3176726806156315635==--

