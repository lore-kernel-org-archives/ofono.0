Content-Type: multipart/mixed; boundary="===============1752518843606018651=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 0/2] mmsd: fix problems when unregistering msg
Date: Thu, 22 Mar 2012 17:37:28 +0100
Message-ID: <1332434252-23551-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1752518843606018651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please find changes in mmsd in order to fix problems that occurred when
unregistering messages.

1) the messages table contains mms_message object and not uuid, now
every message is unregister with its correct path when the messages
table is destroyed. Furthermore, don't need to remove the message from
the table using g_hash_table_foreach_remove() since
mms_message_unregister() already removed it from the table.

2) use the msg_path (within the debug statement) before removing the
message from the table which free it

Ronald Tessier (2):
  service: fix object path when unregistering msg
  service: free the msg after tracing its path

 src/service.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

--
1.7.4.1


--===============1752518843606018651==--

