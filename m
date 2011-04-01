Content-Type: multipart/mixed; boundary="===============5392757380974159810=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 0/4] Support for emergency number list from network/modem
Date: Fri, 01 Apr 2011 07:29:32 -0700
Message-ID: <1301668176-19356-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5392757380974159810==
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

 drivers/ifxmodem/voicecall.c |   99 +++++++++++++++++++++++++++++
 include/voicecall.h          |    3 +
 src/voicecall.c              |  142 ++++++++++++++++++++++----------------=
----
 3 files changed, 177 insertions(+), 67 deletions(-)


--===============5392757380974159810==--

