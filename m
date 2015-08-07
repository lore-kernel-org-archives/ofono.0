Content-Type: multipart/mixed; boundary="===============7638735801160896215=="
MIME-Version: 1.0
From: Pawlak, KubaX T <kubax.t.pawlak@intel.com>
Subject: RE: [PATCH 0/3] Driver specific dial string validation
Date: Fri, 07 Aug 2015 14:27:26 +0000
Message-ID: <088CC8BACB3382439E91D9919CE3502436519864@IRSMSX107.ger.corp.intel.com>
In-Reply-To: <55C3E242.8040708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7638735801160896215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> On 08/06/2015 11:56 AM, Kuba Pawlak wrote:
> > Dial() method is generic for all modems but hfpmodem may not support
> some dial
> > strings. HFP 1.6 SPEC for ATD says: "Only voice calls are covered in th=
is
> > specification."
> > Problem is with dialling USSD codes. Request is accepted and a call obj=
ect
> > is state dialling is created. USSD code is completed, result displays on
> > the phone, but there are no events that would allow oFono to remove this
> fake
> > call object.
> > We may end up in such situation (Samsung S3 4.3):
> > ofonod[292]: > ATD*132#;\r
> > ofonod[292]: < \r\nOK\r\n
> =

> Funny that the HFP AG implementation accepts this, but okay.

This is the only phone I have that does that. S3 mini, some HTC are returni=
ng CME ERROR.

> On a phone, the Dialer was instructed to call
> SupplementaryServices.Initiate() first, before calling
> VoiceCallManager.Dial().  See doc/mmi-codes.txt.
> =

> Since we have no SupplementaryServices / ussd atom, I guess it would
> make sense to have the voicecall atom double check that the passed in
> string is not a USSD string.
> =

> Try the attached patch.
 =

Looks good. Stops USSD commands from reaching the phone. And is shorter.

Regards,
Kuba
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============7638735801160896215==--

