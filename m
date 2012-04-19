Content-Type: multipart/mixed; boundary="===============8537796478822761750=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/7] History agent interface
Date: Thu, 19 Apr 2012 11:20:49 +0300
Message-ID: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8537796478822761750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the patches for the history agent interface.

This is just an integration of Marcel's history implementation.

If anything is still missing, please comment.

Regards,
Oleg

Marcel Holtmann (2):
  doc: Add description for history agent interface
  modules: Add support for history agent interface

Oleg Zhurakivskyy (5):
  history-agent: Make compile
  history-agent: Update copyright
  plugins: Add history-agent
  ofono.conf: Punch hole for HistoryAgent
  test: Add test-history script

 Makefile.am               |    3 +
 doc/history-agent-api.txt |   83 ++++++
 plugins/history-agent.c   |  689 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.conf            |    1 +
 test/test-history         |   71 +++++
 5 files changed, 847 insertions(+), 0 deletions(-)
 create mode 100644 doc/history-agent-api.txt
 create mode 100644 plugins/history-agent.c
 create mode 100755 test/test-history

-- =

1.7.5.4


--===============8537796478822761750==--

