Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330E2F2D
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:02:33 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 9B03E22F1C6C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id EB8CABA0164; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 5/6] emulator: Avoid potential null dereference
Date: Fri, 18 Feb 2022 11:52:59 +0300
Message-ID: <20220218085300.22585-6-d.grigorev@omp.ru>
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
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1909.lancloud.ru (fd00:f066::79)

From: Denis Grigorev <d.grigorev@omp.ru>

---
 src/emulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index b3afb3da..9a0bf8cd 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1700,7 +1700,8 @@ int ofono_emulator_start_codec_negotiation(struct ofono_emulator *em,
 		 * Report we're done even if we don't have done any
 		 * negotiation as the other side may have to clean up.
 		 */
-		cb(0, data);
+		if (cb)
+			cb(0, data);
 
 		/*
 		 * If we didn't received any +BAC during the SLC setup the
-- 
2.17.1

