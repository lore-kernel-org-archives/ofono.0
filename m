Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236F39AD6
	for <ofono@lists.linux.dev>; Tue, 11 Feb 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234164; cv=none; b=VGZoiqweBCaFOJ7cUYvKYcDkyXrHg7ad/g0ijq2AQi6sCU8A/B3ogN7j2FD/Ra+0NmB7TUIdkOYti7ZF6Cneu0n0O/Ft10eFLWbT8RnllakoMqSZm6XMIqVTA3EY/pJ3K3DYvIaLAg0V34SDrdiBGNhzhrzqkkI0jwS3ANuVMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234164; c=relaxed/simple;
	bh=GwuLmh+tZj+1JXkhT5M9corltkKPLRZZitUEVCG5gFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHgOeh7W8cAnEhACvTqB0d4U8Mk7QM6/IZ8nXF2xecDVaaHP4BIvYFFuUXSErs9v+/tNltOm2yNPjQstmfAfzwFSmdk4bBTqPshXD/764ab3HrNQ8iPh0YqBfITI9fzwue+lO6kSDmCK5YQ0Tke4i9xbCvjUHLcw7gthSBirsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=owhTAnBx; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="owhTAnBx"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6F315164A7B
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:36:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2068E124FE6
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:36:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 1/2] data: Add initial attach type to Verizon 'vzwinternet' context.
Date: Mon, 10 Feb 2025 16:35:57 -0800
Message-ID: <7848513cba60c3258cda3d315b7a770db46dffb6.1739233526.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739233526.git.gerickson@nuovations.com>
References: <cover.1739233526.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=LfYbWy9/mZufEPYJUrJdKwljNwl/lyJXN4VpSy13n8U=; b=owhTAnBxbE3IBHZ+U+bz1W3JSTouTHBRM3sBNnEqs0e+osSKWiieQeGDVFP1fZhcj/5M9r0JuxeBdqDXHeU+QVmYSau5ztsEMX8fTURRb628nYE65SV+FPbASaFI2fixXnU5BMksiuC2uwS6mj6y9ldiHy3tiQ29ewKuAb4FeMHnsSrnwoNU/lwJuEvnrG5aLvkoo3Ra2WC1zSoV78PmJPHLDWAMfh16GnvE0oQBEDLKIc+3+Da6F8wvlFqaNDlxwt6pOpJ/RZVw/yl/Oz7evs2DM871qt/Gt2iUHjirVJrfwy7Qon9I1+d3w+afhAH3ChKbcJRL65Qm6pyaJwEM3w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Verizon has a number of different Cellular access point names (APNs)
and contexts, depending on the application, per their documentation
here:

    https://www.verizon.com/support/knowledge-base-72601/

Some of those contexts must be used for initial attach (IA). For Voice
over LTE (VoLTE) applications, the 'vzwims' APN is such an IA context
and is currently marked as such.

However, for Internet of Things (IoT) or machine-to-machine (M2M)
applications, the 'vzwinternet' APN is also such an IA context but is
not presently marked as such. This change adds the 'ia' type to this
APN context.
---
 data/provision.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/data/provision.json b/data/provision.json
index 50319cf33a51..9d65ac08b394 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14291,7 +14291,8 @@
         "name": "4G LTE Contract",
         "apn": "vzwinternet",
         "type": [
-          "internet"
+          "internet",
+          "ia"
         ]
       },
       {
-- 
2.45.0

