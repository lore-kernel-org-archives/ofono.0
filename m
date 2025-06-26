Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626127700A
	for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925803; cv=none; b=pvB4aMEJJ3XfUp6CHZVDuj8qMWNdiqqMDrmCT1IH+ZF9V5e+0hykc0Ij+ZvIKxvfk73vxSHO2nYlmikl1pMDK3M2AH0Ffwb61RVD7oF+/6GKCgNlw/U4Yh3anz5546KQB2dW6jwu7eJeTrJhqErGdO6NOB1n7g4hbbhP5Ra9IPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925803; c=relaxed/simple;
	bh=iY7yzEf26Jmeq4O5az6WI0l6RnCHDmnGvmYpGbysxPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToQqB1Vl0hlz6mrS4XQfp5WXbwE8yro1ZV9YPKwpvitO2IDxKHJzvgtibN8cqlAFF2Vd4uWzKSGqErAhJc1/oko691jXyvG2qbXlQ1x5FxSnEUj1bqfFpqlr4H7CvPeg4QPIjoYodYhG76KQvgkc+APl4lJkBm3+wzm7GbUXfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=h/kavXkt; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="h/kavXkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750925790; x=1751184990;
	bh=u5OJc5IC2zo0ZAadIRp1ejFgCac/OLl8PR/fmR5gvFw=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=h/kavXkt1Ide/VeNdeAOuh1VtbV3syGgXF8Lfb7CHcr9F8hMEVT/fPOu8/VWCu6kF
	 0roCG1AbOc7FJ5uwn+jG9/yKUq2KnNX2l6GEhPNvakL/B8uYP4KOCzWjJFw7EoQdJi
	 0qa3PSkbsnTwqtmaVw0lwegu9Trh1zLX0vzUG7tMf3Vqe0KjfY+6oVc3Cwr9cVPyuW
	 PWrssgvVz1L7i1+kbFPBDeVh5o2zk9YeG3sKGK+1S96b/PtEPCTByTIFJcT5xGpGjv
	 tavMRmhtNVMfpmE0SCFmcniI0dSdVVad/ZamGAcUhyxg/ux5Gv83CEtoG0An2BmWMn
	 L5tJg/MOYSiaA==
X-Pm-Submission-Id: 4bSWjm4jMJz1DDWr
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] qmi: avoid free of non heap object
Date: Thu, 26 Jun 2025 10:16:24 +0200
Message-ID: <20250626081625.1362728-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qmux_create_client_timeout() free's a non heap object, avoid calling
__request_free() and inline free_request() instead.

In function 'l_free',
    inlined from '__request_free' at drivers/qmimodem/qmi.c:293:3,
    inlined from 'qmux_create_client_timeout' at drivers/qmimodem/qmi.c:1427:2:
ell/util.c:124:9: warning: 'free' called on pointer 'user_data_6(D)' with nonzero offset 28 [-Wfree-nonheap-object]
  124 |         free(ptr);
      |         ^
---
 drivers/qmimodem/qmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5d2553c5..4468761a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1424,7 +1424,9 @@ static void qmux_create_client_timeout(struct l_timeout *timeout,
 
 	/* remove request from queues */
 	find_control_request(qmux, req->super.tid);
-	__request_free(&req->super);
+
+	if (req->super.free_request)
+		req->super.free_request(&req->super);
 }
 
 static void qmux_create_client_callback(struct qmi_request *r,
-- 
2.49.0

