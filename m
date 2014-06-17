Content-Type: multipart/mixed; boundary="===============4973617532637837966=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH] Add support for PAP authentication
Date: Tue, 17 Jun 2014 23:57:56 +0200
Message-ID: <1403042279-20598-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4973617532637837966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some operators require PAP authentication instead of the more prevalent CHA=
P.
This is particularly true in the case of private APNs for machine to machine
communication.

These patches add support for PAP in the PPP library and glue for configuri=
ng
and provisioning contexts to use it.  The default is still to use CHAP, so
current behaviour shouldn't change unexpectedly.


Philip Paeps (3):
      gatchat: implement PAP authentication
      gprs: make PPP authentication method configurable
      mbpi: add authentication methods to provisioning

 doc/connman-api.txt            |    4 ++++
 drivers/atmodem/gprs-context.c |   14 ++++++++++++++
 gatchat/gatppp.c               |   50 ++++++++++++++++++++++++++++++++++++=
++++++++++++--
 gatchat/gatppp.h               |    8 ++++++++
 gatchat/ppp.h                  |    9 +++++++++
 gatchat/ppp_auth.c             |  139 ++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++
 gatchat/ppp_lcp.c              |   68 ++++++++++++++++++++++++++++++++++++=
+++++++++++++-------------------
 include/gprs-context.h         |    6 ++++++
 include/gprs-provision.h       |    1 +
 plugins/mbpi.c                 |   32 ++++++++++++++++++++++++++++++++
 plugins/provision.c            |    1 +
 src/gprs.c                     |   83 ++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 394 insertions(+), 21 deletions(-)


--===============4973617532637837966==--

