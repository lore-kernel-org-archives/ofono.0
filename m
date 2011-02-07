Content-Type: multipart/mixed; boundary="===============1496738965554231399=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/2] Add handling of XCOLP and refactor call status handling
Date: Mon, 07 Feb 2011 20:21:18 +0200
Message-ID: <1297102880-32714-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1496738965554231399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Incase of ifxmodem, COLP is not an intermediate status for ATD. Vendor spe=
cific
AT command XCOLP is used for the connected line presentation. Since XCALLST=
AT
reports the voice call status information and call id, creation of the call=
 is
moved inside xcallstat_notify function.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  ifxmodem: add handling of XCOLP notification
  ifxmodem: refactor handling of call status

 drivers/ifxmodem/voicecall.c |  248 +++++++++++++++++++++++++-------------=
----
 1 files changed, 146 insertions(+), 102 deletions(-)


--===============1496738965554231399==--

