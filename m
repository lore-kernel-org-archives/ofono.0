Content-Type: multipart/mixed; boundary="===============2063729067892324580=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: Call Barring and MMI Supplementary Service codes
Date: Mon, 18 Oct 2010 22:27:15 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702B72E8A@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <4CBCBB6A.3060306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2063729067892324580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =

 =

> My interpretation of 22.004 and 22.030 was that dedicated =

> packet access and dedicated PAD access were deprecated and no =

> longer being used.  The fact that they're still listed in =

> 27.007 seems to be irrelevant.

As dedicated packet access and dedicated PAD access is mentioned in
27.007, the AT modems still consider these values while translating the
corresponding Basic Service group. Thats the reason when sending 16 the
AT modem translates it to "All data circuit sync" and  80  to "All Sync
services" in REGISTER message(Fred can you confirm this ?). =

In case of message based modems, we have seperate MMI for All Sync
services and All data circuit sync services and as MMI's for dedicated
packet access and dedicated PAD access are deprecated the translation
happens without conflict.

> One possibility is that the bearer services covered by =

> dedicated packet & dedicated pad access were lumped together =

> with bearer services 20 and 30 from 3GPP 22.002.

I think the dedicated packet access and dedicated PAD access bearers are
deprecated, not grouped with BS 20 and 30.

> >> Shouldn't we translate the "*33*1234*22#" MMI SS String =

> into AT+CLCK=3D"AO",1,"1234",80 ?
> > =

> > From my understanding YES.
> =

> I actually am fine making this change, and it is quite =

> trivial to boot.
>  But before we do that, can we confirm that this is indeed =

> mandated by the specs, and not an error in the test cases.

There is no error in the corresponding test cases.

> What values are expected from MMI services 25, 24 and 26?

For MMI 22 (All Sync Services)=3D> 80 ("All data circuit sync" (16) + "All
dedicated packet access" (64))

For MMI 21 (All Async Services)=3D> 160 ("All data circuit async" (32) +
"All dedicated PAD access" (128)).

For MMI 26 (Telephony and All sync services)=3D> 81 (Telephony (1) + "All
data circuit sync" (16) + "All dedicated packet access" (64))

For MMI 24 (All data circuit sync)=3D> 16 ("All data circuit sync")

For MMI 25 (All data circuit async)=3D> 32 ("All data circuit async")

Fred, can you modify the values for MMI 22, 21 and 26 as above and
confirm from the test result whether our understanding is correct or not
? =


BR,
Rajesh

--===============2063729067892324580==--

