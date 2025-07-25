Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F2242D7F
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446035; cv=none; b=VDeixzRZDpMNzFzJRdm3HoAbHQdLA9e+vwJ9bC4o/iEIZh8mNPeGLpQ0XumBzA4P17BvZ1LSdB4OQpa1Cc4cnqjYmN0VbQozp79lABImqjLjTziMFItBhQZbzpST72qTR6VsE+SZSGVHTfApWmLa7bnkUHTGNi+tibwWEfU/Hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446035; c=relaxed/simple;
	bh=U3yr0y9vRa6pizytB+rw90dX2iDnrFPQgk2162bekXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dF5oc9BZmWfkcIBH7VfjqgzJY0dXIobWbRqcjXzUmI9Sm+kqzFaIzatYfAYhAfKVFP43oSCts8j19+1tSJ/waUSwwY0INchnzlEIIJs0MzIcNeyRJAVaP4CkraIOTidYZxT3RfU+HDL6jcT+/oeA/LW+mzvdsjh0PpGOoIotwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBZcalim; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBZcalim"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0de1c378fso280843166b.3
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446032; x=1754050832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw+tlXqaPNjcxXnLkbxV2gB1Ier1/1+hd4FgkPkDqW4=;
        b=IBZcalimg+iiEvz5PQIfPD3NEG22zPfL37YCWDvYJ13FyMpLhMcrML2/Eqcsmwxp3m
         LlNaFQW6Jm0unCHgqIXrClTspOBTrRS60eMMfUQGohIA7E7mRzHItFxX3w8IwB1JxRJ3
         EasloB4xaKMutqO8sdSZpVF7GGPA6vvPtzAV/X9LFhs72gGgaDY8vqZAUr2hHp4aGzCq
         4uFkv/eVP9MM1FmzLSRBjEPgVTOV2Sv8762zFZiacd5DSRBFY7yNYGC7k5DIGd72Kjts
         Ziw0eImc1JiIOWs4/FMyQkcRmaRuTFvOCfEerXAZjgfTKEZACGRxA8vKKOhAkNwppqMl
         lL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446032; x=1754050832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw+tlXqaPNjcxXnLkbxV2gB1Ier1/1+hd4FgkPkDqW4=;
        b=H3wQSMwHsI2QT601OsinnwmGHSGoLpP/kIWGlXeVoBVvrlMedq1efeRmkGKySXHzOl
         12hSazuOQQUm/q3vvtXnhsfBa9fje7QT8WHmdM3Ze+BQ2aubmvnYjEoTizrLoxVIlupB
         /eg2HPkh6seq9U4Godsl8o3hQaA9UZb7NPNNSk12OcAUymMReOu7CMn6q7LHPSNfDf5t
         c41obumGuQ2Xgj1qIMgJyBFH8EpPonGC/yhBa/FXbhwz9lwxNuKTwuAvt1ugIR0zkIT8
         +9mYwkui3Iyhl6QIVgjNskF+wlmsdL8JUfiYgn60Nr70GsUs29c+xWUo6l8kpS+/AUzY
         qQYg==
X-Gm-Message-State: AOJu0Yx8Bjq5xcDh2OqwixZtl7wpgh4jwNk+bGrFym3ns68NQwBfcUhO
	oEP74mPWXfkAJbYJgXVCEy8K7WczvWs55QJhLmy396hlRFBplLPeuL+rL5K2bw==
X-Gm-Gg: ASbGncsnSdf93loj3IJuhGHbD0of9hdpu8TQ7eJDjKGWlcXStULLfD/USw7ha5jawBa
	Q7+hy7gWbkmGSZuFyWtJ1k9/juso8yRLhfAyBWZGI5VAeCwWx2y7WO63EGs37cFJe4T8FtpLEiA
	WhIg52KTL/zstEEAeJ2QKZYMIX19dFDrnSKsRXD1e0yRdONlRSs3pGjQ0qVfaZI1VkLEp0XnKde
	Mvv+DsVWUTLDxbZNOr+g/V54ksBfXZIYGGVukdgeZKX6cxWjuDux+ycLHg8xYE3iNkpp6YnLOBX
	FtaAQPbBukF4ApY0l4NmWmuaF5OtpxrJPqo+ZkxE0h4xkeYv9g8MGui+rCuHJflDVXmOldPh50y
	TvBJInp5vTNzQHvCoI9gTEzAD6IO5n2uiyhwGglhVy+/B
X-Google-Smtp-Source: AGHT+IH6HMDAG7u2rQGos9cfT4NXA8qC3NIJEegx9q/6oYTbhxbmLP6Ha+RlkwDcZr4Yuoq1L4Sc2Q==
X-Received: by 2002:a17:907:3f16:b0:ad8:8efe:3205 with SMTP id a640c23a62f3a-af61d77d1f6mr224828266b.55.1753446031813;
        Fri, 25 Jul 2025 05:20:31 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:20 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 5/6] gobi: Introduce "LTE" modem property
Date: Fri, 25 Jul 2025 15:19:53 +0300
Message-Id: <20250725121954.650668-6-ivo.g.dimitrov.75@gmail.com>
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

There are modems that are not LTE capable, allow them to announce that
---
 plugins/gobi.c   | 10 ++++++++--
 plugins/udevng.c |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index f908f935..7864e192 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -57,6 +57,7 @@
 #define GOBI_UIM	(1 << 5)
 #define GOBI_VOICE	(1 << 6)
 #define GOBI_WDA	(1 << 7)
+#define GOBI_LTE	(1 << 8)
 
 #define MAX_CONTEXTS 4
 #define DEFAULT_MTU 1400
@@ -262,8 +263,13 @@ static int gobi_probe(struct ofono_modem *modem)
 	/* See drivers/net/ethernet/qualcomm/rmnet/rmnet_private.h */
 	data->max_aggregation_size = 16384;
 
+	if (ofono_modem_get_boolean(modem, "LTE"))
+		data->features |= GOBI_LTE;
+
 	ofono_modem_set_data(modem, data);
-	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
+	if (data->features & GOBI_LTE)
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
@@ -1144,7 +1150,7 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	if (data->features & GOBI_WDS)
+	if (data->features & GOBI_WDS && data->features & GOBI_LTE)
 		ofono_lte_create(modem, 0, "qmimodem",
 					qmi_service_clone(data->wds));
 
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 320cd3a6..5627f1ec 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -255,6 +255,7 @@ static int setup_qmi_qmux(struct modem_info *modem,
 	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
 
 	ofono_modem_set_string(modem->modem, "Bus", "usb");
+	ofono_modem_set_boolean(modem->modem, "LTE", true);
 
 	return setup_qmi_netdev(modem, net);
 }
-- 
2.25.1

