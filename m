Content-Type: multipart/mixed; boundary="===============1438469455441710794=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 06/12] Refactor ussd parser
Date: Mon, 21 Jun 2010 17:09:36 +0300
Message-ID: <1277129376.9316.879.camel@tucson.research.nokia.com>
In-Reply-To: <201006161749.37762.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1438469455441710794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-17 at 00:49 +0200, ext Denis Kenzior wrote:
> Aki,
> =

> > ---
> >  drivers/isimodem/ussd.c |   36 +++++++-----------------------------
> >  1 files changed, 7 insertions(+), 29 deletions(-)
> > =

> =

> Please review this patch and comment on whether ISI modems can indeed sup=
port =

> UCS2 / 8Bit data along with 7 bit packed GSM.

ISI modems do support both GSM 7bit and UCS-2 in USSD, as the DCS field
is sent along with the USSD string.

Cheers,
Aki


--===============1438469455441710794==--

