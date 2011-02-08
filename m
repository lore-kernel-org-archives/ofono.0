Content-Type: multipart/mixed; boundary="===============3709397674592826382=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Tue, 08 Feb 2011 17:16:07 +0200
Message-ID: <AANLkTinFDuN+Xr8w_-5_0W0-UXHkojAtdPwTjbV_06ue@mail.gmail.com>
In-Reply-To: <1296588776.2619.30.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3709397674592826382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/1 Aki Niemi <aki.niemi@nokia.com>:
> I'm starting to think me just saying this out loud is not concrete
> enough, so I guess one way forward here could be for me to go ahead and
> adapt e.g. the netreg driver to work with N900 and later ISI modems. The
> netreg driver would make a good example, as it is one of those where the
> resource ID changes post N900, and the messages do vary based on it.

I went ahead and pushed some patches refactoring the isimodem netreg
driver to work with both the old modem API as well as the new wgmodem
2.5 version.

Please take a look if it works for you.

Cheers,
Aki

--===============3709397674592826382==--

