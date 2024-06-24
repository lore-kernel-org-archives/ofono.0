Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF971A00F1
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257608; cv=none; b=IcbdnVUVo8ODtPbBj1mPaPY5Osy6yKRBkLJLQqhxgNnbpFPxisvcmBAIeZiM7WKmKNQp/LnBWgqBoAY2F2zXmWQB+howZPVCp65kPG2VxYC+zGMk6Qo3SrUaGEjgma54YIiW8hW/0uB53w95zJtJVbYbkQiDWN+ihPm9iHW9+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257608; c=relaxed/simple;
	bh=Sf9SAntpBFui7nghYemR2jMqlLdL23TjEM13Oni+L9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHjpAuq+8BXp9GWJDIJYAgDx9uq3xtpaWZ+e8+mWbwRt+Gq4R8xbH1pvWipq/ykOo7KRe3jwP1yCeEd1XwPYLPtcHI7aJ9Cy6TRqJz0W+FjBwmVugM2NNIIcKPSh3dErLjBxPTpk6l6Y5HOITUvuohnBdGtTX/G0yU3hKTDzJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNgyvdzW; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNgyvdzW"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c204600d49so568963eaf.0
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257606; x=1719862406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEJTUCe2wf8DQsbo+XSZs7Jrvac30T/fzttl+mCxL7Y=;
        b=RNgyvdzWI+zHAI2/mN1tyOjLQGZeVGxJGQZq3DWpHuZ43Md5h5+JUNcUZkEgl83B3v
         qyahV77RM53nxTldgtAOueF1/YDhrA2wYLuzcLA/GPyLwTd3eWP4fFclJD9ULkFWeJ6P
         towfRUCeShiSzjqcctIlIDT9CPwnDE8dmEUSEKudiU+viKFImCQxmSiSdB1PqSF+JDkF
         iiaaJwiNirkx0wBx0/wSqKzLQ+jnluGMIWQZWOnVxSOFGfLW7ohRueXYYo+ie6T6XoYV
         o4ubGaoo2wU2Tvb4FofWGuLLgo6gR6+ASlR2B0nMTh/naj9frPePgUT269Dsg7VYA420
         98tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257606; x=1719862406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEJTUCe2wf8DQsbo+XSZs7Jrvac30T/fzttl+mCxL7Y=;
        b=KDQaniiuRmdSRM76G0wsk4IpY0aDIDkkpeKJohkrwFBRkDaSTgxg/MsecC+TV796Yi
         ylgvSMBGb3Ba4VtCwoRwuv+aHW4y6LidglczKCjAv0br/bKbxP2FedoW9unm9i7rZYTZ
         4ecJJpNHS/M10/AuPiX9/SGFiwjB5oAVHvkqObWOGCLZXJ5CdGKyV3bBiaigRKysLDDb
         OQxsOyea1LAl1f/wQPADxfLwwBHUxcFwSFZ7kMsDihXM3ipGlAjCm0G+uKPCMFbhC7p/
         N22+Bnw+GO1z4FA6QO6qyzvKubhUgWVqTuHbHwLktqteKX5GqhqiR/j+Vh/xGIx+OTMA
         5KKw==
X-Gm-Message-State: AOJu0Yx1Wrprkpcf6b0Zujaxuz/l5pC4ljZ313I6+lB4uHw9yA2S1KvH
	8llaTm4ZNlF4eWyv38c5siQREo3i1gD95Q6i6THycLHXCVLVJ9ZU5fRhAg==
X-Google-Smtp-Source: AGHT+IE/xqzQ+nHdRb52aYgjfRsLc/+HQzKBD6U0YIcKjtYHUvrluorJL8ZuOUxpVAB8K4hwySTdPQ==
X-Received: by 2002:a4a:e501:0:b0:5c1:ebec:81fa with SMTP id 006d021491bc7-5c1ebec8fd8mr5932212eaf.4.1719257606038;
        Mon, 24 Jun 2024 12:33:26 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:25 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/13] qmi: Add dedicated service for qrtr
