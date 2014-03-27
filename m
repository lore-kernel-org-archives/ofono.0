Content-Type: multipart/mixed; boundary="===============1136935781066053997=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: problem sim status
Date: Thu, 27 Mar 2014 15:30:50 -0500
Message-ID: <53348A7A.3040805@gmail.com>
In-Reply-To: <lh218l$pqc$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1136935781066053997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> ok, i will add this, but if i understand well, this is for +CPIN request
> AFTER sending a PIN. (but i mean my modem need this too.)
> =

> my problem is when modem is added throught dbus/ofono, ofono send somes
> init commands and finaly i mean sim-manager send an +CPIN request to
> know if SIM is locked or not... THIS request fail with CME error 14
> because of too fast query.
> =


Ah, its one of those modems that doesn't have a sim ready notification.
 In that case you probably need to run CPIN queries as part of the modem
power-up procedure.  See examples in plugins/zte.c and plugins/speedup.c
(cfun_enable & sim_state_cb)

Regards,
-Denis

--===============1136935781066053997==--

