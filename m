Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA6174EE2
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333733; cv=none; b=qFn24rzzD2ua+gVVeVUr9KCVr8NpycMj0LNDrcu4f/yb52y9BbRZXmOctFmDgj9NK6bInyhYHbFP5rz2ti56x2aqPw117C3o527+Hx3N1z9JjnGESQYd8i9w92PlluG3aEM/E1zmAzQoP335swu00ZBBhy7hj/sAnetDqHI2huQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333733; c=relaxed/simple;
	bh=jRPBM5xekjHWFqiU8Ck/lFlEELvji27XV0Yh7BxYJOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDdVj2EcnCs/nh5jR27Kzj511l4vnWu3a4CNBYlAA6ERg/ruDfwobdsI6TJpw8ZhJLbn5WNqed6wgu/LKss6p7UGpHXFaE/adb1HjTs+7+F3tQHb3hVLg6U0mivRqTV0be/R4Z1uVQTWjn+OaJYW/HhTytXfK8vRvAoptSebTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt2s3k/6; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt2s3k/6"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c21c5eb371so233691eaf.1
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333731; x=1719938531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r2ayXQES330bJ9gbaY8g0WCybk0+7O5CYFHOwOpFnk=;
        b=Zt2s3k/6SIykGnH5ULHwJ9+UM8VTUqcMWkaeLGwnbndimGg5nac5EergQIJndupSb8
         chFFiulWNmYMrr8qPptyRWuXUjlvXgndBdNFzFk/FAT0fNX/Feesxkr2Eod2c+Shj/uz
         +TzpmGClRjDT1lwPctH047j37oclZUaApp/zPdaBBYgNk3Lsn7Mq2vgvNLkLdKXAvlZ8
         a0SS/6AA1VRRTSMZC28VnXfkq2mq70zmWov71eeo24ofE3D71fqY3HsJlZYTfFucScms
         BMz1Yq4/A3saY0zKVKjkWvbjDoqidcekV8H/7J9uwXtBSpUJiyI476q9lW3XlgMsdm9s
         25iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333731; x=1719938531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r2ayXQES330bJ9gbaY8g0WCybk0+7O5CYFHOwOpFnk=;
        b=nxqtBH5rI2RGOqEWDOowBCSeZ+yRmrQ9oj90qps8qaEDzkuY+cn+ZbyrvVRJzZvqr4
         UGA9luRY8XLCV9dzkMxB4suCJ6B2H/2DSCsVPI60y8OLQ1zUfkbCEhEel7gMLBrDfrtO
         3hmDGI0o9E74jb/wIkiOB045BfbHrNf+okbF3vYMvuBQTUDKbaRu0wYGVXxgANZ9N5hp
         jLXMhQFB7kXTCf3z5IlYSkmy58dys4DRG73Oy9eIZizjNhK12POmSu6IXCqUrpNJEf8P
         Zc7RwikYuCZS0TTtmUBxDdjKw1asGOox/OcW6vcKsf6aPuDSHmtRa5wRqze3JVmAlKym
         RHGQ==
X-Gm-Message-State: AOJu0YySiTTKRCjxoDPaJxz1H3O7nJztDtuaTNVul6z61V2MFaxxzSPM
	3vZeVr/YyaxBdRS6ZiKpnZEYPpck4u0Tb0F+CIUmFwrtAdHEJ4qEfTYkEg==
X-Google-Smtp-Source: AGHT+IFE45Dlu8xVmSaEpbKjFQ7DasBcxqil2apIy8pvne3L6AGvqbM4x2iq39URHJXB6KB54+3r8A==
X-Received: by 2002:a4a:8005:0:b0:5ba:e995:3f00 with SMTP id 006d021491bc7-5c1eec0b5d2mr8695347eaf.1.1719333731303;
        Tue, 25 Jun 2024 09:42:11 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:11 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/14] qmi: debug print fd that QRTR data was received on
Date: Tue, 25 Jun 2024 11:41:48 -0500
Message-ID: <20240625164158.1170937-12-denkenz@gmail.com>
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

Similarly to qrtr_service_family_dedicated_rx(), output the fd for the
rx operation.
---
 drivers/qmimodem/qmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 24d2ff8075fe..b8f46a5b4a0e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1848,13 +1848,13 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	unsigned char buf[2048];
 	ssize_t bytes_read;
 	socklen_t addr_size;
+	int fd = l_io_get_fd(qrtr->transport.io);
 
 	addr_size = sizeof(addr);
-	bytes_read = recvfrom(l_io_get_fd(qrtr->transport.io),
-				buf, sizeof(buf), 0,
+	bytes_read = recvfrom(fd, buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DEBUG(debug, "Received %zd bytes from Node: %d Port: %d",
-			bytes_read, addr.sq_node, addr.sq_port);
+	DEBUG(debug, "fd %d Received %zd bytes from Node: %d Port: %d",
+			fd, bytes_read, addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
 		return true;
-- 
2.45.0

