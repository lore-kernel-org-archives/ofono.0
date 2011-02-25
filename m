Content-Type: multipart/mixed; boundary="===============3876173150158557300=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/4] Update the cell broadcast properties
Date: Fri, 25 Feb 2011 08:32:19 -0800
Message-ID: <1298651543-9752-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3876173150158557300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch removes the EmergencyType property as the required
functionality can be achieved with the EmergencyAlert property itself.
Also EmergencyBroadcast property has been renamed to WarningSystemBroadcast
to make it general for ETWS, CMAS and EU-Alert CBS message.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  cbs: remove EmergencyType property
  cbs: rename EmergencyBroadcast property
  doc: Update the cell broadcast properties
  test: update the cell broadcast property

 doc/cell-broadcast-api.txt |   17 ++++++-----------
 src/cbs.c                  |   44 +++++++++++-----------------------------=
----
 test/monitor-ofono         |    2 +-
 3 files changed, 18 insertions(+), 45 deletions(-)


--===============3876173150158557300==--

