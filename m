Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476171E50B
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232650; cv=none; b=iOJqLXH9NXZYhUxGzDgf5e1YfTs+nIywvdsKsVqhi/AkCeabCqF2Obh9dYMPQWiKLBBS4gnr3kcaKdUPm13yRJSWKKZ+nbVf0bSNEoavdiveSfQYsNytdI4MSeIQOxPj378K6xyysuYs/bP3Tpg2zrFHtTo5YXWp2liHxbjWpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232650; c=relaxed/simple;
	bh=utKDdbHSkG+N6iILEJ0Z8fi+EUlATN/9a3nqOgAPScI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVJU0gXckx8p4X2A3SKt/u8qx/UZd2F+FE8rgeaibCeYUrsio5N47y+ka+YzN2FkK6gNKq5w507wy0j5CKMNM/VGLi63m2EG6NdPfyas9kqYKcYQxUjXU4AcJsYsmIxYKgzjLJD6VpEKyzEpv/esrBJgF9RKKFto/fzWTSobJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLGPJ7Lp; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLGPJ7Lp"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b2a66dce8fso2782778eaf.1
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232648; x=1716837448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W951dU0+kqSN1FOecQgAXrca1UCpetMYC2XeXRjXzwY=;
        b=hLGPJ7LpZadvrqG/GIfKVH71WPMLwQ2OhuB9x0XHA+CLngm8BvHWjpaezNHdgjItKe
         fHxaEI4tcmJG3q5PDOR9vo9C+rhLmTlH1MMn07et3ly2rHPF/LBTpA+NP27Ti4ZwKN6G
         RX/NKAPN1bnNZacbt1LLTnGgNLP4HA7NAwd/2g9CMGh7lG9nHYldsSIDioULVLeQsTYk
         9Zjd00OB+iiiW+wnCGjpga97hUiKwf4l3aN5xB4sMfneEKXe2uzJz1Znv1yd+nzebZSH
         UAr4ZrpCweNPc2vhDye95euH97lWawJtJo4OhXlB7jGEKt23bYsBwgcHVFUylNpvNwaq
         N+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232648; x=1716837448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W951dU0+kqSN1FOecQgAXrca1UCpetMYC2XeXRjXzwY=;
        b=YlWHW69TiQt5nRCwmYAmlZjhL25HmjvrjyKliSUpko4IOhocPw0gNGsS+mqJNz1QY/
         QICEubJmSdRFhjf/radYst3U+B3yO67h7ignHaqP/XzzsgCEMRiADccWhl5wpriiUHgX
         ToqoDRPo+cv+zVd37RKZbsxpSt+kvKK2CA89wpL0dbvRoL4mr0+Guv3GRBhl0r4Zp7av
         oiD7CJZzyMJkSfa/G4q7wOqg0EbgoRKOIQQFQWKc8m33bc1IbeFKOtTbdmQc0Vntfg1P
         Eq+uNLU3FjgQr1qFaxTuHUnoQMRqZ6f5eWRnbnPIkJk04uhM1VoCdP9VgTzYYVmLbYrp
         xcqA==
X-Gm-Message-State: AOJu0YwvOsm2uDZ2o2VZNJK21Z88YS6+2xEEbYgQdpCBdVFocV9B6NeE
	QvjjFz5uhLXMwlQNF/iUuBZaEd2bUUdzN1N8b9tq3CDcrZ32krLPo9PX/Q==
X-Google-Smtp-Source: AGHT+IE2Hv9bPc58NyYuZY4lcdVEIyD+nc2y0EDjkXN50w79nNatiMtkSRtne5qtYpv39f9PEWOXdQ==
X-Received: by 2002:a05:6820:161f:b0:5b2:2b8:e419 with SMTP id 006d021491bc7-5b365c02154mr6584473eaf.0.1716232648386;
        Mon, 20 May 2024 12:17:28 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] qmi: gprs-context: support bind_mux for pcie devices
Date: Mon, 20 May 2024 14:17:07 -0500
Message-ID: <20240520191722.184977-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520191722.184977-1-denkenz@gmail.com>
References: <20240520191722.184977-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PCIe based devices when invoking
QMI_WDS_BIND_MUX_DATA_PORT command.  While here, also refactor the
handling of InterfaceNumber property and make it clear that is is
only used for USB based devices.
---
 drivers/qmimodem/gprs-context.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 3a4f2f0717bc..6350d6584d8f 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -525,23 +525,29 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 		goto error;
 	}
 
-	interface_number = ofono_modem_get_string(modem, "InterfaceNumber");
-	if (!interface_number && endpoint_info.endpoint_type !=
-					QMI_DATA_ENDPOINT_TYPE_EMBEDDED) {
-		ofono_error("%s: Missing 'InterfaceNumber'",
-					ofono_modem_get_path(modem));
-		goto error;
-	} else if (!interface_number)
-		u8 = 1;	/* Default for embedded modems */
-	else if (l_safe_atox8(interface_number, &u8) < 0) {
-		ofono_error("%s: Invalid InterfaceNumber",
+	switch (endpoint_info.endpoint_type) {
+	case QMI_DATA_ENDPOINT_TYPE_PCIE:
+		endpoint_info.interface_number = 0x04; /* Magic for PCIE */
+		break;
+	case QMI_DATA_ENDPOINT_TYPE_EMBEDDED:
+		endpoint_info.interface_number = 0x01;
+		break;
+	case QMI_DATA_ENDPOINT_TYPE_HSUSB:
+		interface_number = ofono_modem_get_string(modem,
+							"InterfaceNumber");
+		if (!l_safe_atox8(interface_number, &u8)) {
+			endpoint_info.interface_number = u8;
+			break;
+		}
+
+		ofono_error("%s: Missing or invalid 'InterfaceNumber'",
 					ofono_modem_get_path(modem));
+		/* Fall through */
+	default:
 		goto error;
 	}
 
-	endpoint_info.interface_number = u8;
-
-	DBG("interface_number: %d", u8);
+	DBG("interface_number: %d", endpoint_info.interface_number);
 	DBG("mux_id: %hhx", data->mux_id);
 
 	param = qmi_param_new();
-- 
2.45.0

