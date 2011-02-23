Content-Type: multipart/mixed; boundary="===============8240362910901827584=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/4] Fix PPP server crash in using gsmdial
Date: Wed, 23 Feb 2011 16:29:22 +0100
Message-ID: <1298474966-1691-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8240362910901827584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patch will avoid a crash whenever you try to launch gsmdial and=
 test-server without being root.

Kind regards,
Guillaume

Guillaume Zajac (4):
  PPP:Add new function declarations for using resume callback
  PPP:Add new function definitions for using resume callback
  test-server:Remove root user test and add resume CB registration
  gsmdial:Remove root user test

 gatchat/gat.h         |    1 +
 gatchat/gathdlc.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 gatchat/gathdlc.h     |    7 +++++++
 gatchat/gatppp.c      |   14 +++++++++++++-
 gatchat/gatppp.h      |    2 ++
 gatchat/gsmdial.c     |   15 ++++++++++-----
 gatchat/test-server.c |   21 ++++++++++++++++-----
 7 files changed, 89 insertions(+), 11 deletions(-)


--===============8240362910901827584==--

