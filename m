Content-Type: multipart/mixed; boundary="===============2975922167278457862=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problems with voice call.
Date: Tue, 14 Jul 2009 08:17:36 +0200
Message-ID: <1247552256.4549.18.camel@violet>
In-Reply-To: <4A5C1CA4.8060204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2975922167278457862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> thanks for the reply. I was not sure about the voice call features of
> the modem. Now when I searched the answer I found out that the modem
> does not in fact support voice calls.
> =

> I did not realize this at first, because ofono offered the possibility
> for voice calls (loaded for example the VoiceCallManager interface). For
> SMS ofonod says
> =

> ofonod[7906]: SMS not supported by this modem.  If this is in error
> please submit patches to support this hardware
> =

> however the modem has a support for SMS, which I also tested with the
> windows drivers that were delivered with the modem.
> =

> Maybe there could be similar "not supported" feature for the voice call
> plugins?

we need better hardware detection and enumeration and might have to add
detailed feature mask to each modem. So we can tell if such a modem
supports voice calls etc.

Regards

Marcel



--===============2975922167278457862==--

