Content-Type: multipart/mixed; boundary="===============0314963512615654529=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: SimManager properties and hotswap
Date: Fri, 12 Jun 2015 16:05:01 +0300
Message-ID: <CAAVgdeF_trBzArPR9zhKN-pSY1fdj0YRTKjmcfVENV3vKHjbYQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0314963512615654529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Greetings

There's an issue for which I'd like to hear your opinion.
ofono_sim_inserted_notify signals org.ofono.SimManager Present property tru=
e,
but PinRequired and LockedPins are known only after
__ofono_sim_recheck_pin asks them from driver.
Problem can arise at startup but I've met this especially during
hotswap i.e. when I remove and insert the same/different card.
If a driver completes query_passwd_state synchronously there's less
room for problems, but if driver has to find out the values
asynchronously the time window is longer.
I'm using an implementation of rilmodem, but even the default atmodem
driver asks password state asynchronously (AT+CPIN?).

Problem1
If a client, for example triggered by the Present property change
signal, asks GetProperties during the time window then PinRequired &
LockedPins values are not updated yet.

Problem2
A client can't work around Problem1, it doesn't know when after a
hotswap PinRequired becomes available. sim_pin_query_cb checks
"sim->pin_type =3D pin_type" before emitting PinRequired changed signal.
Works for boot when pin_type is 0 but not for card hotswap because
sim->pin_type is not reset, instead the old value is preserved.
One fix proposal to Problem2 is to reset pin_type to
OFONO_SIM_PASSWORD_INVALID in ofono_sim_inserted_notify when removed.
That requires skipping appending PinRequired in sim_get_properties()
if value is OFONO_SIM_PASSWORD_INVALID, otherwise
ofono_dbus_dict_append crashes because sim_passwd_name() didn't have a
value for OFONO_SIM_PASSWORD_INVALID.
(I would've put resetting to sim_free_main_state(), but that's called
when changing PIN fails due to wrong passwords and sim app switches
PUK lock (OFONO_SIM_STATE_LOCKED_OUT), it would reset the password
type already set as puk.)

Problem3
Similar for LockedPins, but there reason is sim_pin_query_cb() doesn't
emit property change all.
Fix proposal to Problem3 is to emit a change signal sim_pin_query_cb()
if "sim->locked_pins[pin_type]" wasn't already TRUE.

Please let me know your comments and improvement ideas. I can submit
patches if you're interested.

-- =

Tommi

--===============0314963512615654529==--

