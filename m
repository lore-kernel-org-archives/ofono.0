Content-Type: multipart/mixed; boundary="===============3160335854579264350=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: [RFC 0/3] Adding DUN support.
Date: Thu, 07 Jul 2011 10:45:20 +0200
Message-ID: <1310028323-29180-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3160335854579264350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

Hi all,

find attached a first rudimentary implementation of DUN support for oFono.

The approach of bringing in DUN via an additional modem driver was
discussed before shortly on IRC. As I am new to open source in general
and oFono in this special case, I just wanted to make sure I am on the
right track here.

Basically, I 'faked' the network registration and try to bring up PPP
within the gprs-context.

ConnMan can find the context and bring it up (gprs-context.c).
Starting PPP the way I did it in the patch does not seem to work
though. It results in:

ofonod[25318]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
ofonod[25318]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
ofonod[25318]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
ofonod[25318]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
ofonod[25318]: PPP: lcp: pppcp_initialize_restart_count: current state 2:CL=
OSED
ofonod[25318]: PPP: lcp: pppcp_send_configure_request: current state 2:CLOS=
ED
ofonod[25318]: PPP: gatchat/gatppp.c:ppp_enter_phase() 1
ofonod[25318]: drivers/dunmodem/gprs-context.c:setup_ppp() PPP is open
ofonod[25318]: PPP: lcp: pppcp_timeout: current state 6:REQSENT
ofonod[25318]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[25318]: PPP: event: 4 (TO+), action: 1006, new_state: 6 (REQSENT)
ofonod[25318]: PPP: lcp: pppcp_send_configure_request: current state 6:REQS=
ENT
ofonod[25318]: PPP: lcp: pppcp_timeout: current state 6:REQSENT
ofonod[25318]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[25318]: PPP: event: 4 (TO+), action: 1006, new_state: 6 (REQSENT)
ofonod[25318]: PPP: lcp: pppcp_send_configure_request: current state 6:REQS=
ENT


I'm surely missing something obvious here, so I would be glad to get
some hints whether I am heading into the right direction.

One more note: As of now, ConnMan specifically queries the device it
finds via oFono as to whether it has a SIM active (the information is
only checked but not used in an other contex). I did not implement the
SIM interface for DUN, it does not seem to be needed. Still as a
result, a minor patch to ConnMan is needed in order to use the patch
(upto the point of trying to ocnnect to via PPP on RFCOMM).

I am going to push that topic also to the ConnMan list.

Thx,
Mario

Mario Tokarz (3):
  dunmodem: Add baseline for DUN modem driver.
  bluetooth: Add UUID for DUN.
  dun_dt: Add baseline for dun_dt plug-in.

 Makefile.am                             |   11 +
 drivers/dunmodem/dunmodem.c             |   55 +++++
 drivers/dunmodem/dunmodem.h             |   39 ++++
 drivers/dunmodem/gprs-context.c         |  207 +++++++++++++++++++
 drivers/dunmodem/gprs.c                 |  101 +++++++++
 drivers/dunmodem/network-registration.c |   96 +++++++++
 plugins/bluetooth.h                     |    2 +
 plugins/dun_dt.c                        |  337 +++++++++++++++++++++++++++=
++++
 8 files changed, 848 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dunmodem/dunmodem.c
 create mode 100644 drivers/dunmodem/dunmodem.h
 create mode 100644 drivers/dunmodem/gprs-context.c
 create mode 100644 drivers/dunmodem/gprs.c
 create mode 100644 drivers/dunmodem/network-registration.c
 create mode 100644 plugins/dun_dt.c

-- =

1.7.4.1


--===============3160335854579264350==--

