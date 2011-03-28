Content-Type: multipart/mixed; boundary="===============4101623594842965266=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/4] Support for emergency number list from network/modem
Date: Mon, 28 Mar 2011 06:58:05 -0700
Message-ID: <1301320689-25201-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4101623594842965266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patch adds the emergency number list update from
the network/modem. Upon emergency number list update from modem, ofono
core will be updated which will result in dbus property change signal
as well. With this patch, even if the emergency number list maintained
in ofono matches with the received emergency number list from modem,
dbus property change will be signalled. If this should be avoided,
then it needs to be decided whether the check should be added in core
or for each modem.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  include: Add ofono_voicecall_en_list_notify api
  voicecall: refactor emergency number list handling
  voicecall: network emergency number list support
  ifxmodem: emergency number list support

 drivers/ifxmodem/voicecall.c |   98 ++++++++++++++++++++++++++++++++++++++=
++++
 include/voicecall.h          |    3 +
 src/voicecall.c              |   45 ++++++++++++++++---
 3 files changed, 138 insertions(+), 8 deletions(-)


--===============4101623594842965266==--

