Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E42919
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:03:04 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 7315E209A966
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id E4940BA002E; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 6/6] voicecall: Avoid potential double free
Date: Fri, 18 Feb 2022 11:53:00 +0300
Message-ID: <20220218085300.22585-7-d.grigorev@omp.ru>
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

There's no need to free the memory pointed by v, since it is already
freed in voicecall_dbus_register() or v is null.
---
 src/voicecall.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3da258d8..bb42402f 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2478,9 +2478,6 @@ void ofono_voicecall_notify(struct ofono_voicecall *vc,
 error:
 	if (newcall)
 		g_free(newcall);
-
-	if (v)
-		g_free(v);
 }
 
 void ofono_voicecall_mpty_hint(struct ofono_voicecall *vc, unsigned int ids)
-- 
2.17.1

