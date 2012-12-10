Content-Type: multipart/mixed; boundary="===============4056675033364057395=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Mon, 10 Dec 2012 10:49:35 -0600
Message-ID: <50C6129F.20006@gmail.com>
In-Reply-To: <50C5BEDF.8040709@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4056675033364057395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

> I also tried the HE910 and had the same problem. In case a PIN is
> required, the following solves the problem:
>
> In /drivers/atmodem/sim.c, at_qss_notify()
> case 2: /* PIN unlocked */
> has to be changed to
> case 3: /* SIM INSERTED and READY */
>
>
> After the PIN was entered, we wait until the modem states that the SIM
> is ready, i.e. #QSS: 3.
>
>
> I haven't found a proper way to do this in case there is no PIN required.
> We should only get to "post sim state" if we received #QSS: 3
>

The current work around is to signal sim_inserted only when you know it =

is ready.  This is less than ideal since oFono can read non-PIN =

protected files from the SIM as soon as the SIM is inserted (e.g. ICCID, =

EFpl, etc).  However, the modem behavior is quite strange in this area.

>
> Is it really unusual for a modem to deactivate the SIM in flight mode? I
> had a look at some mobile phones and they seem to deactivate the SIM in
> flight mode.
>

I've not seen one that turns off the SIM.  After all, it would be pretty =

inconvenient not to read SMS messages or access contacts, or mess with =

MSISDN, or any other setting that is on the SIM.

Regards,
-Denis

--===============4056675033364057395==--

