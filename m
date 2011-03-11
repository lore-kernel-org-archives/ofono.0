Content-Type: multipart/mixed; boundary="===============5360419154231615042=="
MIME-Version: 1.0
From: Debanjan Biswas (debiswas) <debiswas@cisco.com>
Subject: RE: Request for info for issuing AT commands
Date: Fri, 11 Mar 2011 11:38:01 +0530
Message-ID: <35DD4A1E71A66646BF42B14F8A62B7AC040EFAF3@XMB-BGL-419.cisco.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75A8ABE140@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5360419154231615042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the info Bertrand. I will have a look.

Regards
Debanjan

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Aygon, Bertrand
Sent: Thursday, March 10, 2011 6:40 PM
To: ofono(a)ofono.org
Subject: RE: Request for info for issuing AT commands

> Thanks Bertrand for your mail. I am working on the Audio Gateway side & I=
 am looking for APIs for receiving AT commands like AT+ATA, =

> AT+CHUP, AT+BLDN, AT+Ddd...dd, AT+VGS, AT+VGM, etc & for sending events l=
ike VGM,VGS,CIEV, etc.
>
> Any informations on how to build a application for these will be really h=
elpful.

An application?

Some people (Frederic Danis and Frederic Dalleau) are currently working on =
the HFP support inside oFono. You can have a look at the oFono TODO file. T=
here will be an atom inside oFono that will do this.

If you want to do this outside oFono, you will have to write an application=
 that will analyze AT command received from BlueZ, and translate them into =
oFono APIs.

Regards,

Bertrand.

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Aygon, Bertrand
Sent: Thursday, March 10, 2011 4:15 PM
To: ofono(a)ofono.org
Subject: RE: Request for info for issuing AT commands

Hi,

> Hi Everyone,
>
>=C2=A0I am new to this list.

Welcome!

> I am looking for the oFono APIs that I can use to issue the AT commands f=
or HFP. I could not found much info on the oFono site. =

> It will be great help if someone can guide to any links/documents.

Can you please clarify this. What can of APIs are you looking at, and for w=
hich purpose?

We are working on HFP support in oFono, and on the AT Emulator to support a=
ll mandatory AT command for HFP.
But there should be no dedicated API for HFP inside oFono.

Regards,

Bertrand.
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

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
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

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============5360419154231615042==--

