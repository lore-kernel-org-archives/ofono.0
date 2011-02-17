Content-Type: multipart/mixed; boundary="===============0182729680282333653=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Wed, 16 Feb 2011 18:19:17 -0800
Message-ID: <1297909157.2519.21.camel@aeonflux>
In-Reply-To: <4D5C119F.8050305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0182729680282333653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> This contradicts commit bb58a729073abcb6c5b0b2fb8b120973dfa42a07.
> > I can't quite understand why Dietrich needs to this commit. We formal c=
onfigure can just make EM770W works.
> > Could you help on this?
> =

> The Huawei firmware is funny, it can actually reconfigure the modem and
> pcui ports (e.g. swap them).  So we might have to be a bit smarter and
> figure out which ports are actually being used for what inside the modem
> driver.

so I did apply this patch now since in the default settings the MDM port
should be on interface 0. All other ones are tempered with.

> Talk to Marcel, I believe he has played with the Huawei hardware the
> most and might have ideas on how to fix this.

And yes, I will add auto-detection for this now. It should be be
possible to figure this out.

ofonod[908]: PCUI: > AT^GETPORTMODE\r
ofonod[908]: PCUI: < \r\n^getportmode:type:WCDMA:Qualcomm,MDM:0,NDIS:1,DIAG=
:2,PCUI:3\r\n\r\nOK\r\n

All latest modules support ^GETPORTMODE command and the ones that don't
have only two ports anyway.

Regards

Marcel



--===============0182729680282333653==--

