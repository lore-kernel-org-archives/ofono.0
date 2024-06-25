Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA3174EE1
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333733; cv=none; b=ksGc+/C9bWzbf7sApZ0yYTd153RbzD+cvxWiBFDed5gCfzAvxgACaBNax+lTCJREPnzNKbtqlf7+9yMU+K2VJy7EbO2FMVt9SltQyZrqJOspiB/t8qY4jzUFeeVZLRPYduOahqhhOoVXv8Id5ks3r0ZXR8AhFtBlVrNGlxj3A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333733; c=relaxed/simple;
	bh=klw4aUAqr1SSW5HavJsfYv2XgInENxpmj73HNLuzZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQlon455VpF4SkJWvP4F6fUcs2PdMz7et4RUhwejzoylCLzT3pntQXf/PL6yAQIVhmja55yd3/IjDFdADkyXZQ5vAsBT+K5dXP28ZJdNM1zeqUW9O4ShzYNZkmlqqUKrYw+ISaU71FUFaTu5pEZ/vgdG+LRF5m26LdlZ8JpnQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW0y2bS6; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW0y2bS6"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c21a177affso282610eaf.2
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333731; x=1719938531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUJpeG5XySb/w5sbrmkfL9s3artarsq5RkfLny/9zbI=;
        b=jW0y2bS6PwbIX/Q4sEaU9RuhuX6Keb6V15arDRCWyDNg7Mbn9WcR5TcSXzH4trzKMQ
         avcZXpF+eVmhq8oGtiPnPX+Ff0RlrAyPImb/RS1AKihaR3kTms3LS7rKbdAoFTWyxgpg
         rTpSXBqPOhndpSJq5mbrhYvGYj+V50Y1931qzv3tJF3eg5qUQOB6Efm8Cm/Zju81LraH
         hL3Cl/KkJhri2qZxijJ+nv/rzf3BMpIUS3r6aQ/8+/y1XDcfiG+/kl4ah0sBH5exmK73
         TWVgQO/fvJhDSaXVboA/jYE3NVKeDHcqKw02YwldVIFsBvc/c7TN4CmAw8SvnR79mFWk
         u3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333731; x=1719938531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUJpeG5XySb/w5sbrmkfL9s3artarsq5RkfLny/9zbI=;
        b=JaW2F9wynf7ngO/PQVVHScTDUT3ehlDvVRwoZ4JEDHuOa0Uyb+q0jmPj5rYu1qFA4A
         /h9RUkU/lzVDG5zagFEUHmn5kgOR1EMi4ydwc2b6k0Ciy1S4RiKXPiHMF3D80eUgEjeD
         3QND8DOisiSgjH/wvoxXYGEOHkqZjnkGSR6W8r1nzNZCK+ZcL9mXOKR0vXKB8dR0WAM1
         H5kPjLGl6Otpoh+o1SHWv/Np9KHJ0Bl9jSyNyQaPya7kkPIDT5ObVQA3Cux4TtjqDJwI
         qjImB0rWJZd/BajjmMIt331zwSaQLNoVvkv9umObvprd22F6Z1+zuU3FoqciZS6zBPXt
         whig==
X-Gm-Message-State: AOJu0YyFsF4MzGZFMTTxBNBZtKk1JwGV29acnAh3tgHHDploNQ5WVHED
	QRNU/pVR8F4CurjUKdYGEFdeytoZiRDir4yV2rQolDnq1CjiMja81GV1Xw==
X-Google-Smtp-Source: AGHT+IFk9jdkE7JQRcnbu1OYQVD1We+keOFqbkPf9k/o6+aLF2Xt/n1dmtmRt9fCkNpiCDCupFA/Ww==
X-Received: by 2002:a4a:6249:0:b0:5bb:1b9d:24d7 with SMTP id 006d021491bc7-5c1ebb1d285mr8755773eaf.6.1719333730661;
        Tue, 25 Jun 2024 09:42:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:10 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/14] qmi: Add dedicated service for qrtr
Date: Tue, 25 Jun 2024 11:41:47 -0500
Message-ID: <20240625164158.1170937-11-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/qmi.h |  3 ++
 2 files changed, 94 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5720218072bc..24d2ff8075fe 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2039,6 +2039,97 @@ bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type)
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

