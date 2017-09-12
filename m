Content-Type: multipart/mixed; boundary="===============3117761599879219781=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] netmonagent: fix unnecessary function declaration
Date: Tue, 12 Sep 2017 14:31:19 +0530
Message-ID: <1505206879-4279-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3117761599879219781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netmonagent.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/netmonagent.h b/src/netmonagent.h
index f64a503..5178901 100644
--- a/src/netmonagent.h
+++ b/src/netmonagent.h
@@ -19,5 +19,3 @@ DBusMessage *netmon_agent_new_method_call(struct netmon_a=
gent *netmon,
 =

 void netmon_agent_send_no_reply(struct netmon_agent *agent,
 				DBusMessage *message);
-
-void netmon_agent_test(struct netmon_agent *agent);
-- =

1.9.1


--===============3117761599879219781==--

