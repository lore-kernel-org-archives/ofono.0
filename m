Content-Type: multipart/mixed; boundary="===============9154101027036674519=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 0/1] Patch Description
Date: Wed, 29 Dec 2010 00:14:14 +0800
Message-ID: <1293552855-15949-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9154101027036674519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is to cancel the pending sms via D-Bus. Till now, I'm still not =
sure what kind of sms should be cancelled. In theory, one message, or part =
of it, would be sent by oFono can be cancelled. For some examples: Any part=
 of a message that has never been sent can be cancelled; one message was se=
nt but failed, we can cancel before retry; One message is split into severa=
l pieces, we can cancel before all of them are sent. =

In current patch, I only cancel the sms that has never been sent. I wonder =
if it's enough or I should handle all the situations above. =


Another question here is about the existed code. There is a hashtable "mess=
ages" in struct ofono_sms. Can we store the state in the tx_queue_entry, an=
d remove the hashtable thoroughly to make the code more simple?

Yang Gu (1):
  sms: Cancel pending message

 include/history.h |    1 +
 src/sms.c         |  132 ++++++++++++++++++++++++++++++++++++++++++-------=
----
 2 files changed, 106 insertions(+), 27 deletions(-)


--===============9154101027036674519==--

