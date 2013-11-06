Content-Type: multipart/mixed; boundary="===============7894258655766173233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: regarding to simManager
Date: Tue, 05 Nov 2013 20:22:14 -0600
Message-ID: <5279A7D6.20401@gmail.com>
In-Reply-To: <CAHtt_wmkN7qBKLJmWoeq1RaRuJ5t37St-3DFdx_bDb2gZPQU4w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7894258655766173233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

<snip>

 > ofonod[1566]: < AT+CPIN?
> ofonod[1566]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
> ofonod[1566]: drivers/atmodem/sim.c:at_pin_retries_query()
> ofonod[1566]: <  AT+CPINR
> ofonod[1566]: < AT+CRSM=3D192,28590,0,0,255
> ofonod[1566]:Querying remaining pin retries failed
> ofonod[1566]: < AT+CRSM=3D192,28589,0,0,255
>
> Once this happens(ofono stop after AT+CRSM), I can only list the modem
> with the feature "sim"

It is hard to tell from your log what is going on.  Is your oFono =

modified in some way?  The AT command logging should print commands =

sent, echo (if any) and command responses.  I'm not seeing that here.

Do you get a response to the last CRSM command sent?  If not, then =

likely the modem crashed.  The two CRSM commands you see above are =

querying EFad and EFphase.  Right after there should be some more EFs =

being read followed by reading of the IMSI (+CIMI)

<snip>

>
> Here is my question,
> 1, why does it happen randomly?

Who knows.

> 2, what does "Querying remaining pin retries failed" mean? this message
> is showing up even when the ofono is working fine.

It just means that the sim atom driver does not implement this =

functionality.  It should probably be changed from a warning to a debug =

message.

> 3, sometimes all the module had been loaded, but the connection manager
> will disappear.

Impossible to tell without a log.

Regards,
-Denis

--===============7894258655766173233==--

