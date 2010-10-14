Content-Type: multipart/mixed; boundary="===============4508924823465961604=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem/sms: do not try to save SCA to SIM
Date: Thu, 14 Oct 2010 15:49:19 +0300
Message-ID: <AANLkTimPwFh5ioDeOJb4C1BJBFOYsVNGBZ0p+_ux_zkY@mail.gmail.com>
In-Reply-To: <1286960427-2267-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4508924823465961604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2010/10/13  <Pekka.Pessi@nokia.com>:
> It does not make sense to overwrite the SCA on SIM card, especially with
> random bytes from the stack.

The request is telling the modem to only look for the SCA and skip the
rest. That nosy sob just can't help put look anyway, can it? ;)

Fixed this by initializing the filler.

> AT command +CSCA does not write to SIM either, rather it saves the SCA
> address to be used with further text mode SMSs.

But the ServiceCenterAddress property is read from the SIM, so it
seems only logical to write to the same place.

Cheers,
Aki

--===============4508924823465961604==--

