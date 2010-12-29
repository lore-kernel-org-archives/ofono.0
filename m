Content-Type: multipart/mixed; boundary="===============8267039507224961527=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 0/9] SMS history plugin.
Date: Wed, 29 Dec 2010 14:51:16 +0200
Message-ID: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8267039507224961527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the SMS history plugin set of patches. The plugin makes it
possible for an application/multiple applications to register for
incoming/outgoing SMS messages and receive them over D-Bus.
The SMS history itself is maintained by a separate application,
which registers to ofonod using this interface.

Regards,
Oleg

Oleg Zhurakivskyy (9):
  SMS history plugin.
  SMS history plugin.
  SMS history plugin documentation.
  SMS history plugin test script.
  oFono smsagent enhancements to permit more flexible parameter set to
    be dispatched.
  oFono smsagent enhancements to permit more flexible parameter set to
    be dispatched.
  Minor modifications due to sms_agent_dispatch_datagram()
    enhancements.
  Minor modifications due to sms_agent_dispatch_datagram()
    enhancements.
  D-Bus rules for SMS history plugin.

 Makefile.am                 |    3 +
 doc/messaging-agent-api.txt |   49 ++++++
 plugins/messaging-agent.c   |  403 +++++++++++++++++++++++++++++++++++++++=
++++
 plugins/push-notification.c |    2 +-
 plugins/smart-messaging.c   |    4 +-
 src/ofono.conf              |    1 +
 src/smsagent.c              |    5 +
 src/smsagent.h              |    4 +
 test/test-messaging-agent   |   67 +++++++
 9 files changed, 535 insertions(+), 3 deletions(-)
 create mode 100644 doc/messaging-agent-api.txt
 create mode 100644 plugins/messaging-agent.c
 create mode 100644 test/test-messaging-agent


--===============8267039507224961527==--

