Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39881D2B37
	for <ofono@lists.linux.dev>; Sat, 26 Oct 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943632; cv=none; b=Ai5jwvfQa5sNWZBxxRGEm23bWeIVbNfU3PmAZGovIY+u8eHEAHFk+6Y9+VSAd9w+fbts6SUbKV+t4zyMz3sR55Xqc3vmedQXnCGEHpYVQ+d/lvTl7ZlQ/0gBzIOaNNjqcLxdLABhA4vWWP5QkKkS0uh26+FoWF4pydQQChRnBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943632; c=relaxed/simple;
	bh=51lwKIL4ofxFaKOOmJ9HMJ6APGgoBZev9ILzWF7HcN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkOqV0Pzrb1jVFOx2r3sdhEffCaHZiCwCGv4mNgGJ5GR4O3hw+a/ySBSnynL3LYGzqZ0KXQ2Db4mUgDausbAY1Sg5b7DIfiG8xXVqPvJyuUCX4yiDt++vC3zFo+gEXol+tYkudE/Xsr9nzv+FOl2syK7jeI1ZBpUhlTX9OtHkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbINmY6U; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbINmY6U"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a4031f69fso386737866b.0
        for <ofono@lists.linux.dev>; Sat, 26 Oct 2024 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729943629; x=1730548429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHtaTbddKrMWdealnuzI9US+w2zF3VpzTQfBy8J7dEM=;
        b=LbINmY6ULM2GcV8lvO/vV5zr/iC2BSrt9EpeQjJcrGfqerq+pbzJa5baDw8msjsgG1
         nDj4VoAVUDpfK/eVmHyfMoJRBDJIgVdBFYHlUniEy1fXlSNtrA+gnMVz0dvVfzAci96G
         Z1RP1JxWgxASTyGIW5lxPyVsIxJA3UbrqtL6OpBoxaBnNWvEsLUefCc7pfiKCtW1BbxJ
         RTKe4JVMDrZtTAOgY+NGwqQg6f+332NlLEv3tXRmE4t8VEEHi1PZ4RsTDFxsIKTVbrAE
         Vok2IXpqWbeYbTg66TLwBtjEfLCAL8ur0LPnd+iMiNh0k10RONC7ZMO4TkFo+nT2GNrt
         hn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729943629; x=1730548429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHtaTbddKrMWdealnuzI9US+w2zF3VpzTQfBy8J7dEM=;
        b=QLO8G2FN3wRrGdBRgBGRHqjQjVIO818/m8ok9l5FCRMY8vLhK+8xIIg/xMAxsuNP2E
         Kn1NuehxoGbNvIMtR0B8H1DhwDdPAynrEutdDOaBc+qD96EeKvLAZy5EVJMuA/E8Iwwu
         C+a0pft77y2/Eil6ynYiJbpdMiPksdnp1iOuuMOWpSpb/+myOEgVZxqiIWrcTXIc1Uau
         7lzIKQPcmiZ+ato62C+jBd/v3dad0OusfxOAw4f7AK0a6AQxTcVimJ558QRjWMkACA5h
         vdaeAVADk8NOc8i/rINf0xqsAcJ+TSSA3WDSuMyVSIOo0GRQW/7khroYyhxz1SyawJOH
         OUUA==
X-Gm-Message-State: AOJu0Yy9C8JVtUqJA8C1hWTeOg7XmVwpMznYHF7h5LhLlsUt2+c0oD06
	6pbrIdD3onKM68D7ygLeButz3So5cGpQJee0u7EwewLeg0pI/8wvfDEIzA==
X-Google-Smtp-Source: AGHT+IFI82Wt+274aFMbzu0ECAoB4Njp6hf0lWFKGJlRlhi6HoX5K/AW8JMTveiAfiFDJkD36+pRPA==
X-Received: by 2002:a17:907:9617:b0:a99:5466:2556 with SMTP id a640c23a62f3a-a9de61a2218mr149344266b.61.1729943628670;
        Sat, 26 Oct 2024 04:53:48 -0700 (PDT)
Received: from tpt440p.. ([41.84.226.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086c1esm167366866b.213.2024.10.26.04.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 04:53:47 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] udevng: restore support for phonet modems
Date: Sat, 26 Oct 2024 13:53:11 +0200
Message-ID: <20241026115324.211317-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 296347f8a4f1 ("udevng: Detect embedded qmi QRTR modems") introduced
a constraint that only rmnet_* modems are valid "net" subsystem devices, thus
breaking phonet modems, which are located in that subsystem as well.

    P: /devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/ssi-protocol/net/phonet0
    E: DEVPATH=/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/ssi-protocol/net/phonet0
    E: INTERFACE=phonet0
    E: OFONO_DRIVER=n900
    E: OFONO_ISI_ADDRESS=108
    E: SUBSYSTEM=net

Fix the regression by specifically checking for phonet inside
check_net_device().

Fixes: 296347f8a4f1 ("udevng: Detect embedded qmi QRTR modems")
---
 plugins/udevng.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index f4266f39..f34cdcb7 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2455,6 +2455,10 @@ static void check_net_device(struct udev_device *device)
 	}
 
 	name = udev_device_get_sysname(device);
+	if (l_str_has_prefix(name, "phonet")) {
+		add_serial_device(device);
+		return;
+	}
 	if (!l_str_has_prefix(name, "rmnet_"))
 		return;
 
-- 
2.45.2

