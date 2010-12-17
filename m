Content-Type: multipart/mixed; boundary="===============8160786232248187303=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 12:29:56 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE3898@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4D0B9353.5060509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8160786232248187303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
 =

> Hi Petteri,
> =

> On 12/17/2010 03:10 AM, Tikander Petteri wrote:
> > Hi,

> > According to TS.27007 network emergency numbers are not necessarily =

> > received from the same operator as currently registered, so this =

> > should probably also be considered in the future.
> > =

> =

> Can you do me a favor and investigate what oFono's behavior =

> should be if we receive emergency numbers that are not =

> relevant to the currently registered PLMN?  We should also =

> update the task description with the above.

The ECC list downloaded from the network are country specific ones, =

so this ECC list usually can be notified by any available network not =

necessarily by the serving network. The ECC list thats downloaded from =

the serving network has to be reset when the phone registers in another =

network with a different MCC ( not MNC ), as this ECC list is country =

specific not operator specific.

BR,
Rajesh

--===============8160786232248187303==--

