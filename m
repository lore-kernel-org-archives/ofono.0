Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA2174EC6
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333731; cv=none; b=GInZwT3zkhgWKQNMoWNJnB3zkSv8DObeuBS+52Rvsbnhx2HRr90515YuSgBihquIg074svMMhziyr745UKgF/rEtdD6frT/PSvL8m7mZkc8edDDn9uhFmdGqJxS5uPE00DWjApkL/XwCRS3A7uf5u6NpJHQSWoMI4LpP2T02FzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333731; c=relaxed/simple;
	bh=ZGtiHPN21MhCAaqJM6rSmOMD38smuTtO7u5r8aJN/JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUvXG55j5udD7BLEIK75aniSULmxihkxXoaPBtp7nxKjX+I0Voa4aiJDmKMmICqCRxHQcoq1VFPLfN+baw0OtUdHIqXeLLoX/4TKr6CzchGtd55A3evh8m7XvEhn9cod+V1EdYrrwS+umLxOhFZyreMEGc1xBBCQjJ6tkvGNX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UumiBCN6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UumiBCN6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6fa11ac8695so3364867a34.3
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333729; x=1719938529; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qAO34xzasG+cTdqhTqw6kXz7aXB7KmCOSR39U9iINc=;
        b=UumiBCN6TyQrvG3unCB+ePDciK5BAs2H5hlB8SejIOwMXYOFeA0AEz9RtNRPXqqK2u
         pksKAjx/CuSch+geLjOYYUdJxfaIh0DrSBpw++brjg06GHjmiU9nlayNUH+uiF2Zrqff
         rfepSprR2Xy5sOLg0cQ4OrbFsstsTbM5uYPNWqgn78rCsE76vE5uBQhgJlKn0/5j8IxQ
         nuRnPXysGVmIJGE+R8F7vc8t5dbTbtv+vrJA+FlFzquiVzPheV0rOrcWLb+hfi8i0ivN
         i1PrAokTxMgVwNU+7WIwS3bexihh7VuDRFHftmjJBnbNNz9MdpFWq9zATmJiOigSePyW
         61eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333729; x=1719938529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qAO34xzasG+cTdqhTqw6kXz7aXB7KmCOSR39U9iINc=;
        b=sr5iZECHYYY1C6E62igPAZn1lEI//MuN6Es9PcbYYIqHgH1CsiyiyPZburcx63xkDi
         qdFezJEcPQ+IRF3AtPwmSITEQ3DynSJP1NpbOPj3/TbBRw8VorqspTpetRzaKoisRiIl
         bqtwbNTzzxouL/z1KTfCTIB3px18sdex2RYnme95yLDWDuO38v64aW6C3iUQgDBSU9OO
         xZcm0M1GXmsHP4CLN7QorXvKodGjhW4S3Qa9ri5l/FnPLmSMIW5IIJ1IUUl5FSHka9Lt
         msGX6BQe9VFzz+2s83/NdjajDLR9NtxK3AKxWlhQBZE+cmSXHV/aQQXz/rzVF2vRZCqB
         IoFg==
X-Gm-Message-State: AOJu0YxfEeGjN5fdARyDEDbAUU2hkAngVqbOs6x+YOxOuJFjH7J/Hl4v
	j4uXUGOlhNXiOO+AKUw2kraWSpwrWcgYAN+DU9qDs0nwaSH1uNRlwkfmpw==
X-Google-Smtp-Source: AGHT+IGhc+Hk5GaK+V9+zW0LdpHGLJ9gGhejC7eeaopli2uYNxGZMi5e267cY91eeVfvoUKw65Pzjg==
X-Received: by 2002:a9d:7385:0:b0:6f9:6065:5253 with SMTP id 46e09a7af769-700b1301e32mr8148615a34.38.1719333729351;
        Tue, 25 Jun 2024 09:42:09 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:09 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/14] qmiqrtr: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
Date: Tue, 25 Jun 2024 11:41:45 -0500
Message-ID: <20240625164158.1170937-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
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

