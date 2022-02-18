Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B62919
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:02:33 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru BD26722F19FC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id C2E8EBA015F; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 0/6] Fix issues found with static analyzer
Date: Fri, 18 Feb 2022 11:52:54 +0300
Message-ID: <20220218085300.22585-1-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.17.1
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

This patch series fixes several minor issues found with SVACE static
analyzer.

Denis Grigorev (6):
  phonebook: Fix potential buffer overflow
  stemodem: Fix buffer size allocated for rtnl_msg
  sms: Fix buffer size allocated for SMS PDU
  atmodem: Fix potential buffer overflow
  emulator: Avoid potential null dereference
  voicecall: Avoid potential double free

 drivers/atmodem/sim.c        | 2 +-
 drivers/atmodem/sms.c        | 2 +-
 drivers/stemodem/caif_rtnl.c | 5 +++--
 src/emulator.c               | 3 ++-
 src/phonebook.c              | 2 +-
 src/stkutil.c                | 2 +-
 src/voicecall.c              | 3 ---
 7 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.17.1

