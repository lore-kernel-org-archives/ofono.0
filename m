Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D271C07D9
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940944; cv=none; b=PsmIfmw8RwhLokqy6h8thyiHD4ArqJixbEgzamgQhW3rRw1CA6SAsBvYiI9mh5CjDz+2v5+e1jNlJrsq9LfBp8BAN8xcwWBZeh0ON++JnTBskg62yDhsgEJ47SPKZYPopsJ7NuQGsof8U5AJpan9uWy9J4tTjSR5fDNObtMiDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940944; c=relaxed/simple;
	bh=3oFJrrZ+Wbp7AJTOCIhXQ0c8NS4nB0JbxQy/lhZA7FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hiia5V/71rqUna/J9LMCOydpKCZy8h93UzGUDniPfyHU4/wEZNGeaY7aI1o+e2vzyGRrGb/UwZorcBk1Q0jX3z5pn4OXVCDECz5Vaq+niHytVWDqTEQ+S7MPMHMOD9y/ws+wrCuzpmjRs1oOD/cTayVfDT5CGyvnzRzCr863G8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrGEnvQT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrGEnvQT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa66ead88b3so785266266b.0
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733940940; x=1734545740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEhZMPg66urbgrRq26UvwuiDT7RUGqyRKrEbrtQ0ozY=;
        b=XrGEnvQT6WsOM8DWHflbdICO+cd9JRea+lqR2gkpbr+Vi12JmJgw0jANxF6R7v9Yd/
         rnjsPhdgscmUv9LSCtjWR0YZS1f0kONsL/ewNE//e8vAV7effhYMJRZIR5/s4fQZmxB9
         LsZDMwSZOyVYkCtpV0JJODGK8Oep0NMC1uZp72VbpH8VqlWxaSWu321YeXQEczzFE007
         Hc9pL0N65n/ozojhzRckCGqNJOWN5MEktrAWvngCBHIXghSe70IjlkeiABwhMYnE2/RE
         rzqfdUjUuQZga/pgoIt7pnSgSu3DyASfpfN9rSfZ5T/fgdHPGwBlS9ntj3Je/0hD4p7w
         VASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940940; x=1734545740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEhZMPg66urbgrRq26UvwuiDT7RUGqyRKrEbrtQ0ozY=;
        b=S4ltEzhkdh0iGLfFUxotqfpVbB8f9S9tjNyBscGuQe6lUBj6shFTWDMXXKFYYaZDvB
         yENvu0fHYzMNlIpsngbI6cpkOhpNSqwL/o+Zz2W4KW3p8CO4Njl8NfM7s+cPLXKztzro
         BG4fcK3W1eWcCotkwzhZDy/3CJ7lkoTWMhgQwmn2tUjbvFSyDsuyhoJNQ0k1V5qtEsoJ
         fcBq79vPeCMKSvBjUoNE0eg5Qf4UJwQ/qnRP9l+BIaREwPHxXq+M9nbtQNzNr7yGSPP+
         +YfXOZ6flAhN9xbw1QVyw1G6yjxyRaKEU0o1vqOCunhZafafQyYgXiEwzWfGXOp57Pd6
         lQXw==
X-Gm-Message-State: AOJu0Yw+wDKp73d7S5eGHb5rokFFTMqMfrpfLmxlZhlaFgSVnT4R0pY0
	TNKgrWRDH7nzY6C481zSo4ybyCHQKNvgbS6H2jhXblz8wkhWyInWKEQ87Q==
X-Gm-Gg: ASbGncvq2Gf7lL9PIcLZRkg8rQU7JzZ9YATZvqGyozIGDIpJIcYNRE3+UaoNYtFnVSB
	//MHo1FVkllYfUOnF90qDdo6ZOL9cpm8xbHb07JQRreWKG++M+RtrhflQIQE/D0xztdtskwBRnM
	jEwIMaMqn/ApXsM+nIYLSOKOqrdfsLXz8uzwxLiysEqOstlod0xhKcHDwakMk2hGIP6PEnuWZNL
	gK6klVGwfw6B1d3rOfc1LAawXqyJNRXw9gAnThKG/Mv3PT1mfUX76AQf/Yr/xFKn5DlxBXSuZDZ
X-Google-Smtp-Source: AGHT+IE8AGpzqO1TzoWtfPMsq81xQFzIWGEEqu4OcR3uNiP1sk9ur2l6cwCXSVOqXR4nnlg+G0EpKA==
X-Received: by 2002:a17:907:7847:b0:aa6:7933:8b2f with SMTP id a640c23a62f3a-aa6b10f5d2fmr324967766b.9.1733940939846;
        Wed, 11 Dec 2024 10:15:39 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa666bc8908sm687007666b.22.2024.12.11.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:15:39 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] qmi: gprs/lte: query for tethered default profile instead of embedded
Date: Wed, 11 Dec 2024 20:15:14 +0200
Message-Id: <20241211181514.504220-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4bc4e74b-9f31-45ba-b913-39a65d7653d6@gmail.com>
References: <4bc4e74b-9f31-45ba-b913-39a65d7653d6@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least the modem in Motorola Droid 4 returns error if embedded 3gpp
profile is queried, however, it does not error if tethered one is used.
qmicli uses tethered when doing --wds-get-default-profile-number=3gpp
---
 drivers/qmimodem/gprs.c | 2 +-
 drivers/qmimodem/lte.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 27060f9f..49259234 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -418,7 +418,7 @@ static int qmi_gprs_probev(struct ofono_gprs *gprs,
 		uint8_t family;
 	} __attribute((packed)) p = {
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
-		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
+		.family = QMI_WDS_PROFILE_FAMILY_TETHERED,
 	};
 	struct qmi_param *param = qmi_param_new();
 
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index d2d1048b..0d9f2911 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -172,7 +172,7 @@ static int qmimodem_lte_probe(struct ofono_lte *lte,
 		uint8_t family;
 	} __attribute((packed)) p = {
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
-		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
+		.family = QMI_WDS_PROFILE_FAMILY_TETHERED,
 	};
 	struct lte_data *ldd;
 
-- 
2.25.1

