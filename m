Content-Type: multipart/mixed; boundary="===============4915062389470883584=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 0/1] Refactor call status handling
Date: Tue, 08 Feb 2011 09:04:13 -0800
Message-ID: <1297184654-23800-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4915062389470883584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Since XCALLSTAT reports the voice call status information and call id,
creation of the call is moved inside xcallstat_notify function.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  ifxmodem: move call creation to xcallstat_notify

 drivers/ifxmodem/voicecall.c |  172 ++++++++++++++++++++++++--------------=
----
 1 files changed, 98 insertions(+), 74 deletions(-)


--===============4915062389470883584==--

