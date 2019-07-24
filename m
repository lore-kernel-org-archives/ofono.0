Content-Type: multipart/mixed; boundary="===============1779008229804605028=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Check for auto activated contexts during init
Date: Wed, 24 Jul 2019 02:12:28 -0500
Message-ID: <4215da9b-bfdb-eb7e-edfe-99703c3a8214@gmail.com>
In-Reply-To: <20190724172419.29405-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1779008229804605028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 7/24/19 12:24 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> To detect if a context gets activated before we register
> for unsolicited events we need to check if any is
> already activated, and flag it auto activated.
> ---
>   drivers/atmodem/gprs.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============1779008229804605028==--

