Content-Type: multipart/mixed; boundary="===============1376634070384540295=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Tue, 02 Feb 2010 17:20:45 -0600
Message-ID: <201002021720.45314.denkenz@gmail.com>
In-Reply-To: <61D8D34BB13CFE408D154529C120E079032A1FEC@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1376634070384540295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Hi Denis.
> =

> We have done some testing with the STE modem for call termination, and th=
is
>  is the result:
> =

> TC |Call #1 | Call #2 | Call #3  | Command   | Result
> ---|--------------------------------------------------------------------
> 1  |ACTIVE  | ACTIVE  | ..       | ATH         | call 1, 2 terminated
> 2  |ACTIVE  | ACTIVE  | ..       | AT+CHUP     | call 1, 2 terminated
> 3  |ACTIVE  | ACTIVE  | HELD     | ATH         | call 1, 2 terminated
> 4  |ACTIVE  | ACTIVE  | HELD     | AT+CHUP     | call 1, 2 terminated
> 5  |ACTIVE  | ACTIVE  | HELD     | AT+CHLD=3D0;H | call 1, 2 and 3 termin=
ated
> 6  |ACTIVE  | ACTIVE  | WAITING  | ATH         | call 1, 2 terminated
> 7  |ACTIVE  | ACTIVE  | WAITING  | AT+CHUP     | call 1, 2 terminated
> 8  |ACTIVE  | HELD    | WAITING  | CHLD=3D0      | call 3 terminated,
> 9  |ACTIVE  | HELD    | WAITING  | ATH         | call 1 terminated
> 10 |ACTIVE  | HELD    | WAITING  | AT+CHUP     | call 1 terminated
> 11 |HELD    | HELD    | ACTIVE   | AT+CHLD=3D0   | call 1, 2 terminated
> 12 |HELD    | HELD    | ACTIVE   | AT+CHLD=3D0;H | call 1, 2 and 3 termin=
ated
> 13 |HELD    | DIALING | ..       | ATH         | call 2 (MO) terminated
> 14 |HELD    | DIALING | ..       | CHUP        | call 2 (MO) terminated
> 15 |HELD    | DIALING | ..       | AT+CHLD=3D12  | call 2 (MO) NOT termin=
ated
> 16 |HELD    | WAITING | ..       | AT+CHLD=3D0   | call 2 terminated
> 17 |HELD    | ..      | ..       | ATH         | call 1 NOT terminated

Great table, makes it very easy to see what is going on.  It looks like STE =

modems treat ATH and CHUP as only affecting dialing/alerting/active calls a=
nd =

incoming calls, not held calls or waiting calls.

> > The standards are quite clear here, the WAITING call always takes
> > precedence and thus only the WAITING call is affected. Can you check
> > that STE modems do indeed get this wrong?  If the modem is standards
> > compliant, oFono does the right thing here.
> =

> STE is standard compliant, only the WAITING call is terminated with
>  AT+CHLD=3D0. (TC 8)

Excellent, I would have been surprised if STE behaved otherwise :)

> =

> >> c) If you have an call on hold and initiate a new call, but want to
> >> terminate the newly initiated call (DIALING), then this call cannot
> >> be terminated with CHLD=3D1X, but you would have to use ATH (or
> >> possible CHUP).
> >
> > Yes, so this is the case that we do need to take care of in the core.
> > Most
> > modems let us get away with sending release_specific up to this point.
> =

> For the STE modem, calls in state DIALING and ALERTING will have to be
>  terminated with ATH or AT+CHUP, AT+CHLD=3D1x does not work. This means t=
hat
>  the current implementation, using release_specific (and thus AT+CHLD=3D1=
x)
>  will not work.

Yep, so please critique my earlier suggestion of splitting up hangup into t=
wo =

methods: hangup_all and hangup_active.  Modem drivers will need to provide =
one =

or the other or both.

The core can then use the hangup_active (if available) in those cases where =

release_specific might not work.  The condition for hangup_active will be t=
hat =

it does not affect held or waiting calls.  For ST-E the hangup_active =

implementation will simply be +CHUP.  For modems that do not have this =

available we will fall back to release_specific and assume that on those =

CHLD=3D1X or equivalent can affect dialing/alerting calls.

hangup_all can also be used for cases where we loop release_specific over a=
ll =

active/dialing/alerting/held/incoming calls.  For ST-E the hangup_all =

implementation might be +CHUP;CHLD=3D1n;...;+CHLD=3D1m where n, m, etc are =
ids of =

the HELD calls.  We should not hangup waiting calls to be compliant with =

section 6.5.5.1 of 3GPP 22.030: "Entering END	-	Releases the subscriber fro=
m =

all calls (except a possible waiting call)."

If this sounds OK then I will work on implementing the logic in the next fe=
w =

days.

Regards,
-Denis

--===============1376634070384540295==--

