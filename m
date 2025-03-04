Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EC25F962
	for <ofono@lists.linux.dev>; Tue,  4 Mar 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101695; cv=none; b=RTbB36SMWVW0bZWda3YQliKiaNdUWo94+GgdIVqX5dkSlneIUFdkKh59bHstNVsBmFD9gxW1Xojst5gpFZRqnnJOEluxbqx1yjT5J0+UzD/m8VQh26ugNrrxU67/BmZJ/lzgucuCYERIFlgA3/bnOYn1i1ku73Ro/7MdrdzzEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101695; c=relaxed/simple;
	bh=slbGoPpo1o0Q6xUgR7tIiSGPDt8YyyzjhPjyTe1nUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La5+OjsNmt9cPmVKJHQssprVoYLkOyGUGSuSwtCiHWtgvEmL361/TGoZ+aLBtxCkUB2u7/VqHFrmU+U8PADRj4atcbnaikOg8cbJzU7oWmHYgp9G2X5I/RakfnvhXsBFX6/Kltc24A5gaKK5tRG0N/F77GuxK7m0fdD1b7F632Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6cdHBMB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6cdHBMB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e538388dd1so3374659a12.1
        for <ofono@lists.linux.dev>; Tue, 04 Mar 2025 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741101692; x=1741706492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0joqvpje0nEcUzAgsyFy95O9M+xUPHsAJE15ooxvPM=;
        b=P6cdHBMBWexb+HJbfjtLXXN4Tx4cMhrLyWkuCeDncG7GAFJDVqpvAmM+v+3bFi96XL
         5MLKUoDKKwtclb+VIaDtFhxyAsB5n7jmehHFpM9MgCGK7bdCrAFlCrhRTnooZkT3a8Nr
         qeaeCh2P3hUfmeE/aTOTSnjWgYtItRkbhQDNI9FPPcr622eGR0ciJHf/xzRGaQDIKx6w
         fuggLy1ntfob1YaZ5rXAshcOEJmRSgZamG7KTXlLRjGiqcupyGl3Do7UH6hqyrK7b7j1
         7M3T8uwWJUbPKy+QQhOjZ26Kw9yk93Y6Jq3IP6WRVOua9y+eXzlve2R18/uO3a4Rj8ej
         jrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101692; x=1741706492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0joqvpje0nEcUzAgsyFy95O9M+xUPHsAJE15ooxvPM=;
        b=JMGAmuF4vtwwpIlAU3Me3lxAP/PF0qQdxtbCTozHBVbjLjEQLOvKwBpONBLHzziIgC
         xC37P246yY2M0zU1x09ZuhPIyq6ShKPl2eYK+DiJI0jpCeGu+RtoRXgveV1Fk6uyh+AU
         G+q8Gu1nNCnJ1XWM+MYSKCCbTiwy345nAC2JDHFRMmwjtD3tC1t9kP3zZNR7p8rHc9s8
         6JEvl5yI2YOX6BV57xSV/eJfN7r6o4uXILAv/ZCkXhbl7hANMHeRE9AYHI1do9XVn5F+
         BxkRgQJII4CiMzBAg+kOCLDbOIE5x0NMklayHZabYxKTwnoDmXqmvX6FELDBWj0GKGEI
         9Tow==
X-Gm-Message-State: AOJu0YwMAcq3LGb9WZMq6Zyo2NH+eWzUbX68cu0z/13oLEH7AwPtof60
	EKmT7v8i/X256/TZWfmFHMT24SiXCcxGE3DsJvDVo6J5ppjyfsfWvnfaJ1B9
X-Gm-Gg: ASbGncu8Gz/Ak0MN9SKCOBZjL5ZySmdQjlgknz95+o4hm64iZWLrBq9B9h9Z+sj4zwe
	dVYfAe4OjePDVvXGCuOkU6Vg9K2/q3VnlJTJ7v1sfizIqdqDAq9Gkdaq5DbgPVQIGxhLMvIfRd0
	jEiLJPr7hdTuJ5pCd8vTBhjV0GnF2lAnzASwaMlJk9434qbjXhMk6WVfbjJTymEDLcYC4yS82hJ
	iIjwzu3QGDjAHSvFq7KPAyorD4gwRIPT+oAr9vwcK8xFjfBIQF1lf3XRueiH3y4oXhtX5MiIvaL
	/4jzDmVxvJ/L9alWS7xM5k/PratoYzNoZSHltZltoREL
X-Google-Smtp-Source: AGHT+IERGpXyJNPD48tKTz9J3vx0i24Gk4DC3MDUX2AGYD6ATJSznuNuExcyrbs1KgVKSwshiRRcUg==
X-Received: by 2002:a17:907:7d8a:b0:ac0:9b39:32aa with SMTP id a640c23a62f3a-ac09b3939e7mr714712166b.23.1741101691380;
        Tue, 04 Mar 2025 07:21:31 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1d860c279sm282696666b.27.2025.03.04.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:21:30 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] Update contact information
Date: Tue,  4 Mar 2025 17:20:41 +0200
Message-ID: <20250304152110.29976-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update links and remove IRC information since that is no longer used
---
 README              | 6 ------
 doc/ofono-paper.txt | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/README b/README
index e2a1c772..b82db8dc 100644
--- a/README
+++ b/README
@@ -63,9 +63,3 @@ Information
 
 Mailing list:
 	ofono@lists.linux.dev
-
-IRC:
-	irc://irc.oftc.net/#ofono
-
-For additional information about the project visit oFono web site:
-	http://www.ofono.org
diff --git a/doc/ofono-paper.txt b/doc/ofono-paper.txt
index a03e75b8..26e5a819 100644
--- a/doc/ofono-paper.txt
+++ b/doc/ofono-paper.txt
@@ -166,7 +166,6 @@ add telephony capabilities to Linux desktop and mobile devices.
 
 6.0 Resources
 
-Website: http://ofono.org
+Website: https://git.kernel.org/pub/scm/network/ofono/ofono.git/about/
 Mailing List: ofono@lists.linux.dev
-IRC: #ofono on freenode
 
-- 
2.47.2

