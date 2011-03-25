Content-Type: multipart/mixed; boundary="===============4081181620363135468=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Add support for emergency number list from modem
Date: Fri, 25 Mar 2011 07:08:01 -0700
Message-ID: <1301062083-20416-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4081181620363135468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patch adds the emergency number list update from
the modem. Upon emergency number list update from modem, ofono
core will be updated which will result in dbus property change signal
as well. With this patch, even if the emergency number list maintained
in ofono matches with the received emergency number list from modem,
dbus property change will be signalled. If this should be avoided,
then it needs to be decided whether the check should be added in core
or for each modem.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  voicecall: add ofono_voicecall_en_list_notify api
  ifxmodem: add support for emergency number list

 drivers/ifxmodem/voicecall.c |   98 ++++++++++++++++++++++++++++++++++++++=
++++
 include/voicecall.h          |    3 +
 src/voicecall.c              |   12 +++++
 3 files changed, 113 insertions(+), 0 deletions(-)


--===============4081181620363135468==--

