Content-Type: multipart/mixed; boundary="===============3916050944761933345=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ZTE 3G dongle fails to work on Ofono
Date: Wed, 15 Jun 2011 03:31:29 -0500
Message-ID: <4DF86DE1.60404@gmail.com>
In-Reply-To: <CE59C043D0EC3349B2BF41C0EC72229B4D8B2C99@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3916050944761933345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/15/2011 10:31 PM, Deng, Ying An wrote:
> Hi,
> =

>  =

> =

> I am trying with ZTE MF180 USB dongles on ofono 0.48 version, but met
> with some error when authenticate SIM:
> =

> ofonod[2563]: Querying remaining pin retries failed
> =

> =


Feel free to ignore this error, it just means that the zte driver does
not implement PIN retry queries.  You would need to find the vendor
specific command that does this.

Regards,
-Denis

--===============3916050944761933345==--

