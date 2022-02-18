Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D37320F
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:03:04 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 28F7020DB072
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id DE045BA00BA; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 4/6] atmodem: Fix potential buffer overflow
Date: Fri, 18 Feb 2022 11:52:58 +0300
Message-ID: <20220218085300.22585-5-d.grigorev@omp.ru>
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

The type of the session_id variable is int, so cmd could potentially
overflow if the session_id is large enough.
---
 drivers/atmodem/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 50eda698..e372f779 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1724,7 +1724,7 @@ static void at_close_channel(struct ofono_sim *sim, int session_id,
 {
 	struct sim_data *sd = ofono_sim_get_data(sim);
 	struct cb_data *cbd = cb_data_new(cb, data);
-	char cmd[15];
+	char cmd[32];
 
 	sprintf(cmd, "AT+CCHC=%d", session_id);
 
-- 
2.17.1

