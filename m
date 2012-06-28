Content-Type: multipart/mixed; boundary="===============0039817271195452394=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/4] Add bus name to signal watches
Date: Thu, 28 Jun 2012 10:59:17 -0300
Message-ID: <1340891961-9809-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0039817271195452394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch is just one that was still pending locally. The other ones fix =
the
calls to g_dbus_add_signal_watch() to actually watch only the desired bus. =
It
depends on previous patch for gdbus to be applied first, otherwise libdbus =
may
call abort() when we exit.

Lucas De Marchi (4):
  README: add information about mailing list and site
  bluetooth: watch for signals only on BLUEZ_SERVICE
  stemgr: watch for signals only on MGR_SERVICE
  tools: watch for signals only on OFONO_SERVICE

 README               |  9 +++++++++
 plugins/bluetooth.c  | 13 ++++++++-----
 plugins/stemgr.c     |  4 ++--
 tools/auto-enable.c  | 20 ++++++++++----------
 tools/huawei-audio.c | 17 +++++++++--------
 5 files changed, 38 insertions(+), 25 deletions(-)

-- =

1.7.11.1


--===============0039817271195452394==--

