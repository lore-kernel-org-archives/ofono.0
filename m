Content-Type: multipart/mixed; boundary="===============0175979316122487128=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Sat, 11 Dec 2010 08:55:00 -0600
Message-ID: <4D0390C4.4010908@gmail.com>
In-Reply-To: <AANLkTikX7KpnQfPKv88NSG3Yt0LXAzYkPr=eE6S2k40X@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0175979316122487128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

> But it seems to me the gprs context will be pass to modem plugins, so we
> need to set the vendor code for Huawei modems, because it sends unquoted
> strings.

No, you don't.  You are confusing gprs atom and the gprs-context atom.
Grep for VENDOR in drivers/atmodem/gprs-context.c if you do not believe
me.  There is no vendor specific code in the atmodem gprs-context driver.

> =

> For example, please correct me if wrong, when the network registration
> status changed, ofono will invoke modem's set_attached() to handle the
> modem attach/detach.  Then, in gprs_attach_callback() in src/gprs.c, it
> will invokes modem's attached_status() to check the modem state, which
> has vendor dependent code in it.  Most importantly, after ofono sending
> AT+CGREG? to query the solicited response, the at_cgreg_cb() requires
> the correct vendor  ID so that at_util_parse_reg() knows whether the lac
> and ci are quoted strings or not?  Did I misunderstand?  Thanks.

As I mentioned before, this is needed for the gprs atom driver which
handles the CGREG parsing.  Not for gprs-context driver.

Regards,
-Denis

--===============0175979316122487128==--

