Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6F14BF97
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160365; cv=none; b=kwbvKfeFdr4zLNsn7jqh1ZMRwpVRRMupPh8aQ7fDIIIhYQLqNgMofpjdy3mAI67ut9kQscHLotf1kkpL+7kfZHEJaNF/18ND9rnZzuX0hBYLVslauqx1Np6VqO4xadktp8GKsmZh9czLmv8q/26yOIrEogQ18B56A/78Uk8M44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160365; c=relaxed/simple;
	bh=IXf7Td7dakoDdaJxiHvJavMN42z6RyPBX+lN1+zJAfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saeHR5ig1R/8dgvQMSJFWdOqLMkckvfoB361xUjMwaBwnlb4FmNfNigqsfSE12yqhoeK/g2X7r0BYgYkbly9DsSwZrK8m5VeIkalCF8cNeC8oNu1FW+VrQquVmP6qAZet1kCe1JHAniNh6W25LTKDQuOhlMRI3l8FxAxDMYJX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqanDkCb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqanDkCb"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-220ee7342ddso2603477fac.3
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160363; x=1712765163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWe+PUC/DUb/AqF6ebHjXINhmuIh08yUnFE+XOqSRwc=;
        b=UqanDkCbX693TNalreYoeQUUMU0jfuuLW/hW6W+fK85Lt/8LHU6fbiyXnAZzEbPgZO
         b/A7r+2ArOs1mq/oKUDgxli7vpDbhXhRc1cwxBwDZGrYl54bXDKUJhwwoOH/FEMRT9QW
         YllQ9cjvkxTteaQRlOy0STzboRJPKPGbae20uMY6g7qzUeL5pgAS6C+eRQSFPyXuS96I
         ODZHzWCgCFO4k2nr6vVvrlpuWV9hGd0q4kB78bvHNkizhCy5NxUuwQEWbZn6yGW0lI9X
         XcTuX4Braw22sOAF9yPmIJxzT60t4AHB5rO/YAx//4XluO9FCdge0/k0fySRVExV7g96
         7RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160363; x=1712765163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWe+PUC/DUb/AqF6ebHjXINhmuIh08yUnFE+XOqSRwc=;
        b=RxAf1SoFRv0wEybqIDs2vaSeNYChJSCN/BsO0B6Xxah4JNMNo0G7AAoWu0ZrWZaR5i
         H5Vu1MRDZxCZMeuNSqC+/2/tcRJOu4Dfe5gqOIevXg/9LRzEBG3kn309gdy5kN+eX+KS
         EXxPupVPCiTZIPSSct2jXFlC5BPNNLuIbxGMwsoJvVrJD8gMm44GG7N0vC/pYrD6Kbxa
         jAl7k+9CtpwTQz3o7HDw7wNQuUutvoJQfuLabxOqoTIyf/eldY0XyoYid+WYjhbhXApf
         dh+502LW9e7/aArJ/YZzw+CmLsFbkPaRrJh7zSqkH1UemB82VM1REABd3r6aIYJ43JjI
         n96w==
X-Gm-Message-State: AOJu0YzJqFRUjwnGXqUA0BNz1KlfGQowPI0MhAPqDOXGHA/hMhqqbKTa
	TBGl1CsxXRvoyV4ci86vCWPLsTdocAwTU5nlcvLP0mY8ULvlHIrHjEhc/UkM
X-Google-Smtp-Source: AGHT+IG+uqezKk2NocjlyYTfZ32EmeDV6/fdq2Trl4r8XHKdrDHb98AFW1VkusOzy6hD2imNdVA4QA==
X-Received: by 2002:a05:6870:63a7:b0:22e:a451:57d1 with SMTP id t39-20020a05687063a700b0022ea45157d1mr1044806oap.52.1712160362711;
        Wed, 03 Apr 2024 09:06:02 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/14] data: Remove outdated T-mobile settings
Date: Wed,  3 Apr 2024 11:05:28 -0500
Message-ID: <20240403160557.2828145-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 data/provision.json | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index e55ecc6f8d67..80abd78e6507 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14229,41 +14229,6 @@
           "internet"
         ]
       },
-      {
-        "name": "Internet/WebConnect",
-        "apn": "epc.tmobile.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Web2Go/t-zones",
-        "apn": "wap.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Internet (old)",
-        "apn": "internet2.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Internet with VPN (old)",
-        "apn": "internet3.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Broadband",
-        "apn": "mobilenet",
-        "type": [
-          "internet"
-        ]
-      },
       {
         "name": "IoT",
         "apn": "iot.t-mobile.com",
-- 
2.43.0

