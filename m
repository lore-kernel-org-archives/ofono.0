Content-Type: multipart/mixed; boundary="===============8132763436844494711=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/2] CPIN polling mechanism
Date: Wed, 20 Jul 2011 18:52:53 +0200
Message-ID: <1311180775-20983-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8132763436844494711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As no SIM card status urc is available with ZTE and Speedup, the SIM =

state is set by default to OFONO_SIM_STATE_INSERTED even if no SIM card =

is inserted. Also, we are facing with a modem latency after the ttyUSB =

is opened (first AT commands are failing and the PIN status query =

returns CME ERROR: 14 - SIM Busy).
So, to deal with those 2 issues, this patch set is introducing a =

preliminary PIN status polling in the ZTE/Speedup plugins. In practice, =

this polling is started after the modem is enabled and stopped when the =

CPIN query returns an other result than CME ERROR 14 or when the polling =

duration exceeds 5 seconds.
As a result, the SIM state is set according the result of the CPIN query =

and the update of the modem_powered state is postponed which delays the =

next AT commands.

Developed conjointly with philippe nunes.


Nicolas Bertrand (2):
  speedup: add cpin polling mechanism
  zte: add cpin polling mechanism

 plugins/speedup.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 plugins/zte.c     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 127 insertions(+), 2 deletions(-)

-- =

1.7.4.1


--===============8132763436844494711==--

