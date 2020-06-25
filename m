Content-Type: multipart/mixed; boundary="===============4496748250720166810=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: the AT^SYSCFGEX command supports additional modes
Date: Thu, 25 Jun 2020 11:34:26 -0500
Message-ID: <8fde47c0-bf6e-d03f-9387-434015173590@gmail.com>
In-Reply-To: <20200625092942.4736-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4496748250720166810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:29 AM, Jimmy Gysens wrote:
> - LTE and UMTS preferred (acqorder =3D 0302);
> AT^SYSCFGEX=3D"0302",40000000,2,4,40000000
> =

> - UMTS and GSM preferred (acqorder =3D 0201);
> AT^SYSCFGEX=3D"0201",40000000,2,4,40000000
> =

> For AT^SYSCFG, the modes are not available.
> ---
>   drivers/huaweimodem/radio-settings.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4496748250720166810==--

