Content-Type: multipart/mixed; boundary="===============6953669285818595112=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: send restore settings command on startup
Date: Thu, 25 Jun 2020 11:36:41 -0500
Message-ID: <b73216fc-c903-f03a-d11f-003f5a56c2b3@gmail.com>
In-Reply-To: <20200625092954.4785-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6953669285818595112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:29 AM, Jimmy Gysens wrote:
> When initializing a Huawei device, send the AT&F0 command to restore the
> default AT settings on device restart.
> =

> Huawei stores all APN settings, which can cause issues when changing the
> APN. The AT&F0 command makes sure the device starts from a clean state.
> ---
>   plugins/huawei.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6953669285818595112==--

