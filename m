Content-Type: multipart/mixed; boundary="===============2769659401795457486=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] atmodem: Fix CGDCONT result parsing.
Date: Fri, 13 Jan 2017 09:39:45 -0600
Message-ID: <24611947-392e-8cd2-4eef-884b06c5be70@gmail.com>
In-Reply-To: <1484314073-4009-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2769659401795457486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/13/2017 07:27 AM, Vincent Cesson wrote:
> CGDCONT result parsing fails if first list contains several ranges. For
> example with modem Cinterion PHS8:
>
>  AT+CGDCONT=3D?
>  +CGDCONT: (1-17,101-116),"IP",,,(0),(0-4)
>
> Solution: read first range and jump to second list instead of trying to
> close the brackets.
> ---
>  drivers/atmodem/gprs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============2769659401795457486==--

