Content-Type: multipart/mixed; boundary="===============8289600750186252944=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC 0/3] Fix crash when network is lost
Date: Thu, 31 May 2012 11:59:05 +0200
Message-ID: <1338458348-335-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8289600750186252944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Problem description:
Some Huawei modems are trying to keep PPP session with the network alive ev=
en if the network is lost.
Thus oFono PPP session with the modem is never ended. Currently when networ=
k is lost, oFono will release the active contexts into the core however the=
 context is still active at driver level. If the connection with the networ=
k is established again and we try to enable a data call, we have a crash.

This issue is very tricky there might be multiple solutions, here is one I =
discussed with Denis yesterday.
A new driver entry is added to release context into the driver in shutting =
down the PPP session between oFono and the modem.
Then ofono_context_deactivated() is called to signal the context is inactiv=
e at driver level.
In the case we lost the network and we are reattaching to the network but t=
he PPP session had no time to be released, there is a mechanism to wait for=
 the previous context to be released and then signal modem is reattached to=
 the network. ConnMan can do again a data call.

Guillaume Zajac (3):
  gprs-context: Add new driver entry
  gprs-context: Add new driver entry definition
  gprs: Release context in driver and core when network is lost

 drivers/atmodem/gprs-context.c |   11 +++++
 include/gprs-context.h         |    2 +
 src/gprs.c                     |   84 ++++++++++++++++++++++++++++++------=
----
 3 files changed, 76 insertions(+), 21 deletions(-)

-- =

1.7.5.4


--===============8289600750186252944==--

