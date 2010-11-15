Content-Type: multipart/mixed; boundary="===============1056383974435914258=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/5] Call Counters 
Date: Mon, 15 Nov 2010 13:50:07 +0200
Message-ID: <cover.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1056383974435914258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here a proposal for call counters implementation for keeping track
of the total incoming and outgoing call duration counters. Each
established call instance is contributing to either of the call
duration counters. The 2 counters are updated periodically when
there is an established call and the information is stored in
a file. The bookkeeping of the call duration counters are per IMSI
number.
The implementation makes use of the history framework which had to be
expanded with a function for marking the beginning of a voice call.
There is a D-Bus interface to call counters for reading and clearing
the counters.

Andras Domokos (5):
  history: expand history API include file
  history: expand history API
  voicecall: take into use the new history function
  voicecall: add call counters
  Makefile: add call counters to the build

 Makefile.am        |    3 +
 include/history.h  |    3 +
 src/callcounters.c |  388 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/history.c      |   24 ++++
 src/ofono.h        |    4 +
 src/voicecall.c    |    3 +
 6 files changed, 425 insertions(+), 0 deletions(-)
 create mode 100644 src/callcounters.c


--===============1056383974435914258==--

