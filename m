Content-Type: multipart/mixed; boundary="===============2200322099289907505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [help] automatic data reconnection in case of signal loss
Date: Wed, 24 Dec 2014 12:38:13 -0600
Message-ID: <549B0815.2030700@gmail.com>
In-Reply-To: <549AD009.6@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2200322099289907505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

On 12/24/2014 08:39 AM, Mylene JOSSERAND wrote:
> Hi everyone,
>
>
> I am doing some tests with Ofono.
> Currently, I am trying to see if Ofono can handle an automatic data
> reconnection in case of signal loss.
>
> I am doing the following test :
> - Connect the modem to data connection via atmodem driver (so PPP link)
> - Disconnect the antenna to lose signal
> - Reconnect the antenna to get signal back
> - Try to get data connection back
>
> The atmodem driver is notified that the signal is lost so it disconnects
> ppp with "gprs-context.c:ppp_disconnect() Reason: 6".
> After re-connecting the antenna and that the network is back, in the
> Ofono interfaces, it did not changed, I always have the
> ConnectionManager interface. The difference is that the context is not
> activated. So, I try to re-activate it but it failed with error :
>
> gprs.c:pri_activate_callback() Activating context failed with error:
> Unknown error type
>
> I guess that someone should have test it before me. If it is the case,
> is there something I am doing wrong ? I do not know how Ofono should
> react in this case. Maybe it should remove some interfaces ? Go in
> "offline" mode ?
> If nobody tested it before, what should I look for ?
>
>

The modem is still in 'radio turned on' mode, e.g. online.  So as far as =

oFono is concerned, nothing has changed.

As to why your context activation fails, who knows.  oFono simply sends =

the command to the modem.  If the modem responds with an error, then you =

need to figure out why that happens.

Regards,
-Denis

--===============2200322099289907505==--

