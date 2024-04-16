Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915C1304B1
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280496; cv=none; b=tmqwZ+4BLDnOjvlIBuBeE1EFp+Pa6BA7hVRpRC2MUDwirTV60kM2D6jWtOFtlolP5m88YxilB2WXOI+cb2qVKSlLZgOwW/94dJ9KD+v/4kChN2ZPCzU6wBQDC3HAZgWVNXLsPLzmpba8dr1eTsMm/Y11sSSK6EucIJKPF/7ymKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280496; c=relaxed/simple;
	bh=9flTpwrrmBlVJXK1xudSUA3Uhl1V6dC+PUekkMrZgaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3fRfE08/V2GbEHFJj7C1HN92Udp5731hzGbF9KeGfiE/mY1cd60sNNOwmDoQD+JIX8Ysak3794FdzlHHT9u5P6fkptvJJMvMV54v5/lSbBM8SXEzIxlIwsGJrx48tMgKZQ9w8UnEffWKTjTvECO5MrXDFzMVR5ug+8Ds72Sivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZo5eXUo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZo5eXUo"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70ef25e19so1140920b6e.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280494; x=1713885294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cvAQegEJEx498SvEhyvDBsfy9IimfKb65ZBzIj8dKU=;
        b=EZo5eXUo/g5gRMV9C7gDQzWNyQFo7dY4bBzPJoRRHokzSuD47kD0floo4wpoam7EOh
         HZcuTCyZ4zxentC4VooreZzE0D57FWRk1pVWM6utsTws4BbJI4ayozNmvn0VI0q58BcN
         n569Cv3pa89ZYRL52MytXmT3YpNJcvFF8Ad6hOo+3gfIOb8JOhouIAWFybu+kTgU6luT
         Kn0StuPs0oZgyPbIAB5Uz+ZATVvPVFQZqwJaq2JYIz6AlHteAG5CVWP57ciLAj98r/No
         ZSTZm7papy/q1M+Izfe8LknqaUw6esBmGNuH1QnoAgJvtPSds64ofhAA+gfKiHCAQkS3
         XqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280494; x=1713885294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cvAQegEJEx498SvEhyvDBsfy9IimfKb65ZBzIj8dKU=;
        b=rrtN+8JS+aT/i4IKsK81/MLn7IROA451RY9eTaBvvRzHtWZpu8EoPulBDW07wKZFGw
         Ir+GGSKEVUN5Bcn9lCRiRRGe1JoYWWZDcdgVYKR3UArNbESpwsWUiJAAw9pExsUI33vu
         C7jA2RSzN0rlll1GMD0ybb/IVZOS5hh8jLV+MPS27OzD8qiNRAeErqMRx4Ol05klrsRZ
         9iEjhzbvYkRyDkW7fOJ8ByDJyQPvnFIlE/+cYFeBhlB/xwwqjISdSrQsjE7TASs3kT9T
         IwXX/8mkqIWZ7f9Lm/sA1j2H/rkE3mXUqlvlKiqECU6bBKlx7F3DyBakJmq5TikV9FXN
         ub5g==
X-Gm-Message-State: AOJu0YwGGVwK23oPxfLD0CEDhLY6wrofCFz/SVClSznEoS+ohhnCP6NE
	LbgcuzQtrbuNSHgAXAb3pjuP2X8i27X+en8FsICq40GaSq4ZtU8NeN+92g==
X-Google-Smtp-Source: AGHT+IHz+yXtc2U4zWE8VEeo16KJb1cxrtCUElgPu8WsdN10EK50pYfi1DIr+kgxi/LXoivlmnwThw==
X-Received: by 2002:a05:6808:274a:b0:3c7:960:b9e7 with SMTP id eh10-20020a056808274a00b003c70960b9e7mr8164179oib.19.1713280494476;
        Tue, 16 Apr 2024 08:14:54 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/7] qmi: gprs-context: Remove single-use structure definition
Date: Tue, 16 Apr 2024 10:14:33 -0500
Message-ID: <20240416151448.3359644-6-denkenz@gmail.com>
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

This structure is defined in wds.h but only used once inside
packet_status_notify().  It is unlikely to be used elsewhere since this
TLV is specific to the connection status indication.  Define/declare
this structure directly in the handler instead.
---
 drivers/qmimodem/gprs-context.c | 5 ++++-
 drivers/qmimodem/wds.h          | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 14da16046f2a..b1fdfc74cc34 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -48,7 +48,10 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 	static const uint8_t RESULT_IP_FAMILY = 0x12;
 	struct ofono_gprs_context *gc = user_data;
 	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
-	const struct qmi_wds_notify_conn_status *status;
+	const struct {
+		uint8_t status;
+		uint8_t reconf;
+	} __attribute__((__packed__)) *status;
 	uint16_t len;
 	uint8_t ip_family;
 
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 0cfbd9802531..3c9b534c1f82 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -32,12 +32,6 @@ enum qmi_wds_authentication {
 	QMI_WDS_AUTHENTICATION_CHAP	= 0x2,
 };
 
-/* Packet data connection status indication */
-struct qmi_wds_notify_conn_status {
-	uint8_t status;
-	uint8_t reconf;
-} __attribute__((__packed__));
-
 enum qmi_wds_connection_status {
 	QMI_WDS_CONNECTION_STATUS_DISCONNECTED =	0x01,
 	QMI_WDS_CONNECTION_STATUS_CONNECTED =		0x02,
-- 
2.44.0

