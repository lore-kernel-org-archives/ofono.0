Content-Type: multipart/mixed; boundary="===============5107820368409948760=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Add handling of XCOLP and refactor call status handling
Date: Mon, 07 Feb 2011 16:05:34 +0200
Message-ID: <1297087536-3100-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5107820368409948760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Incase of ifxmodem, COLP is not an intermediate status for ATD. Vendor
specific AT command XCOLP is used for the connected line presentation.
Since XCALLSTAT reports the voice call status information, there is no need=
 to
listen for CRING notification. Following patch refactors the handling of =

call status information and also removes the CRING handling.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  ifxmodem: add handling of XCOLP notification
  ifxmodem: refactor handling of call status

 drivers/ifxmodem/voicecall.c |  240 +++++++++++++++++++-------------------=
----
 1 files changed, 109 insertions(+), 131 deletions(-)


--===============5107820368409948760==--

