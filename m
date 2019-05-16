Content-Type: multipart/mixed; boundary="===============3978978662371286246=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 16 May 2019 13:36:36 -0500
Message-ID: <d634a1c5-d4e6-7f95-b000-ca114b601439@gmail.com>
In-Reply-To: <CAKSBH7FCBQ=D27K8AjatQ51-yp2=y3d2_wQdYkh_-idvHZ==SA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3978978662371286246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> I find it a bit pathetic blaming the 3GPP for the limitations of an
> old design (I did not say obsolete).
> =

> 3GPP stakeholders (mainly MNOs) wanted to uncouple the technologies,
> to avoid the mega
> spaghetti soup of GSM+GPRS+UTRAN, and also to allow to launch the
> technologies without carrying the bag of the legacy.
> It is the same with the NR, that has a C5GREG indicator.
> Also the chipset vendors could take advantage of this, implementing
> independent stacks, and so easier-to-maintain firmwares.
> This is done on purpose, and the transaction period shall be handled
> by flexible enough software.

The simple fact is that a state change resulting in multiple events =

being emitted, with no defined order mandated by 3GPP is just bad API =

design.  You have status events coming at least 5 different sources =

(+CGEV, +CGREG, +CREG, +CEREG, +C5REG, etc), with some implying =

something on one firmware implementation vs not implying it on another. =

Add to this the fact that many firmware implementations out there don't =

bother sending +CGEV events properly and you have a mess for the upper =

layers.  But I do agree it makes writing the firmware easier ;)

>> Since 3GPP decided to go with EREG being separate from CGREG, I think it
>> makes sense to support that natively in lte.c or gprs.c.  Our philosophy
>> has always been to base the driver APIs off of 27.007.  So from that
>> perspective, introducing ofono_lte_status_notify would make sense.
>> Whether something like this makes things easier or not is a different
>> question :)
> =

>   I did propose something long time ago (in gprs.c), and was more or
> less ok, except that the logic should
> have been in the core atom, because it is reusable and definitely complex.
> =


And I pointed this last part out as part of my comments back then if I =

recall correctly.

> Then I didn't go further because anyway your small 80 chars screen
> couldn't allow for AT+MBIM driver,
> effectively cutting off most of Gemalto (now Thales) new generation of mo=
dules.
> But the proposal and discussion is still in the history.
> =


If you're not going to be offering anything constructive, please don't =

say anything.  Insults will not be tolerated on this list.    This is =

your only warning, we've never had to ban anyone before, but there's a =

first time for everything.

Regards,
-Denis

--===============3978978662371286246==--

