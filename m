Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6314290
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054506; cv=none; b=o5Xb7ESf5jWtmgZaB0F9oNYggqHvknv0M53WzMajEPVefUGz+3epiIDYYOGjlHCJPkUcWlvluBzydnR225Sg3dvcrOGvg2WdgzK6g5kXy2X9xgGhIBVow4k298B7MVARgEQZw354elfwn7/X60OmkDimFBi/+9suNU3ZRxDIqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054506; c=relaxed/simple;
	bh=2284rGfhub7VXV9Fnyl6Tvia/sSkC3bsRhSWEQciCBk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rfwB8L9gdtTPFbIAohdj44IptROZiA7OLubmdEaDtZ//GN8jymYo3mKTxEH6JxEFJWzRDw94mxS53Hemu+5MFja42mmsUzZUOLIQtRCyvBcg8qEY3RvtneKGDe4J5Y2apg3gYCBUuAuQ2ek0As9UBPhtsOzI9XKD6WDE2pn63zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0eLtSvv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0eLtSvv"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a62614b9ae1so50328766b.0
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717054503; x=1717659303; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZcFjeiQu2jif0XN7GFhUAeVWi5in2dcurYyQoLG4dI=;
        b=C0eLtSvva2st+qqZJAUHdt5g6IrhesJokkOwo17jbKaFauUHkX5vSuhof4eFSD4rrH
         HYDafcxNwcOH9htFnFsWEi7o7qC1+to834AcQP+RJAZ/oLMy93C4Btlwc59gzSvBf3wT
         vfuf6Jv3Rc2yyRstV2dWb0ySwI9FrX6Ja9Z7cC93Bj8vPYTZ4QP3gvPNHCkRiE4wFnLe
         hX3wAsjmfqaNyzTS57IThG6CxZK6rJc0hTQ37Fb6we0v6E4VwQu2aur1iqVxiEECYxlq
         g6Jse0eAVF+eKOlkx9sj54PRPKu6pYN8PA5dCIsvCdoYw7BNBjCO5oOMa4ATMEqKLmjB
         cRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717054503; x=1717659303;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZcFjeiQu2jif0XN7GFhUAeVWi5in2dcurYyQoLG4dI=;
        b=EqnxEoZrCpL+EowFUL7m9Pe3ZMi8T1CIhURlOxzOfWaNzBGMtvTG3WkbdTO5AUvHB3
         ehw8NOv7wVbLaUn0Dfum5RjKWk7VlTr/oHvXurqrXdqTi2rD4ROUQvImCqQM1kjjsohR
         ziTwJmhLyPBqtJAi1kB2ckfKudhha5J1ahfpr2Jzj25/OvbnSDtZwViK8LYN3VuxQ0rI
         ACKeQR//bbkhdXhXhyQLu6Kd4HP8ZOQf6fUqVtt71zyvfSonl5W2V6SMNGG6Sns15M47
         dTDU9boXYLFYb3GGlUm4QPBaEGRp1SECct76BQ0Pe/KgcVHnR8+vEa3falEpF4HxXo9H
         I0ug==
X-Gm-Message-State: AOJu0YxSU0pQKYLj2PX5xhWYZmlzeehQ6c4y0Fan+UFVkdO6cQB354XK
	dtOwnNhARoxt8PV+ci2jbLLm4dkxZHrT1Cc8/Ju7C9SMNKgBg91dBYpozQ==
X-Google-Smtp-Source: AGHT+IEEenCFysIt7mEJZT1lvpASLaCxABiUb15MpZn9T01jwnCvd0cgWlzKmqFNc9yscx9IqKUuqw==
X-Received: by 2002:a17:906:2dc3:b0:a61:c462:c612 with SMTP id a640c23a62f3a-a65e924f986mr76610466b.53.1717054503493;
        Thu, 30 May 2024 00:35:03 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda8bbesm792815566b.221.2024.05.30.00.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 00:35:03 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] udevng: fix tty subsystem device on usb bus detection
Date: Thu, 30 May 2024 10:34:11 +0300
Message-Id: <1717054451-3185-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d3ce3d5..708ad80 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2527,6 +2527,8 @@ static void check_device(struct udev_device *device)
 		check_wwan_device(device);
 	else if (l_streq0(subsystem, "mhi"))
 		check_mhi_device(device);
+	else if (l_streq0(bus, "usb"))
+		check_usb_device(device);
 	else
 		add_serial_device(device);
 }
-- 
1.9.1

