Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79542661B1
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480131; cv=none; b=tHe0bBmo1huhsBZaLwZXFnnmLv40fLSysGjkvxE/DTisNJP65yfUuH4FrFvGxIJWzSGkP5pfFto2D2P1YBAJzpxHTGI2QRdkwbTN8H/VEJO2HbrKx46ARj5IIf34JQJD5zD9Shnw85AqDnQJ4hzhdHaL4dbQlj0eQ+0cDcxpR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480131; c=relaxed/simple;
	bh=0yOBFFXGQYHejCbF0FCClcrLDAwrrJ6Hs8TsFJuj0K4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=joVkYq593JHJsqnflV6Redc54bz0qyMn7dASCwgrfk4MEI7zZbwsGf1pdc2dPR13UMOMzSkEZAVdaimBM+6LJ0koKGAztGdF325fJjUw6d6ccIWjaNEp8ycurykDgJNNqYA08kQ6W3IntY849oNBSpyxQa3Tm9jQEV3F5NpYLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=VcClLTqz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="VcClLTqz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8BD1716499F
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 15:55:27 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AF73E124EE1
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 15:55:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH] data: AT&T 'data device' public APN.
Date: Thu, 13 Feb 2025 12:55:24 -0800
Message-ID: <e140e827103cd893938e0c113bc38b2c1f4f28b0.1739480113.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=p7cjOyESboZfo6P5Ma1AnKK1z9dLlQIgjhzJE/nFirc=; b=VcClLTqzHH/S6f8eelNjtL2uq7Lzq3Qh8vWqWtTlL1E+sG9bMlXrPuvG/YEoKS1kLA9PJJtMlZRqfKRUcN+Xxro/AbCtqd2M6kisvztVEnNmyw44StPeRExA33syqoLyN3H8dfleBLSHGA9sFPJ5O0y2EvgS2vb8pVsOF2NHk5S2FzzqwhAhKYzf+p7CSwDR2wz+8ZZMzSQxoWvXyxdxNCxEutWv1TLkV/O7+3RAANGpV5JQw7Q7kqk6lz5IxKkGLLJirdjL7rAnR+OWtdGnJl0VvdOCFZzojIfcyO9GojjLBwQxCcAUXXY8rKYZpgy/LCFHTqXbGNKW8Iu1FkvReg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Per AT&T documentation at
<https://www.att.com/support/article/wireless/KM1062162/>, AT&T
currently has three "public" APNs:

    1. 'ENHANCEDPHONE'
       - For 5G smart phone devices.

    2. 'NXTGENPHONE'
       - For 4G / LTE smart phone devices.

    3. '[Bb]roadband'
       - For "data devices" such as Wi-Fi hotspots or IoT/M2M devices.

The first two are already in the provisioning database; this adds the
third under the tag `kore-public` since the AT&T mobile virtual
network operator (MVNO) KORE Wireless recommends this AT&T public APN
for users of its issued "AT&T Business" SIMs and since there is
already a generic 'm2m'-tagged entry with the same types.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 50319cf33a51..0cb6b8c3dffc 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14183,6 +14183,15 @@
         "mmsproxy": "proxy.mobile.att.net:80",
         "tags": "5g"
       },
+      {
+        "name": "AT&T MVNO IoT/M2M (Public)",
+        "apn": "broadband",
+        "type": [
+          "internet",
+          "ia"
+        ],
+        "tags": "kore-public"
+      },
       {
         "name": "AT&T M2M",
         "apn": "m2m005246.attz",
-- 
2.45.0

