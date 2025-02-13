Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E428A2CE
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475311; cv=none; b=vCo9+TiuDECZb1ozlfuT8chU1kMYXu8zgd6GxAK+REUmSQryHMvrNhGbBnc/YskotrHTFONQmCpeCdFKxxEXcK4ggCDt4yzC1eHAyixqu416BgHkWHi6hfeW9VGvnY8wRABvnMHdV6rWwvD3EgOvbsNt3ZfGXE8tg/Oh60PRnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475311; c=relaxed/simple;
	bh=b5+JR9IxhVnU3dZDzJmyTeLWBGtJQQFaSY0mu3kClq8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hgP6f/FAxpItfBVXoOigPyslTeLyKFQXA734kAsN2VRIHRMaxncgaQZD+NVKe67yjshdnwKSLmvaFYx/ZQrPrS5UUnpGpMQNEkfZS4poyQpT0ORVLmMin0/O/RgHOZj1YW8bmUd3z6W7mkAV+1fEObOI/I5eWzNFlrJg7FF6lCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RE4mPcIj; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RE4mPcIj"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4D651164952
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 14:35:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 043EE124FB3
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 14:35:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH] data: Add 310 030 MCC/MNC (HNI) as AT&T.
Date: Thu, 13 Feb 2025 11:35:00 -0800
Message-ID: <bbfc59214e9740499221d0084dd7a223b1583a47.1739475286.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Et8/obs6oX6UTPZNaUun/NUnMKDWAJC8i8WQ+LCWyLA=; b=RE4mPcIj5Eatd7HkpoENvp9v8mamuufGzKqJyqZsjpXdQrGjRLW8vZW64etq/wUFhgq8QlyVX8iDECTCVoRcNzQbzfHO8imxoCDjTWuBV6DHsyKOHx9yggkHe2ypmM/OklUdSVZGZx5sgcceGI+2wFEw6jRVPpLm2/0ULSqhvak/f6ALmxaEiRfepXBLsVkPqVlWVpby4re6zLT7HljwzjefFSQ8YNRH87rEp1obUxKaPYrDVd4oj3BtPk/chMNRG0+FuPfS8HDCN485hTv0xFuUpx3IhbMukxa89QUO/mvpZ3y6eV0AA7bBlmt+1JYoyG5L0HS/e7y5qrv4+l6V+w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

The 310 030 MCC/MNC (HNI) for the GSM 850 MHz band was acquired by
AT&T Mobility from Centennial Wireless; however, at the time of this
commit and as of "ITU Operational Bulletin No. 1280", published
2023-11-15, AT&T has formally withdrawn this MNC and the status of
this MNC is non-operational.

Nonetheless, "AT&T Business" SIMs issued have SIM IMSIs prefixed with
310 030.

By including this MCC/MNC (HNI) in the provisioning database for AT&T,
it allows such SIMs to successfully auto-provision.
---
 data/provision.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/data/provision.json b/data/provision.json
index 50319cf33a51..f10b9b70ddfb 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14141,6 +14141,7 @@
     "name": "AT&T",
     "ids": [
       "310016",
+      "310030",
       "310038",
       "310070",
       "310080",
-- 
2.45.0

