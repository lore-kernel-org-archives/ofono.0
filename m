Content-Type: multipart/mixed; boundary="===============4745195083334246568=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Mon, 04 Oct 2010 19:03:11 -0500
Message-ID: <4CAA6B3F.20506@gmail.com>
In-Reply-To: <201010041917.28066.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4745195083334246568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

> =

> You did not necessarily missed anything:) So logically presim-state in SI=
M-
> enabled FDN has sense (or even switching to OFF_LINE-state). It can be my =

> misunderstanding. We had some discussion with Denis of this issue, and I =

> understood it so, that oFono-api has to remove rest of the atoms, if FDN =
is =

> enabled (so also SIM- and voicecall atoms). At least it was easy way to f=
ilter =

> any calls.

Please refer to SIM initialization procedures in 3GPP 31.102 Section
5.1.1.2.  The FDN enabled check is done after EFust / EFest is read but
before EFimsi is read.  So the modem should remain in the 'pre-sim' state.

> =

> Well, the removal of the SIM-atom (what my patch-code did) wasn't a good =
idea =

> from me. Seems that SIM-initialization routine will be done every time wh=
en =

> waking up from the POWER-OFF state to the emergency-mode :(

Removing of sim atom is not necessary, simply never proceed past the
pre-sim state.

<snip>

> =

> So the basic question is now, should the voicecall-atom also be removed i=
n =

> the call-restrictions (FDN/BDN-situations etc), causing calls to be filte=
red in =

> very early phase. Or voicecall-atom not even created until switching to =

> ON_LINE (emergency-mode logic switches). Or is it OK to accept situation =

> mentioned below (let trust the modem to filter calls), and keep the voice=
call-
> logic visible all the time?  Or, probably to add some condition in voicec=
all =

> atoms's methods for canceling calls when not being in the MODEM_ON_LINE-s=
tate.

In the future we will have a way to trigger online state for dialing
emergency numbers even if FDN/BDN are enabled or the SIM is not
inserted.  That is something Pekka and other folks at Nokia are working on.

So the suggested way forward is to simply check the entries in EFest /
EFsst (for 51.011 and 11.11) and halt SIM initialization procedures if
FDN is enabled.  Adding a property to tell the UI what is going on (e.g.
boolean FixedDialing) might be a good idea as well.

> =

> =

>> The requirement for minimum FDN support is really to power down the
>> modem and not leave it in pre_sim state for emergency calls?
>>

No, we should not power down the modem.

Regards,
-Denis

--===============4745195083334246568==--

