Content-Type: multipart/mixed; boundary="===============4174876994168559939=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 20:34:47 +0200
Message-ID: <CAKSBH7Gs9aYgv7h9h-Nc7q6rqB3oXDw7+fX8dD9r_5oBPAyDgw@mail.gmail.com>
In-Reply-To: <8d07caca-7a05-5ad7-c17a-81647a2e6d2e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4174876994168559939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> In my 10+ years I've never seen a modem do this.  Some take 5 seconds,
> maybe 10.  I've never seen anything more than that, which is why that 20
> second value was quite conservative when I added it.

Yes, up to 2 years ago 15 seconds were enough. But with the new LTEA
and LTEApro chipset, it takes much longer.

>
> Anyhow, go ahead and add ofono_modem_set_powered_timeout_hint(unsigned
> int seconds) and have udevng detection fix this.

ok. I'll do it so.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============4174876994168559939==--

