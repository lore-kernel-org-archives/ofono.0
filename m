Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECC2F2D
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:03:04 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru D487D20D604F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id D1261BA0163; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 2/6] stemodem: Fix buffer size allocated for rtnl_msg
Date: Fri, 18 Feb 2022 11:52:56 +0300
Message-ID: <20220218085300.22585-3-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218085300.22585-1-d.grigorev@omp.ru>
References: <20220218085300.22585-1-d.grigorev@omp.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1909.lancloud.ru (fd00:f066::79)

From: Denis Grigorev <d.grigorev@omp.ru>

---
 drivers/stemodem/caif_rtnl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/stemodem/caif_rtnl.c b/drivers/stemodem/caif_rtnl.c
index 584c5a4a..6b25f25f 100644
--- a/drivers/stemodem/caif_rtnl.c
+++ b/drivers/stemodem/caif_rtnl.c
@@ -41,12 +41,13 @@
 #define NLMSG_TAIL(nmsg) \
 	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
 
-#define RTNL_MSG_SIZE 1024
+#define RTNL_DATA_SIZE 1024
+#define RTNL_MSG_SIZE sizeof(struct rtnl_msg)
 
 struct rtnl_msg {
 	struct nlmsghdr n;
 	struct ifinfomsg i;
-	char data[RTNL_MSG_SIZE];
+	char data[RTNL_DATA_SIZE];
 };
 
 struct iplink_req {
-- 
2.17.1

