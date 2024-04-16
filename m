Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809A1304B9
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280497; cv=none; b=jGrDGHiBZGKIJxjYdjiW1dlP2YBtIRLSKThoZb/6wdxFt1Q4IIbBE9kA3sW+FIXVJnNlsKx9tX3mGUC9GLUbSivOPjh/rVSV8Bxhw5fK6OvHX3oFLcEYWDgFcbhoRSPPvzb69lOQxLtSWzXKsWFoqrUfBCz0ispc8UZNHzD/CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280497; c=relaxed/simple;
	bh=TmrkLp8QAbztndOJqg3SM5jwPMcwo35NoHBEJC7wkKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdhFdxFscP1M/4FH2kK7Q9dJjnxOFUEbf1c36a3oDV7i0dI/K3TurUgH04y05krswz8aO+vUrmDxNtx3JNmzOUEkiI/dz6K+Ww9FBEuo/Z9Mo8A0evlpqapzngwQvNWOnjyrjiFOpEgmxIZd89irUQnosEayB+13XFwUAUzAkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W56XMPgw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W56XMPgw"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c728a8035eso211425b6e.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280495; x=1713885295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRpBebX0odZpnSbecihT+OrcsDbOa+ZWFxkah4iBqro=;
        b=W56XMPgwyiEYqgBMrzhTpCaraXXoKBS8XD42pR5RxLtrnGioiqnwv1dGxXR8JTH1Cy
         1d8gW6Mo60jaQMdnZ2DLJjWki+mxzoYK47y8sfKYoDqVN+7W3d6g5a6nYPIJ1mOINbAW
         PKQICHYCy29aVqQc2oYIeTH68p7h1vGhhFxJ+1Osx7ofoDCqzwulQHPmtV6iUmvzKTVX
         5cWLYDfDINJXiiBSOnUUOVyG1KjMsuv4v97H9pQV5VmAB8TC8pKudfuRFfVvizfAPFei
         mDi7v4xP0MU02yF1a9fhQhNvU4moRBQ22OGTd4jUHCtz31R/9KJpoUhq4wPacmwcHYVQ
         yNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280495; x=1713885295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRpBebX0odZpnSbecihT+OrcsDbOa+ZWFxkah4iBqro=;
        b=PgHoXadah+8iyF+xbvqN7t5mtT1ws60dEe1yabB7z/tG78cGJClwfmjnSF7wrcxa0z
         io4WSuP3G/FU3B2Y98P8ZpVtHybU8vsnJMim5rROfH5C+q2rBQ1irXz7zODrKrYTNF+E
         jOu8GqFAjzh87EauuhrNsVhrteZVPeM1Sv2LG4I5aMKxltaXkkmdyaWZzxzIdgoieQ8+
         CDgJOMk2xclkMmOkigE8pxHy5Akcedzlu02yHbbE39KMWPkMub4zWH3lNmuyjJI7nzvx
         7imArCn+GgiqJil/WCVi2Ueu7EompLips953M2A9LRJ5If6WvFoXPxokHDWnFQyCS4ow
         fp+A==
X-Gm-Message-State: AOJu0YyPY4n7o+uD/pOMBg97ZRH9JE591SG2agG65MbDMphyJLhmmrSt
	WQQGSJxbwDbn/oo0MdDw0UuWvmslsUQJqEM9VneErnHxOtfwJspTJg8Kdw==
X-Google-Smtp-Source: AGHT+IHIBX3VWAqMURLd5hJWVC1JKNJFkACRrT1IEvgLr4O2oXsIADv66K3F1uy8q3GP11C2J9+IoA==
X-Received: by 2002:a05:6808:638b:b0:3c7:2895:2e7c with SMTP id ec11-20020a056808638b00b003c728952e7cmr1288409oib.36.1713280495342;
        Tue, 16 Apr 2024 08:14:55 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/7] qmi: gprs-context: Request certain TLVs to be included
Date: Tue, 16 Apr 2024 10:14:34 -0500
Message-ID: <20240416151448.3359644-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416151448.3359644-1-denkenz@gmail.com>
References: <20240416151448.3359644-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly ask WDS service to include certain TLVs in its response.
This is mainly needed to obtain the value of the negotiated MTU between
the modem and the network.  MTU is not included in the response
otherwise.
---
 drivers/qmimodem/gprs-context.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index b1fdfc74cc34..3b5164bfea26 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -159,11 +159,14 @@ done:
 static void start_net_cb(struct qmi_result *result, void *user_data)
 {
 	static const uint8_t RESULT_PACKET_HANDLE = 0x01;
+	static const uint8_t PARAM_REQUESTED_SETTINGS = 0x10;
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
 	uint32_t handle;
+	uint32_t requested_settings = 0;
+	struct qmi_param *param;
 
 	DBG("");
 
@@ -177,6 +180,19 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 
 	data->pkt_handle = handle;
 
+	/*
+	 * Explicitly request certain information to be provided.  The requested
+	 * settings is a bit field, with each bit representing whether the
+	 * TLV is included in the GET_CURRENT_SETTINGS response.  We request the
+	 * following settings:
+	 * 2 - PDP Type, 3 - APN Name, 4 - DNS, 5 - Granted QOS,
+	 * 6 - Username, 7 - Auth Proto
+	 * 8 - IP Address, 9 - Gateway, 13 - MTU, 14 - DNS List,
+	 * 15 - IP Family, 17 - Extended Technology
+	 */
+	L_BITS_SET(&requested_settings, 3, 4, 6, 7, 8, 9, 13, 14, 15, 17);
+	param = qmi_param_new_uint32(PARAM_REQUESTED_SETTINGS,
+						requested_settings);
 
 	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, NULL,
 				get_settings_cb, cbd, cb_data_unref) > 0) {
@@ -184,6 +200,8 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 		return;
 	}
 
+	qmi_param_free(param);
+
 error:
 	data->active_context = 0;
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-- 
2.44.0

