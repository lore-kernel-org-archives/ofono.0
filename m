Content-Type: multipart/mixed; boundary="===============0599728271660249531=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Split AT+VTS command into multiple +VTS
Date: Sat, 21 Jun 2014 12:05:21 -0500
Message-ID: <53A5BB51.2070604@gmail.com>
In-Reply-To: <1403251431-17518-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0599728271660249531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergio,

On 06/20/2014 03:03 AM, Sergio Checa Blanco wrote:
> From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>
> =

> According to the standard "3GPP 27.007 v6.8.0" Appendix C.2.11,
> when sending multiple DTMF characters, these must go in individual
> +VTS commands for each tone. This adopts the AT modem approach.
> =

> Before: AT+VTS=3D1234\r
> After:  AT+VTS=3D1;+VTS=3D2;+VTS=3D3;+VTS=3D4\r
> ---
>  drivers/hfpmodem/voicecall.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Patch has been applied, thanks.

Regards,
-Denis


--===============0599728271660249531==--

