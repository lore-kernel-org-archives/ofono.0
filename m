Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C91AE0BE
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895119; cv=none; b=Ou7Y0zQBzjyoSLE3zkyLjdp902zDRmp75wPcBWGzM15QiVvAc39xagQG7gY4wpvY/3drvTVlVNZITb1LbKTmjChSoDlEcs85BVMhJLa5KCvTYr6DF6kNfN1L1WzlgVpjt6mNhe2xAJgE+yy9XgF5BBHZXFjB+1mKBOqAVj+vSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895119; c=relaxed/simple;
	bh=Y1PdZud7erIXoShijODcPVTJniAFQD+o57VgIzmdn1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/QKZD9sboC7HJtwRwLgtTPl1WyRTzEs+H8DCz0FM5bs+3toI5r5L/BIlkUWji7Ge+qNnG4siBB3YlwFufIhd4I4Ryz5mQ+X5cs/6sRd8T7dP9yZVqTqVwOA4QUgVHoXk/Lw0V2ny+LVMgsF9q5gP30Muhp0nvYFUnA5z1GcMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFRfUzjF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFRfUzjF"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d2472450d6so496758b6e.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895117; x=1719499917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=bFRfUzjFTbDjvPR4BGUiWzCaFaXpoetuS5BVw8NkdljV6cq2IoUsc6rsE+vcbBnoVy
         BA4OdVnO/hGfus+JYldZigkXXONx1sVxrOqq8tjGOAuVlyVQlzVneIhaM43vOZKKASoQ
         geFM1Xxsa1PUVl1KkkoX8epV5R12uxYs1T1oV+QobyG3rJ000eYgmnYgJdh5xJgnLhEX
         xImxcsuK1cSKlvZVFPUvf/cEkLbVU+UkhQXrDciBEcnWA0KDiM3BS9SgRhK/e8MPqxI9
         tUAPtjKvv3ATn6jq53zSJ8lUUZtsmYobo6jvQeCUYbKYustOa/BPME+uhqNnm9n75K35
         ezTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895117; x=1719499917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=bEmckAmzaHkTISFrHwZxAz2rl58mlh/sSvJ5J5iEVgWfHo8ry4AhPjIFE+bOO1nQ6H
         5Jwzqdtt3GWTot5AACYFRSUESshqq6MyYEXy9X7GQIlJF0lUG+Y19aLBmGC1Ji0+eybG
         gLYsJ6toOAaJ8DGKNo+9INfYqHr3Uoj397KY0GhguOs6FIkJ777mu/ogh25a8yQLn15x
         H1P+ixaC2FdAdwWHn19NlC+6/wM8b9ksCC3XFEq9XtktbDoTLCb82L1ROtIXjiDqSNoS
         7zf+pjdjCNN+LtX2Sa2iq0K1aj2g5rJgG88TtG+ilniUrucjoQTZgw7b6bAeadZFsY7e
         9C+w==
X-Gm-Message-State: AOJu0Yw3PqwUHZFSzTkiZocjeXd3Mb63Bzmzx05Ajuv1kjroQkQlFX4b
	LYz5VvPkJigx15x/YM3HojEYv3c1n0KqhFp2HyZF1WnAnaxGh2ehdSwHPQ==
X-Google-Smtp-Source: AGHT+IFs3Zt9U3A2XgS8Ot1BH+IjTTQf6GQahh1fDn7MmWGg7cQLpGk2JsotqNocyQx98rCoalcOSQ==
X-Received: by 2002:a05:6808:f0e:b0:3d5:2f8c:6bc with SMTP id 5614622812f47-3d52f8c0860mr881490b6e.7.1718895117168;
        Thu, 20 Jun 2024 07:51:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 09/33] udevng: Do not set DeviceProtocol
Date: Thu, 20 Jun 2024 09:50:56 -0500
Message-ID: <20240620145139.1135899-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute is no longer used by the gobi driver.
---
 plugins/udevng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5ef0bc253562..864f9c12b9c2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -252,7 +252,6 @@ static int setup_qmi_qmux(struct modem_info *modem,
 
 	ofono_modem_set_driver(modem->modem, "gobi");
 	ofono_modem_set_string(modem->modem, "Device", qmi->devnode);
-	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qmux");
 	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
 
 	ofono_modem_set_string(modem->modem, "Bus", "usb");
-- 
2.45.0

