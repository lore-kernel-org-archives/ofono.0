Content-Type: multipart/mixed; boundary="===============8498415613305173361=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] gemalto: enable ELS81x modem
Date: Mon, 29 Jun 2020 10:21:16 -0500
Message-ID: <61212ad8-e718-df71-2a82-1ce5104aeac6@gmail.com>
In-Reply-To: <20200627110838.808865-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8498415613305173361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 6/27/20 6:08 AM, Sergey Matyukevich wrote:
> Hi all,
> =

> These two simple patches enable oFono support for ELS81x modem using
> cdc_ether/cdc_acm drivers. As far as I know, new firmwares for ELS81x
> enable support for MBIM as well. But I have not yet tried that.
> =

> Regards,
> Sergey
> =

> Sergey Matyukevich (2):
>    plugins: udevng: detect Centirion ELS81x modem
>    plugins: gemalto: enable LTE for ELS81x
> =

>   plugins/gemalto.c | 5 ++++-
>   plugins/udevng.c  | 2 ++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis
--===============8498415613305173361==--