Date: Mon, 24 Jun 2024 14:32:54 -0500
Message-ID: <20240624193315.1164943-11-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/qmi.h |  3 ++
 2 files changed, 94 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 7fba86eb1e29..639c0c44b519 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2041,6 +2041,97 @@ bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type)
 	return __qrtr_service_info_find(node, type);
 }
 
+struct qrtr_service_family_dedicated {
+	struct service_family super;
+	struct qmi_transport transport;
+};
+
+static void qrtr_service_family_dedicated_free(struct service_family *family)
+{
+	struct qrtr_service_family_dedicated *dfamily =
+		l_container_of(family,
+				struct qrtr_service_family_dedicated, super);
+
+	qmi_transport_close(&dfamily->transport);
+	l_free(dfamily);
+}
+
+static bool qrtr_service_family_dedicated_rx(struct l_io *io, void *user_data)
+{
+	struct qrtr_service_family_dedicated *family = user_data;
+	struct debug_data *debug = &family->transport.debug;
+	const struct qmi_service_info *info = &family->super.info;
+	struct sockaddr_qrtr addr;
+	unsigned char buf[2048];
+	ssize_t bytes_read;
+	socklen_t addr_size;
+	int fd = l_io_get_fd(family->transport.io);
+
+	addr_size = sizeof(addr);
+	bytes_read = recvfrom(fd, buf, sizeof(buf), 0,
+				(struct sockaddr *) &addr, &addr_size);
+	DEBUG(debug, "fd %d Received %zd bytes from Node: %d Port: %d",
+			fd, bytes_read, addr.sq_node, addr.sq_port);
+
+	if (bytes_read < 0)
+		return true;
+
+	if (addr.sq_port != info->qrtr_port && addr.sq_node != info->qrtr_node)
+		return true;
+
+	l_util_hexdump(true, buf, bytes_read, debug->func, debug->user_data);
+	__qrtr_debug_msg(' ', buf, bytes_read, info->service_type, debug);
+	__rx_message(&family->transport, info->service_type, 0, buf);
+
+	return true;
+}
+
+struct qmi_service *qmi_qrtr_node_get_dedicated_service(
+						struct qmi_qrtr_node *node,
+						uint16_t type)
+{
+	struct qrtr_service_family_dedicated *family;
+	const struct qmi_service_info *info;
+	int fd;
+
+	if (!node)
+		return NULL;
+
+	if (type == QMI_SERVICE_CONTROL)
+		return NULL;
+
+	info = __qrtr_service_info_find(node, type);
+	if (!info)
+		return NULL;
+
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return NULL;
+
+	family = l_new(struct qrtr_service_family_dedicated, 1);
+
+	if (qmi_transport_open(&family->transport, fd, &qrtr_ops) < 0) {
+		close(fd);
+		l_free(family);
+		return NULL;
+	}
+
+	DEBUG(&node->debug, "Opening dedicated service for %u", type);
+	__service_family_init(&family->super, &family->transport,
+				next_id(&node->next_group_id), info, 0);
+	family->super.free_family = qrtr_service_family_dedicated_free;
+	l_hashmap_insert(family->transport.family_list,
+					L_UINT_TO_PTR(type), family);
+
+	l_io_set_read_handler(family->transport.io,
+					qrtr_service_family_dedicated_rx,
+					family, NULL);
+	memcpy(&family->transport.debug, &node->transport.debug,
+						sizeof(struct debug_data));
+
+	return service_create(&family->super);
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	return l_new(struct qmi_param, 1);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e61e9cc9e878..0e48313ebb64 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -100,6 +100,9 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 			void *user_data, qmi_destroy_func_t destroy);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 						uint32_t type);
+struct qmi_service *qmi_qrtr_node_get_dedicated_service(
+						struct qmi_qrtr_node *node,
+						uint16_t type);
 bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type);
 
 struct qmi_param;
-- 
2.45.0

