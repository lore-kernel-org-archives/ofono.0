Content-Type: multipart/mixed; boundary="===============7642072430018111813=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: disabling reporting of intermediate results
 for CGDATA
Date: Thu, 20 Jun 2019 11:23:06 -0500
Message-ID: <28da69ae-3a49-0f53-e2a0-b6387991b1e6@gmail.com>
In-Reply-To: <1561032443-22383-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7642072430018111813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/20/2019 07:07 AM, Antara Borwankar wrote:
> Setting <connect_flag> in AT+XDATACHANNEL set command to 0. This will
> disable intermediate result reporting of "CONNECT" and "NO CARRIER"
> on control channel.
> =

> This resolves the issue of getting failure response for offline-modem
> since "NO CARRIER" is received as result of AT+CFUN operation instead
> of "OK".
> ---
>   drivers/ifxmodem/gprs-context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7642072430018111813==--

