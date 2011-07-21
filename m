Content-Type: multipart/mixed; boundary="===============7464596550791074164=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCHv2 0/2] CPIN polling mechanism
Date: Thu, 21 Jul 2011 12:01:51 +0200
Message-ID: <1311242513-17724-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7464596550791074164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2 changes:
 - change AT channel from modem to aux
 - raise timeout to 20 since some dongle take a while to be
   operational
 - send sim inserted notify related to the current status

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

 plugins/speedup.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++=
+-
 plugins/zte.c     |   67 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 2 files changed, 129 insertions(+), 4 deletions(-)

-- =

1.7.4.1


--===============7464596550791074164==--

