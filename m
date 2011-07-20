Content-Type: multipart/mixed; boundary="===============0737489644818820657=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 18:13:52 +0200
Message-ID: <1311178433.21109.249.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F0620D@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0737489644818820657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> >For you two TTY cases. That is normal. Huawei treats the first TTY as
> >modem to issue PPP on it. And the second one (PCUI) is used for
> >notifications. So yes, oFono needs to open both. You will need the
> >second one for network registration updates.
> =

> But I think that if you send ATD on a channel, you should receive the CON=
NECT in the same channel. It's an answer, not a notification.

you do remember me talking about how broken some modems are ;)

So here you go. Wait until you deal with stuff like unsolicited
notification and which channel they appear on. Working with IFX or MBM
hardware is a dream compared to this ;)

Regards

Marcel



--===============0737489644818820657==--

