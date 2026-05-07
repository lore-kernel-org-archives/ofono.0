Received: from b224-2.smtp-out.eu-central-1.amazonses.com (b224-2.smtp-out.eu-central-1.amazonses.com [69.169.224.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5C3D1CB2
	for <ofono@lists.linux.dev>; Thu,  7 May 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194974; cv=none; b=vEHZcnUo8BUMzBNC5IsJwXHunwMQB26ubNfk+QZ0/O6BoLlO2gvG/VwB605m2GDG9Qs6YXtgUVciQ2zfQ1Skb/IUxuyj5+g/v+jyVxNqxJlQERgtK1B2ztwD/jS/26uhzp2X8oxWe2dVln3fgH+dnapW7UFRF3TrSrwFyJxDzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194974; c=relaxed/simple;
	bh=h4UT54Plf64B0fElO8MM/RjKQyJlHXHrezSxAIYN/AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbPQYJwANZrBBUpHzn5EkWsLyD1OU4M7aYxzocT366i1ea3gyabz9SnPoDmvkQlUCkh53s7hlS5vKhSntDydEU6PMv0fxI5bf2EeBiXnzHiVk8Vyd/FaGI2dX9AT+Vq9nQozlXqGQBtk374jo++wMyWLLjf33PMdhvHfMBni/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ubports.com; spf=pass smtp.mailfrom=eu-central-1.amazonses.com; dkim=pass (2048-bit key) header.d=ubports.com header.i=@ubports.com header.b=iHEbe2Js; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=N1Ev6Mb8; dkim=fail (2048-bit key) header.d=ubports.com header.i=@ubports.com header.b=bjtGdXBj reason="signature verification failed"; arc=none smtp.client-ip=69.169.224.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ubports.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-central-1.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubports.com header.i=@ubports.com header.b="iHEbe2Js";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="N1Ev6Mb8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ubports.com header.i=@ubports.com header.b="bjtGdXBj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sh5da3j2jknfud6neishr7wiyevoggdh; d=ubports.com; t=1778194971;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=h4UT54Plf64B0fElO8MM/RjKQyJlHXHrezSxAIYN/AE=;
	b=iHEbe2JsCrlLl5CJPDCB/j5l4RWj6QitRuuCLfNqKr1L16duREQlt6ophT5hceLS
	VhRxVi+UZZRLJgY7ULsmhMQp0Tj6lfs116QGpUl5KYRO5koPdXoO3x8/K5MuULOXmqx
	nTR7lwn95bqvaiZxbEt+wL9VndHlAB81ag/HmD1kIbJwiFYKdaONfqF6Sw/A0dyKSBZ
	twh9QHbmKDYkc5KgJFzDaPcyDNCX9+m0EcjS/0ik+JIJg4a8KYxkuHMPuJrtdOT6Swd
	1QE9+kGukHK5liaIXjhaU38yUbKgD6H2D4ywiJse2Ow3IIKNBTwryIJYnOFJ3pLSctn
	t9y5pKrCZQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1778194971;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=h4UT54Plf64B0fElO8MM/RjKQyJlHXHrezSxAIYN/AE=;
	b=N1Ev6Mb8mKwreb5XyVLXdOSHU9TaaMYG3C2emfc1fPiuu1yB3BnkWbqJPILrmG7L
	yOc48kUdC7IUtdyjGseP5hJ+3DFoYUB6ZZdNR2E2AgatFsw4z0ZyA5bdU4xkJCYPFJC
	kdKOfJrM77eL41Kp5y/wLWysoVNkP+AxY3qHMcuk=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
	t=1778194970; bh=h4UT54Plf64B0fElO8MM/RjKQyJlHXHrezSxAIYN/AE=;
	h=From:To:Cc:Subject:Date:From;
	b=bjtGdXBj5WVuMemgZ3IRjn9aWh39zcaDTlQBASUQhFwSwhHindH3u30+TIf7sf5jV
	 U48i9kGtKCztD+3Ai8GUNKhMCLlzLmbWvrKcCTZJSiZmipkjNnrWMr4P9B0cupz7oa
	 k9RcXmlu0pBaITOyvG6bfnBzlcXO8aOqlCHJ3fGQh7mEH3WcArwsGeXlINKPo5jkIY
	 fo5a/RWotsQPzfBIycwyADj+i2gdMD0qxj6hcJpqLMhh/DszSHI1qIS8naJMIKcAYR
	 MQRCW+fZmeqHlzwKSLceLxOJgWZtuS0pzXk3nvrguWP7cqYEuNPw+n2Vt3LYWFdM/W
	 1X5TTsU/sp/MA==
From: Marius Gripsgard <marius@ubports.com>
To: ofono@lists.linux.dev
Cc: Marius Gripsgard <marius@ubports.com>
Subject: [PATCH] sim: fix use-after-free in open_channel_cb watcher loop
Date: Thu, 7 May 2026 23:02:50 +0000
Message-ID: <0107019e04adf95a-a0e08395-5cda-4937-b142-329901156dcd-000000@eu-central-1.amazonses.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2026.05.07-69.169.224.2

The notify callback (get_session_cb -> sim_fs_end_current) calls
__ofono_sim_remove_session_watch, which removes and frees the current
GSList node from session->watches->items. iter = g_slist_next(iter)
then reads ->next from the freed node, on newer glibc the freed memory
holds a random tcache key rather than accessible heap data, turning the
next iter->data dereference into a SIGSEGV.

Advance iter before calling notify so the next-pointer is captured
before the current node can be freed.
---
 src/sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index dedb7d8d..6a733169 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3659,9 +3659,9 @@ end:
 		struct ofono_watchlist_item *item = iter->data;
 		ofono_sim_session_event_cb_t notify = item->notify;
 
-		notify(active, session->session_id, item->notify_data);
-
 		iter = g_slist_next(iter);
+
+		notify(active, session->session_id, item->notify_data);
 	}
 }
 
-- 
2.43.0

