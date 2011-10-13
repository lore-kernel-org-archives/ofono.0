Content-Type: multipart/mixed; boundary="===============8315893488630989407=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH] hfp: Expose BT address using the serial number
Date: Thu, 13 Oct 2011 18:32:15 +0200
Message-ID: <4E97128F.4090805@bmw-carit.de>
In-Reply-To: <4E96B0B9.3090509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8315893488630989407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Can we do this inside drivers/hfpmodem?

Sure. But before doing that, and despite my own patch, I would like to =

bring up the discussion whether this is the best approach :-)

I would suggest adding a optional property in org.ofono.Modem such as =

"HardwareAddress" to expose this information. I guess this might sound =

too bluetooth-specific, but still from my point of view it's the best =

way to go.

I guess it could even be pushed a bit further to make it more generic, =

trying to somehow encode the address type there (URI, etc.). Consider =

this an open proposal.

Cheers,
Mikel


--===============8315893488630989407==--

