Content-Type: multipart/mixed; boundary="===============1751686793578880488=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Mon, 10 Dec 2012 13:20:42 +0100
Message-ID: <50C5D39A.3070007@hale.at>
In-Reply-To: <50C1F5E8.2030803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1751686793578880488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> I read the description of CFUN in that document and got lost rather =

> quickly.  The bottom line is that oFono does not use any serial =

> signaling, so all of these DTR and RTS conditions do not apply.  If =

> the Telit modems do not support radio off with SIM on, then you need =

> to structure the driver differently, most likely removing the 'online' =

> method implementation would do what you want, and use only =

> enable/disable.  In theory that should work putting the modem online =

> as soon as the sim is in the ready state. =


OFONO_SIM_STATE_READY is set in sim.c, sim_set_ready() when the IMSI was =

obtained.
What do you think about letting modems (plugins), which have a SIM state =

notification, set that state on their own?


Regards,

Christopher


--
Scanned by MailScanner.


--===============1751686793578880488==--

