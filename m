Content-Type: multipart/mixed; boundary="===============4771550191408240340=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 0/3] mmsd: bug fix
Date: Fri, 20 Apr 2012 18:39:03 +0200
Message-ID: <1334939946-8835-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4771550191408240340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set concerns mmsd for ofono mailing list.

S=C3=A9bastien Bianti (3):
  mmsutil: add mms_message_status_get_string API
  service: use proper status value string
  service: fix for message_delete bug

 src/mmsutil.c |   25 +++++++++++++++++++++++++
 src/mmsutil.h |    1 +
 src/service.c |    9 +++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

-- =

1.7.4.4


--===============4771550191408240340==--

