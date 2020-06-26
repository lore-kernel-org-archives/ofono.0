Content-Type: multipart/mixed; boundary="===============6301493335635797006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: fix AT^SYSCFGEX acqorder "0201"
Date: Fri, 26 Jun 2020 10:30:50 -0500
Message-ID: <25b99bc0-340c-30d1-ba6b-4fbb9164a462@gmail.com>
In-Reply-To: <20200626063640.20182-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6301493335635797006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/26/20 1:36 AM, Jimmy Gysens wrote:
> Commit 6c574ee24a57d0397e4e3c617016bf026405960a ("huawei: the AT^SYSCFGEX
> command supports additional modes") has a mistake for acqorder "0201". It
> should be UMTS and GSM preferred.
> ---
>   drivers/huaweimodem/radio-settings.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6301493335635797006==--

