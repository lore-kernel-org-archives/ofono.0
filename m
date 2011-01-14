Content-Type: multipart/mixed; boundary="===============8284984183755243991=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/3] LaunchBrowser Proactive command Support
Date: Fri, 14 Jan 2011 11:38:52 +0200
Message-ID: <1294997935-21814-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8284984183755243991==
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

Jeevaka Badrappan (3):
  stk: Handle Launch Browser proactive command
  test: Add support for launch browser command
  doc: Describe ConfirmLaunchBrowser method

 doc/stk-api.txt    |    8 +++++
 src/stk.c          |   90 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c     |   68 +++++++++++++++++++++++++++++++++++++++
 src/stkagent.h     |    7 ++++
 test/test-stk-menu |   13 +++++++
 5 files changed, 186 insertions(+), 0 deletions(-)


--===============8284984183755243991==--

