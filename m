Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963C2919
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 09:00:00 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 052B520EBD7B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id D78FBBA015D; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 1/6] phonebook: Fix potential buffer overflow
Date: Fri, 18 Feb 2022 11:52:55 +0300
Message-ID: <20220218085300.22585-2-d.grigorev@omp.ru>
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

This fixes possible access to an address outside of dest if src is
greater than or equal to 128 bytes.
---
 src/phonebook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/phonebook.c b/src/phonebook.c
index 65ef0089..958773c7 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -112,7 +112,7 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 {
 	int i, j;
 
-	for (i = 0, j = 0; i < len && j < len_max; i++, j++) {
+	for (i = 0, j = 0; i < len && j < len_max - 1; i++, j++) {
 		switch (src[i]) {
 		case '\n':
 			dest[j++] = '\\';
-- 
2.17.1

