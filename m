Content-Type: multipart/mixed; boundary="===============5323593566795961834=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem: gprs-context: parse list-less CGDATA response
Date: Fri, 19 Jul 2019 10:35:03 -0500
Message-ID: <1ed3584f-8bcb-d75b-fc47-2e737924f33e@gmail.com>
In-Reply-To: <20190719102746.122911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5323593566795961834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/19/19 5:27 AM, Martin Hundeb=C3=B8ll wrote:
> The Quectel M95 and MC60 modems respond to AT+CGDATA=3D? with a single
> +CGDATA=3D"PPP", but the callback in gprs-context expects a list of
> protocols.
> =

> Avoid falling back to the old-style ATD*99 by not expecting a list of
> protocols for serial quectel modems.
> ---
>   drivers/atmodem/gprs-context.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis


--===============5323593566795961834==--

