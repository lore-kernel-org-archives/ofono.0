Content-Type: multipart/mixed; boundary="===============5385918414903826117=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/3] Accept WAP push notifications with any origin port
Date: Mon, 07 Sep 2015 11:58:14 +0200
Message-ID: <1441619897-22899-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5385918414903826117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Accept WAP push notifications regardless of the origin port, as some
operators seem to use random ports. The destination port is enough to
route properly the message.

Alfonso Sanchez-Beato (3):
  push-notification: Accept push from any origin
  smsutil: Do not check the origin port
  sms: Add trace when datagram is not delivered

 plugins/push-notification.c | 25 +++++++------------------
 src/sms.c                   |  7 +++++++
 src/smsutil.c               |  3 ---
 3 files changed, 14 insertions(+), 21 deletions(-)

-- =

2.1.4


--===============5385918414903826117==--

