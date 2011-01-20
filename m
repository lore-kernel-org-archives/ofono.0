Content-Type: multipart/mixed; boundary="===============7409035805621037959=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/2] LaunchBrowser Proactive command Support
Date: Thu, 20 Jan 2011 14:52:54 +0200
Message-ID: <1295527976-15816-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7409035805621037959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

  Following set of patches adds the basic support for LaunchBrowser
proactive command to ofono.

 When a LaunchBrowser proactive command is received, oFono will inform the
agent to LaunchBrowser with the specified URL. If confirmed by user, agent
should launch the browser with the specified URL. This patch doesn't handle
the qualifier, Network Access Name, User Name, password and bearer informat=
ion
which can be part of the LaunchBrowser proactive command.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  stkutil: add check for qualifier and browser id
  stk: Handle Launch Browser proactive command

 src/stk.c      |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/stkagent.h |    7 +++++
 src/stkutil.c  |    9 +++++-
 4 files changed, 162 insertions(+), 1 deletions(-)


--===============7409035805621037959==--

