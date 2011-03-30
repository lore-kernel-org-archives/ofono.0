Content-Type: multipart/mixed; boundary="===============4324194214622826916=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH] atmodem: gnss aggregate xml
Date: Wed, 30 Mar 2011 11:33:40 +0300
Message-ID: <1301474020.15057.19.camel@poutijar-desktop>
In-Reply-To: <1301404443.2572.110.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4324194214622826916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-03-29 at 16:14 +0300, Marcel Holtmann wrote:
> Hi Jarko,
> =

> this is never ever going to work. Global and public variables are a big
> no no.
> =

> First of all it would need to be static, but that is not going to help
> you since the GNSS atom can be instantiated multiple times. oFono
> supports multiple modems at the same time. And then you end up in a big
> mess.
> =

> Regards
> =

> Marcel

Oops sorry about that. Shouldn't do anything in haste.

Br,
Jarko


--===============4324194214622826916==--

