Content-Type: multipart/mixed; boundary="===============4352822555458973667=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] plugins: support for Telit LE910 V2 modem
Date: Wed, 25 Jan 2017 10:37:15 -0600
Message-ID: <9d8917de-c2ec-70e5-32fb-64ccc5897de2@gmail.com>
In-Reply-To: <20170125104128.5254-3-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4352822555458973667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 04:41 AM, Piotr Haber wrote:
> LE910 V2 is next generation Telit LTE modem.
> It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
> Default USB composition uses PID 0x36 and
> consists of 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
> ---
>  Makefile.am       |   3 +
>  plugins/le910v2.c | 400 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 403 insertions(+)
>  create mode 100644 plugins/le910v2.c
>

Can you add the LE910 changes into the HE910 driver?  The two are 99% =

the same except for HE910 supporting voice calls and LE910 using a =

different gprs_context driver.

There's no sense in maintaining a 400 line driver that is virtually =

identical to what we already have.

Regards,
-Denis


--===============4352822555458973667==--

