Content-Type: multipart/mixed; boundary="===============7491133189491656358=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/5] Call Counters (2nd)
Date: Mon, 22 Nov 2010 18:25:54 +0200
Message-ID: <cover.1290442823.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7491133189491656358==
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
  plugins: add call counters
  doc: call counters API doc

 Makefile.am              |    3 +
 doc/callcounters-api.txt |   18 ++
 include/history.h        |    3 +
 plugins/callcounters.c   |  388 ++++++++++++++++++++++++++++++++++++++++++=
++++
 src/history.c            |   24 +++
 src/ofono.h              |    4 +
 src/voicecall.c          |    3 +
 7 files changed, 443 insertions(+), 0 deletions(-)
 create mode 100644 doc/callcounters-api.txt
 create mode 100644 plugins/callcounters.c


--===============7491133189491656358==--

