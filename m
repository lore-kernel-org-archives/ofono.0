Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E019EED7
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257609; cv=none; b=SpXQ2Rkk6YRTiS+VbWh+Nna5GYB9DUpA/bzPaFD+ZndGiTXuOvdb1DGrEoh+sa3VWO4u9q6FZlFXqTrGLqPtP2lDJP8WjksB2693epmzfhtW/nqsJSfPLsvLEuEcQn17+xhO87bIzL865yg+EG6dhSzNsGmyssMggWik4faxdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257609; c=relaxed/simple;
	bh=YTsHy/XXqQ4v/EyfUDG+UktLA74VYIXgtt7ICehFgXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5DLgareXkHiGpDZcWQvhLHFI7A3XOqs1OGSlDtyvJ/jD1LHODOuqYVEviSlwS/m+iXXdCziWr/otTY+NStewyhLTq4PHoY6DDAGeue8WoCuxE3YUSkqgj+5fFgYfBt74f4g0pQC9z7Q4aXv0RAsjAZ1WNhKmbMdSnw80pP0cDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b27BD8Ik; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b27BD8Ik"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b970a97e8eso2564924eaf.1
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257607; x=1719862407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHMXmRqIR3vrTAk2uMbRVffF80cd0U6xix7wu3WybSk=;
        b=b27BD8IkBva6h7WiT07uRWWICu0bX1lPx9nA0qKhYZueENpWXrjnYkrXMO0Tkj2Z6J
         hhoK4Cdk1HgjaD0Vhz4AKFKqVvdQuZGwzaEN39LvSCs1ZVoK7MqbFMq2T6q3pMW8xF2L
         zxZFdvZYMWyYbI5CPnP4gKlA4ngAJT2tHnLjRrGYbyK1IrQCFr9K+2FlB4dHofECtiew
         qV+WPqh97k+6ck9xAFEJ0sAJPe6uRbrEtV320OrwTH3rKeJ1/Iz+a/FKXPK2aHlB32+q
         C6RVm2odEsnfdHN+7c8NuSh5C93KVPnogKOXMERDJPIW2paq9MkOBhbKITNa3ylQnG37
         wO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257607; x=1719862407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHMXmRqIR3vrTAk2uMbRVffF80cd0U6xix7wu3WybSk=;
        b=PdoU4tdTH98hP1jo6XyxIy7Sga59GbkN3bNmu2SqusQMifCEJhgkBX74U9wE8ld7lN
         h/dJG0Se3zXCj9MxARVmuxkvsfx+Q5MqDgmO1JnhNQ54ja4FVOANCi4Q3srkFbtvZD+o
         4X4xnyAH/PQfMKyKwSwYDIjS58Nfv5SNHXKSZulmKCgeGwDglqQ8Fk6AAE2AtTTh2O7V
         f8bCysaZ4VuM+FSi9zwR4wcC/Qlz1OLVRaoXGhIqkN4iwBCGtaZ3ULLJu12NiPYhdEG9
         zWohY1II94WA5a4EeHhq36iihNialTPTVTZfB4a40V1tORP/icptGaPCgVKk+5rnU6HG
         AmLw==
X-Gm-Message-State: AOJu0YyaND5x3z6xe3LMx04IDTjAHINcpsYtRSyFZ3ypUngpwKk7v22K
	iJEtzPxUluP8kk9VHwR545CzoV//LxO35tXhIAlbw29lQDLwJbskHNFKzw==
X-Google-Smtp-Source: AGHT+IGd6qb3rm9Ll36tQKjakhBuI32/id58ibvwN1m++jeuC4MhxCZReF3wAtSNROKXAo1KQ9gByQ==
X-Received: by 2002:a4a:2447:0:b0:5ba:e995:3efa with SMTP id 006d021491bc7-5c1eb9dc263mr6210735eaf.1.1719257606792;
        Mon, 24 Jun 2024 12:33:26 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:26 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/13] qmi: debug print fd that QRTR data was received on
Date: Mon, 24 Jun 2024 14:32:55 -0500
Message-ID: <20240624193315.1164943-12-denkenz@gmail.com>
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

Similarly to qrtr_service_family_dedicated_rx(), output the fd for the
rx operation.
---
 drivers/qmimodem/qmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 639c0c44b519..7beae9cf588d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1850,13 +1850,13 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
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

