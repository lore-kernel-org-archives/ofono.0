Content-Type: multipart/mixed; boundary="===============4965502615728791019=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 0/2] add ifx support for querying remaining pin entries
Date: Wed, 19 Jan 2011 16:03:00 +0200
Message-ID: <1295445782-31136-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4965502615728791019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds ifx support for querying remaining pin entries.
This patch also introduces a utility function for parsing the pin retry
count at command result.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  atutil: add pin retry count parser function
  atmodem: add ifx support for pin retries query

 drivers/atmodem/atutil.c |   66 ++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h |    3 ++
 drivers/atmodem/sim.c    |   79 ++++++++++++++----------------------------=
---
 3 files changed, 94 insertions(+), 54 deletions(-)


--===============4965502615728791019==--

