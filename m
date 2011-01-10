Content-Type: multipart/mixed; boundary="===============1038771544773089367=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 0/4] LaunchBrowser Proactive command Support
Date: Mon, 10 Jan 2011 11:43:39 +0200
Message-ID: <1294652623-17287-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1038771544773089367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

  This is a proposal for adding LaunchBrowser proactive command support to =
ofono:

 When a LaunchBrowser proactive command is received, oFono will inform the
agent to LaunchBrowser with the specified URL. If confirmed by user, agent
should launch the browser with the specified URL. This patch doesn't handle
the qualifier, Network Access Name, User Name, password and bearer informat=
ion
which can be part of the LaunchBrowser proactive command.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  network: __ofono_netreg_registration_status internal api
  stk: Handle Launch Browser proactive command
  test: Add support for launch browser command
  doc: Describe LaunchBrowser method

 doc/stk-api.txt    |    8 +++
 src/network.c      |    8 +++
 src/ofono.h        |    2 +
 src/stk.c          |  122 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c     |   67 ++++++++++++++++++++++++++++
 src/stkagent.h     |    5 ++
 test/test-stk-menu |   13 ++++++
 7 files changed, 225 insertions(+), 0 deletions(-)


--===============1038771544773089367==--

