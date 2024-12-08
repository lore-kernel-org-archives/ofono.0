Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196622097
	for <ofono@lists.linux.dev>; Sun,  8 Dec 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658588; cv=none; b=gCNvPGQbgBbJf6lrgfcml0ovz09AFvP0lxJJPNGVRFmDA2hqQH19ihZT4AV9KRLWCqvfXqQ3UCV12vxY0dzRRg/mm3isutPZ3hjH4QpYzffSN0fm/F9+D1h02JVvX+rsRonYVup618bezKteMgm315a07J2k97SwjbHb9grcfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658588; c=relaxed/simple;
	bh=JxAmRNnwcDXZZkk+hC8/ScdirjBq/9C0m/YzsBA7uto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LePgffrSRkgzYsgtkQvUZYzdLzWdLQhasASpA3o3buVVmCealY6oOCsk6f/U/Uiuycn1JtTEQ0mxhFb3vMVpAe6/f9e+ijIPGSChI89YRoyDSiDcimkCt8GYt8fvPfjBO23Lun/kgWB1yC+TJVopH5UJT5n1ASlAKhjDnedN+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCNk8EIn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCNk8EIn"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so297828666b.0
        for <ofono@lists.linux.dev>; Sun, 08 Dec 2024 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733658584; x=1734263384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iG5NtbLWDJGNh+zs/3cSwdUHjnwH7XspqMGmmmFY7IA=;
        b=nCNk8EIn+3SsZK7TgEVc7mFq45CLsG92WGnzmTRqnITTiEP6OReQAIIa/faUShXC40
         vuNYNfLlOda4RtWt3w8Seyq19MTlgES50AaaUmg/Ionf5/aOakmQY3o7Z6aP+lpyOcvb
         Lksg1HWgCbB28xuIxaBLswSiBUS0da4Zxhd4gjYW5I13ZSoc2pg7I8UL4qb9M0UieL6j
         HWNrNIagVkOKW84MJWpgXXq2fw4GKwM/W1kPCeqaqF0mJDINpmSyNB6q+3rvvhp5YpMJ
         8o7iMdtVIhAqEu/TZjbLxR55fnNhciVxzgV3D9r5BkDB42yRrcu70XlvyUZI3/VflGLa
         yICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658584; x=1734263384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iG5NtbLWDJGNh+zs/3cSwdUHjnwH7XspqMGmmmFY7IA=;
        b=FxE5xZakG24sWkUxsFWTuZWbQLdvwst/LRvcBD4CPlNjOMuA5p8BNIJ9ogXAB+vw61
         MCyLTROE0T7OZm/7bp050+uqiArqtvYGEaO4bIcEJzx9gXNgaWCA85ku1XJzzOJQW/wV
         zSuchFPzgCDe96SWdiOy9SqYFv8KS66lEs9HwFd8HpAzWIE3ryiUowxsuWt+IhIv7r2/
         OulP/fCI0GvQHFbmDa4IBOASCkYu1SoV3FNMEpZxG4L4qFaaESw+BUXJsK3dyh1wtMYi
         CsMvdepuSCx2JBsTeutNweDoOLIkgI+aBMZ5aPR1jtxTf2ENYHbKCz+BcgFEKtJXmfOO
         mVYA==
X-Gm-Message-State: AOJu0YzuTPDyqH/OTuDTtglnhA9kW6EWKYYHYbUn+OKBxb7nNZ9qZCxK
	XpcqWJNWGuQ7x0tD2aD2H3EK9EqRulVhvmoSOggfb2gr7gEO3iCnHDNSww==
X-Gm-Gg: ASbGncvJzoFQxw6b4Pa8i6rniVUvDQ/GcXBJBGFHV6OZ2Fl/VW/jVKNfyb3ZQuueteu
	GUmMuoMiIgToGYd+p/pLQr//GxLIvHs/Dxrv46rNavcet8matq1ryDoj9+7V1R5aGdta/2s2+NX
	uFOqUnPCxPO1nO2sx05xl8fApKFeOtYamvWsb/vdgkTFm3fG6zYhnWbMRb4+Pd6gq2uKt7i0DR1
	28zocEGq0iUxp6x33/7tGFt+gAoppGhBr/Qh7aEmqBG2eG24MqmlC7tkiSZoHwXT1PAJWaN
X-Google-Smtp-Source: AGHT+IHG5LD9oKbLFnEkwbRssH8SFVK/HSQsSQSs/cjoUUv9XQiWoOy7ofeXt+CexF2ilit+1irdUQ==
X-Received: by 2002:a17:906:9ca:b0:aa6:2c18:aaa2 with SMTP id a640c23a62f3a-aa63a073293mr805358866b.27.1733658584224;
        Sun, 08 Dec 2024 03:49:44 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6761d0ab3sm104512566b.201.2024.12.08.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:49:43 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: netreg: Fix RAT detection
Date: Sun,  8 Dec 2024 13:49:34 +0200
Message-Id: <20241208114934.252012-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not clear why extract_ss_info is looping over all ss->radio_if_count
interfaces, given that the result of that loops is that it always gets the
last RAT. However, if there is more than one active interface, like:

qmicli  -d  /dev/cdc-wdm1 --nas-get-serving-system
[/dev/cdc-wdm1] Successfully got serving system:
	Registration state: 'registered'
	CS: 'attached'
	PS: 'detached'
	Selected network: '3gpp'
	Radio interfaces: '2'
		[0]: 'umts'
		[1]: 'cdma-1xevdo'
...

the current logic will set tech to invalid (-1).

Fix that by looping backwards until a valid tech is set. That way the logic
is kept intact, besides that invalid RATs are filtered
---
 drivers/qmimodem/network-registration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index c0c9338d..3c9df0c1 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -96,10 +96,10 @@ static bool extract_ss_info(struct qmi_result *result, int *status,
 
 	*tech = -1;
 
-	for (i = 0; i < ss->radio_if_count; i++) {
-		DBG("radio in use %d", ss->radio_if[i]);
+	for (i = ss->radio_if_count; i && *tech == -1; i--) {
+		DBG("radio in use %d", ss->radio_if[i - 1]);
 
-		*tech = qmi_nas_rat_to_tech(ss->radio_if[i]);
+		*tech = qmi_nas_rat_to_tech(ss->radio_if[i - 1]);
 	}
 
 	*roaming = ROAMING_STATUS_NO_CHANGE;
-- 
2.25.1

