Content-Type: multipart/mixed; boundary="===============4373018807595988544=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 0/4] Add handling of XCOLP and refactor call status handling
Date: Mon, 07 Feb 2011 13:07:34 -0800
Message-ID: <1297112858-12002-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4373018807595988544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Incase of ifxmodem, COLP is not an intermediate status for ATD. Vendor
specific AT command XCOLP is used for the connected line presentation.
Since XCALLSTAT reports the voice call status information and call id,
creation of the call is moved inside xcallstat_notify function. This also
fixes the issue with gatchat usage.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  ifxmodem: fix issue with gatchat usage
  ifxmodem: add handling of XCOLP notification
  ifxmodem: remove colp handling done inside atd_cb
  ifxmodem: move call creation to xcallstat_notify

 drivers/ifxmodem/voicecall.c |  253 +++++++++++++++++++++++++-------------=
----
 1 files changed, 153 insertions(+), 100 deletions(-)


--===============4373018807595988544==--

