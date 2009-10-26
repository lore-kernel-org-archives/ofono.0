Content-Type: multipart/mixed; boundary="===============8432574416997163973=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: SIM PIN unlock
Date: Mon, 26 Oct 2009 13:59:20 +0100
Message-ID: <4AE59D28.3090304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8432574416997163973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have noticed a difference of ofono on startup. If the PIN number is =

not required, the daemon never gets past CRSM query, and the remaining =

interfaces are not added.

But if the PIN number has not been entered, things work as they should.

Scenario 1:

The SIM card needs the PIN number to work.

ofonod[8203]: attr_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: SIEMENS
ofonod[8203]: at_cpin_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: +CPIN: SIM PIN
ofonod[8203]: crsm_pin_cb: SIM PIN
ofonod[8203]: at_crsm_info_cb got result: 0
ofonod[8203]: Final response: ERROR
ofonod[8203]: attr_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: MC75
ofonod[8203]: at_crsm_info_cb got result: 0
ofonod[8203]: Final response: ERROR
ofonod[8203]: attr_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: REVISION 03.010
ofonod[8203]: at_crsm_info_cb got result: 0
ofonod[8203]: Final response: ERROR
ofonod[8203]: src/voicecall.c:ecc_read_cb() 0
ofonod[8203]: attr_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: 35****
ofonod[8203]: at_lock_unlock_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: at_cpin_cb got result: 1
ofonod[8203]: Final response: OK
ofonod[8203]: Response line: +CPIN: READY
ofonod[8203]: crsm_pin_cb: READY

Scenario 2:

The daemon has been restarted (following correct SIM PIN number insertion).

ofonod[16456]: attr_cb got result: 1
ofonod[16456]: Final response: OK
ofonod[16456]: Response line: SIEMENS
ofonod[16456]: at_cpin_cb got result: 1
ofonod[16456]: Final response: OK
ofonod[16456]: Response line: +CPIN: READY
ofonod[16456]: crsm_pin_cb: READY


Thanks,
Ryan

--===============8432574416997163973==--

