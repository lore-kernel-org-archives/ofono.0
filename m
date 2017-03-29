Content-Type: multipart/mixed; boundary="===============1759674176551014858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] atmodem: telit - re-attach gprs automatically
Date: Wed, 29 Mar 2017 10:02:16 -0500
Message-ID: <183cc971-f700-5713-fbc5-2a8120fc41a7@gmail.com>
In-Reply-To: <1490786101-5054-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1759674176551014858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/29/2017 06:15 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit AT modem firmware (tested with UE910-EUR) generates
> +CGREG: 0\r\n\r\n+CGEV: NW DETACH
> after a context is de-activated and ppp connection closed.
> Then, after a random amount of time (observed from a few seconds
> to a few hours), an unsolicited +CGREG: 1 arrives.
> Attempt to fix the problem, by sending AT+CGATT=3D1 once.
> This does not re-activate the context, but if a network connection
> is still correct, will generate an immediate +CGREG: 1.
> ---
>  drivers/atmodem/gprs.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============1759674176551014858==--

