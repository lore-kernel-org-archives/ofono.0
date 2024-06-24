Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4C19EED7
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257606; cv=none; b=f3y3qtM+roVVZc1C2i9AZBedUuj1I+Sh9OP0qcpB0kYfha1jDAEfjkPpyZodAmFX3s1mmJnK3UVO+mfyirBrk7CwwbPlZWPtXiM59+h7TkP3Q/UIokdJi/45nl+4ODIqhDr0J6WCA+cMhrL51x8Cg+PoyUE2uEnXWw93fO5LCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257606; c=relaxed/simple;
	bh=ZGtiHPN21MhCAaqJM6rSmOMD38smuTtO7u5r8aJN/JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuEaGsQ4CKWOTAu/FlnH2uQxW3WWJ4ZqExfKtlLx2QA0a2spqUYLI8PS3PcEOGXY9HkYKofwar6+XBnP9aIx2XsoUV/fq/Bk5pTOxGCnHUJaaSyuFFsSlHch+hLOUycOBfUx7GFOYpQlIs+ajY5V+OyurOatmWMB0agNhfuoOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDNkYc/R; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDNkYc/R"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5baf982f56dso2369400eaf.3
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257604; x=1719862404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qAO34xzasG+cTdqhTqw6kXz7aXB7KmCOSR39U9iINc=;
        b=ZDNkYc/RyGiEw7FQADqIkkLMOQ6aFSMTCBQ+qh0ZrrKXtV/o2BP8BjM4OyXtmh1uDI
         Ta5Z4ZJbfJqtBb3omSWBPasvM3FxFeM4+EUqcXws/sucnRudxEFKzv6eekWeYFnkJwvR
         7NgTJSM5U5+2fPnro2iE82CF1dL0DYMpyW/I4oGmNKYFtHDfirehWV3qHsHIFno9L9bz
         nusiekNXmEHGMvflZjmrUb7Aj6RQQB+sgvPXL76N6GvzViKmEmjE+d4tPnmX7jUUdbHd
         OW/I92q+aoJ8q13x8jyqxYwT9/jadm2elYIlDnC3HnKXt1ts7rXmzQRiXr7Qop05/z+a
         rpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257604; x=1719862404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qAO34xzasG+cTdqhTqw6kXz7aXB7KmCOSR39U9iINc=;
        b=FP9GSt2GaC+Q6d9sUCKeJute+epPUJtQe/3tCBgVNiP7zMA++18xut69s4rLzb463G
         2uMK6dV9YwUEKKL1CAORdcZdh+gMOZrZUAtosD0bBQtmN4kqV8VSkOSMswFBejkaE/qh
         7QLDE/ExQIRaN67uQnZaRWIUWhBAPLANOWn995SJlCdcvyz5hVGJhgGfqnVo8bSDxBiT
         uwd0BPAcKalWIITR5qdUEIc9kjBiVGQoM0KtyrR8vy7LNbLlmhQ9SF3GZVoG+HNVv28s
         jl+dSh+jX7dIXds6WRz+s0s/c2/RqfU/kZiQUHitDWA53C0ZW5ckaVa3AOgExPYVhO5V
         I2pg==
X-Gm-Message-State: AOJu0YylGifRmrP0o1OTVgfQVmkhrj08PxbqrjgUZHZI5uu20rKzYvfu
	1WGpZsi1HgLNAOTF9B66CGgr/OOF5izHEvc3Br2KRTpG0uZBlu4uxawLQg==
X-Google-Smtp-Source: AGHT+IEUJpaQZEVFi4tGyeCT27/z0x8woWcRbYKtiGLbRF3rijy/DtnDaKrMty+v0CSoN8AShMwnrw==
X-Received: by 2002:a4a:91d3:0:b0:5c1:b998:a859 with SMTP id 006d021491bc7-5c1eec0a767mr5602455eaf.2.1719257604598;
        Mon, 24 Jun 2024 12:33:24 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:24 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/13] qmiqrtr: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
Date: Mon, 24 Jun 2024 14:32:52 -0500
Message-ID: <20240624193315.1164943-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QRTR/QMI protocol details are now mostly stable to the point that
hexdumping what is being sent / received over the wire is just noise.
qmi_qrtr_node now supports setting separate debug handlers for the
underlying object and the low-level IO.  If OFONO_QMI_DEBUG environment
variable is set, enable debugging for core QRTR/QMI implementation but
disable low-level IO debugging.  If IO debugging is desired, use the
OFONO_QMI_IO_DEBUG environment variable.
---
 plugins/qrtrqmi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 4117cac11423..b64ab355a2e8 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -52,13 +52,20 @@ struct qrtrqmi_data {
 	bool have_voice : 1;
 };
 
-static void qrtrqmi_debug(const char *str, void *user_data)
+static void qrtrqmi_io_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
 	ofono_info("%s%s", prefix, str);
 }
 
+static void qrtrqmi_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	ofono_debug("%s%s", prefix, str);
+}
+
 /*
  * Probe the modem.  The following modem properties are expected to be set
  * in order to initialize the driver properly:
@@ -213,7 +220,11 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
-		qmi_qrtr_node_set_debug(data->node, qrtrqmi_debug, "QRTR: ");
+		qmi_qrtr_node_set_debug(data->node, qrtrqmi_debug, "");
+
+	if (getenv("OFONO_QMI_IO_DEBUG"))
+		qmi_qrtr_node_set_io_debug(data->node,
+						qrtrqmi_io_debug, "QRTR: ");
 
 	r = qmi_qrtr_node_lookup(data->node, lookup_done, modem, NULL);
 	if (!r)
-- 
2.45.0

