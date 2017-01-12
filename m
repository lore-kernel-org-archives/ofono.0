Content-Type: multipart/mixed; boundary="===============5535887023506802565=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/1] atmodem: Fix CGDCONT result parsing.
Date: Thu, 12 Jan 2017 10:45:37 -0600
Message-ID: <968f5e44-fce5-bfb0-1560-e9626f62f5a5@gmail.com>
In-Reply-To: <1484240970-3406-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5535887023506802565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/12/2017 11:09 AM, Vincent Cesson wrote:
> From: vcesson <vincent.cesson@smile.fr>

Can you please fix up your Author information, we need proper names so =

that the patches can be applied.

>
> CGDCONT result parsing fails if first list contains several ranges.
> Solution: read first range and jump to second list.

Could you also include the offending +CGDCONT output in your commit =

description?

> ---
>  drivers/atmodem/gprs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Regards,
-Denis


--===============5535887023506802565==--

