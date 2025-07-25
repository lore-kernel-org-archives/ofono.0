Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28519343B
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446021; cv=none; b=Q3tyoZxARYowUO8R/3kRTayuHghMUjdzuzSiBiVt26RL1WpzvIbsjoJFWKWkdcqB/Dc+XTc0mvKh7oXAtPE2m07Pm3IPpCNi3x82h+6gS/p+5FdN8b3c7HVHhch11rARkfZ3JLmBCedqUgEpO9s3Yz06Ru9DAi34qp9NImCJ7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446021; c=relaxed/simple;
	bh=01BgcrT4p3ciNOCikmtFJwa78eu/GFOvCt8ZEYsex4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ewz7lBMJrOaezfEFC9qTs24Y0qS0Yjy7jAPOcWKNpCHPpUkjmBOs5x+UJhdRNRdi08cMZoswDcHTTbsaUA92dNwBNrM0A4iEDDdJfVgUC63MKSXX8D/kvRmt+w48mpEO3cnlVOockUfe3VGdv8/s7sno9OpHqh3cMkudnxBgmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx4nuaMB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx4nuaMB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae9be1697easo569901066b.1
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446018; x=1754050818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjGSPOeSRYr7CAdT3efzSU9I0sY5nW5bhrM0+LmlRLk=;
        b=Mx4nuaMB0djaLl1HM1sjgxyPZjBG6wWIw/Cvh7NLWEXyWceKQ8CsvkuwJwalfdhyKE
         9KqaVyYrKcawQ4k/GA76XSM+wPV9SoPP3bpWxXJITi2r7+JBSBNSk8Uttyz5rm3WP7BS
         fv+8od+oFMGDFszuKEGOoA91vJEiKwB/enBS84zyHp9V7VoSPHTmx1NK//GaYSdZVVAl
         fvcMDcLm/9BRcSP/iaEAhKbLX9MAex5uRZa8vBKflvF0KIfoNRI/hBKoV5rUiv/jSlbY
         CErTujFU9yGHKZOQCrhqg2svoOh8hs4HhX9m1jMAoaXLctGggD6cZavuuE4+Ck4XZ2xB
         xZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446018; x=1754050818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjGSPOeSRYr7CAdT3efzSU9I0sY5nW5bhrM0+LmlRLk=;
        b=d7+FVD3KE6liHo+GAQtBFacyCWMWnVdJyiqi/vAf6pISb++9KS6Hu2qmLc/DLwtnxb
         VBMKZiTw7GI8xZwg881+4D3Wh/Y2ekW0v+EIZ6J5OlNX9raTf/Om1hDpnxhpyS3sc13u
         rcQJfp+E5wARyGyQe/C6Nrm5bO/v53r5mcBWdgVfFmKf9UUmt5/Ycuceilm0d3EVgf5g
         gEn/DCljnkPPDCEqb4vssba7Pmdyv+zp542oT8q510RqypZAoGM8jYo/sK1WAvP84/sB
         /EmyG4SRAWFXXfbgmrgG7zROWi4SxITU+A6epjVl+MzOU5VhvAlpmjlyThrkFhdyISZO
         HLyw==
X-Gm-Message-State: AOJu0YxFEsCciUu+dTfwfQUE6qfYgZ5ZAJTg+8N0crcC0MRZdXnamiuz
	AAEIQZr8G+OY6gmcwU6LeN/YvlOHfTXVQmxfLCBqp2MDeGsC6i44Dwq3iCMAEQ==
X-Gm-Gg: ASbGnctQwaWfdFFac+E7RvuJNzZxtQtoCTHKaxDlsuNNQDeF9lzwtsuBk7deGCTPhgZ
	yvkL7njlyG8AzoXW75Al6n+Tj0xyKKzyUD2vg4eV3Kbaq5XvIdH5tEIPHIjDKlMBsPR49PCqbIQ
	iH/cGzIpABfSj4JIesdn8Z+tF441RCoFNlxaZJjY8islqA0XVQoF97iPJ8ifYZJ9kc72iewuK7m
	/QE53aqLnuLKATvDOBNQWNF/1TjJeDJP/7wl3PX/3VNSM89WW4ovilRM/NrEpEvEHXFLBh3KPsx
	DyseyJ/VOIcg9WEV59kVRaj3zxHUm6m8v2cB1e/hKH7C+cf+meOchns93yC3QFs2SM+4fXdtsgI
	t8C9MfiunUW8xGDk/Xn6JdGM05roQoWOMDtynt5Hs2Gn3
X-Google-Smtp-Source: AGHT+IHNaDShJ/ra29PyLTA8PapfhtRQiTOsr13ri9opJFTaZvMqbyVGbcDBvn/1fZXz5bxCMDp8EA==
X-Received: by 2002:a17:907:868a:b0:ae0:bf99:6c5d with SMTP id a640c23a62f3a-af4c48081efmr610573766b.26.1753446017617;
        Fri, 25 Jul 2025 05:20:17 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:17 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when disabling modem
Date: Fri, 25 Jul 2025 15:19:49 +0300
Message-Id: <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't want modem to auto wake-up when
---
 plugins/gobi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 52ead377..027c4dba 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -442,7 +442,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 	switch (data->oper_mode) {
 	case QMI_DMS_OPER_MODE_ONLINE:
 		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_LOW_POWER);
+					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
 		if (!param) {
 			shutdown_device(modem);
 			return;
@@ -922,7 +922,7 @@ static int gobi_disable(struct ofono_modem *modem)
 		goto out;
 
 	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_LOW_POWER);
+					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
 	if (!param)
 		return -ENOMEM;
 
-- 
2.25.1

