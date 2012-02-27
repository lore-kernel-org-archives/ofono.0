Content-Type: multipart/mixed; boundary="===============7133789510386968131=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: HSO modem, apparent confusion between App and Control ports
Date: Mon, 27 Feb 2012 22:24:31 +0000
Message-ID: <87r4xfgbj4.fsf@neil-laptop.ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7133789510386968131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm using an HSO modem in a GTA04 device, and have a UI that, on session
startup, powers the modem on, and sets it online.

Sometimes - after roughly 50% of reboots - the setting online times out,
and I've established that this is because there's still a preceding
command in chat->command_queue, when hso_set_online() is called.  So the
real problem is that the preceding AT command appears to the code not to
have completed.

I've looked at the logs and identified a significant-looking difference
between a good run and a bad one.  In a good run, the ofonod log
(following powering on), leading up to the point of divergence, has:

Feb 27 22:01:59 gta04 daemon.info ofonod[983]: Control: > AT_OERCN?\r
Feb 27 22:01:59 gta04 daemon.info ofonod[983]: Control: < \r\n_OERCN: 3, 10=
\r\n\r\nOK\r\n
Feb 27 22:01:59 gta04 daemon.debug ofonod[983]: drivers/atmodem/sim.c:oercn=
_cb() retry counter id=3D1, val=3D3
Feb 27 22:01:59 gta04 daemon.debug ofonod[983]: drivers/atmodem/sim.c:oercn=
_cb() retry counter id=3D9, val=3D10
Feb 27 22:01:59 gta04 daemon.info ofonod[983]: Control: > AT+CRSM=3D192,285=
90\r
Feb 27 22:02:00 gta04 daemon.info ofonod[983]: Control: < \r\n+CRSM: 106,13=
0,""\r\n\r\nOK\r\n
Feb 27 22:02:00 gta04 daemon.info ofonod[983]: Control: > AT+CRSM=3D176,285=
89,0,0,4\r
Feb 27 22:02:00 gta04 daemon.info ofonod[983]: Control: < \r\n+CRSM: 144,0,=
"00FFFF02"\r\n\r\nOK\r\n
Feb 27 22:02:00 gta04 daemon.debug ofonod[983]: drivers/atmodem/sim.c:at_cr=
sm_read_cb() crsm_read_cb: 90, 00, 4
Feb 27 22:02:00 gta04 daemon.debug ofonod[983]: src/simfs.c:sim_fs_op_read_=
block_cb() bufoff: 0, dataoff: 0, tocopy: 4
Feb 27 22:02:00 gta04 daemon.info ofonod[983]: Control: > AT+CRSM=3D192,284=
38\r
Feb 27 22:02:00 gta04 daemon.info ofonod[983]: Control: < \r\n+CRSM: 106,13=
0,""\r\n\r\nOK\r\n

But in a bad run, the last line is different:

Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: > AT_OERCN?\r
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: < \r\n_OERCN: 3, 10=
\r\n\r\nOK\r\n
Feb 27 21:52:33 gta04 daemon.debug ofonod[996]: drivers/atmodem/sim.c:oercn=
_cb() retry counter id=3D1, val=3D3
Feb 27 21:52:33 gta04 daemon.debug ofonod[996]: drivers/atmodem/sim.c:oercn=
_cb() retry counter id=3D9, val=3D10
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: > AT+CRSM=3D192,285=
90\r
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: < \r\n+CRSM: 106,13=
0,""\r\n\r\nOK\r\n
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: > AT+CRSM=3D176,285=
89,0,0,4\r
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: < \r\n+CRSM: 144,0,=
"00FFFF02"\r\n\r\nOK\r\n
Feb 27 21:52:33 gta04 daemon.debug ofonod[996]: drivers/atmodem/sim.c:at_cr=
sm_read_cb() crsm_read_cb: 90, 00, 4
Feb 27 21:52:33 gta04 daemon.debug ofonod[996]: src/simfs.c:sim_fs_op_read_=
block_cb() bufoff: 0, dataoff: 0, tocopy: 4
Feb 27 21:52:33 gta04 daemon.info ofonod[996]: Control: > AT+CRSM=3D192,284=
38\r
Feb 27 21:52:34 gta04 daemon.info ofonod[996]: App: < \r\n+CRSM: 106,130,""=
\r\n\r\nOK\r\n\r\n_OSIGQ: 0,0\r\n\r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n\r\n_OSSY=
SI: 3\r\n

I.e. firstly the AT+CRSM reply appears to be on the wrong channel, and
secondly it seems to have a whole load of further replies or unsolicited
indications tacked on.

If the problem isn't already obvious, from the above, can you advise
what more I can do to debug or fix this?  It seems clear that the above
is wrong, but I don't yet understand ofono well enough to have a clue
what the right fix might be.

Thanks,
        Neil

--===============7133789510386968131==--

