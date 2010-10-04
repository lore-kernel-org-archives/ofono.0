Content-Type: multipart/mixed; boundary="===============6395149410971517301=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Re: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Mon, 04 Oct 2010 19:17:27 +0300
Message-ID: <201010041917.28066.petteri.tikander@ixonos.com>
In-Reply-To: <1286000558.4231.35.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6395149410971517301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

and thanks for the valid comments.

> Hi Petteri Tikander,
> =

> > ---
> >  drivers/atmodem/sim.c |   23 +++++++++++++++++++++
> >  include/sim.h         |    3 ++
> >  src/sim.c             |   52
> > +++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 78
> > insertions(+), 0 deletions(-)
> =

> these need to be split into two separate patches no matter what. First
> one is adding a feature to the core. The other is implementing it in the
> atom driver.

OK.

> =

> I know that you guys talked with Denis about this, so I might be just
> missing something here.
> =


You did not necessarily missed anything:) So logically presim-state in SIM-
enabled FDN has sense (or even switching to OFF_LINE-state). It can be my =

misunderstanding. We had some discussion with Denis of this issue, and I =

understood it so, that oFono-api has to remove rest of the atoms, if FDN is =

enabled (so also SIM- and voicecall atoms). At least it was easy way to fil=
ter =

any calls.

Well, the removal of the SIM-atom (what my patch-code did) wasn't a good id=
ea =

from me. Seems that SIM-initialization routine will be done every time when =

waking up from the POWER-OFF state to the emergency-mode :(

Anyway, I ensured the situation (staying in the presim-state) by next kind =
of =

test (by making some test-code, where FDN-enabled SIM causes keeping in the =

PRE_SIM-state):

1) enable FDN in SIM

2) enable modem:
	- create SIM-atom/voice call atom/.../read some EFs/.../read IMSI-code/rea=
d =

	FDN enabled-status

3) dial to some number in the FDN-list

4) call passed!

Well, why the call passed to B-subscriber: it shouldn't because modem shoul=
d =

be offline (AT+CFUN=3D1 not given yet). But my test-modem doesn't understan=
d =

'AT+CFUN=3D4'- command, so it can pass calls anyway. OK, most modems will =

not start dialing. But anyway, if modem is in the offline, it still receive=
s =

'ATD####'-command through atom/driver-chain, handles it, and probably retur=
ns =

some error.

So the basic question is now, should the voicecall-atom also be removed in =

the call-restrictions (FDN/BDN-situations etc), causing calls to be filtere=
d in =

very early phase. Or voicecall-atom not even created until switching to =

ON_LINE (emergency-mode logic switches). Or is it OK to accept situation =

mentioned below (let trust the modem to filter calls), and keep the voiceca=
ll-
logic visible all the time?  Or, probably to add some condition in voicecal=
l =

atoms's methods for canceling calls when not being in the MODEM_ON_LINE-sta=
te.


> The requirement for minimum FDN support is really to power down the
> modem and not leave it in pre_sim state for emergency calls?
> =


Thanks.

Br, Petteri


--===============6395149410971517301==--

