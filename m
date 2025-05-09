Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064B25EFBF
	for <ofono@lists.linux.dev>; Fri,  9 May 2025 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820897; cv=none; b=ayLEFhdlyXNJ14uaeuTVpWGrPLBEd1xaMev03wfKyuAVFvPZAMtNdqRf8VJWYs/xQU1j93oeqpI2x+GW1mQlmXnyEWz2hyV81RbYyXjuuOt4sIlF+QjUPTsfZnskIU/Hx+84jOsQAL3tDVOnxz7qUZHdArIWfm5FOr0+oR9SFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820897; c=relaxed/simple;
	bh=JiCFhbl9HSrp4ol/1jlxrP1sF2g97ZqgiZ8Vd6agC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sfnudbw0ssmJCp2qwLUyOWKKKb6+icmp4vr02vPBDxAB6yejOQloK9irkU6vWA7ipcLSYQ7SciZFRHkeu8h3wM8qG43k6T2M09SDOsYO/5PoivZz3jlsd3TomVPB8n/DvnGbCvON9iuP7Sn7UDvOsrva5/KuW+Z91bhkx2KuXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxWiTN4H; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxWiTN4H"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c16e658f4so1460797a34.1
        for <ofono@lists.linux.dev>; Fri, 09 May 2025 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820895; x=1747425695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2povDWlF9jcYBn8poZfwI2k+Y9Bzr1WTSUZmQF6Rrs=;
        b=IxWiTN4HgGuFyu4UBndto9TMzO/WQrwYE6xYKFJjG5uzFrljPBqTNm32BNMCSTGvHV
         XDqEjMDVv1kbV6HGHdfl7A5Ot+QfsIeVyxTe7VvJCIJrXA/jSgZRJC/XXAG4u+MB61JH
         G86pQXlRC1vBnCQ16GfgicQCf9R8QWDyZoyTtD7MJy3cY5MrGY5wFuI36Lgyakb6v9UM
         jsloWW7IvtFJs3U6cxgak+CZg9P1O1Qnja0033ZKml6c0CgC4adzhvosGFr+J1ggPyUG
         rYij9C+LJILMjz/JUmzewRQdXaIvwEgSORHF80Iw+pHAULCT8wjte5LnHimf0ye2wa5o
         BQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820895; x=1747425695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2povDWlF9jcYBn8poZfwI2k+Y9Bzr1WTSUZmQF6Rrs=;
        b=mITEiI8BiIZmspxIlcOg0J33U1alMS643piLbmwB6sSaFNyYbwyHfI39B2Dcp86gsb
         ucs4QnRfn8QC8lsZKgbtG03zF9SxRzsnDNOn/6ZnSAPm7IwJA3ptgCFCHAJ88UfBFbps
         BZ26a5F2qhECp1epXG2QXJDCYnRNpcOrdEKDq42DDBMZfM+Y0FM2wExA6lA0IrvwEQwD
         qbdF6aRtgvtX/KktXSbz8YKJiZJVVn8aYVqJJAUmZDbUfT8/DbdjUvk/XN9BT8BkcCrr
         DpYLeSj5fD7Rlzs/XSXagGU2gx1rayu8Lkjf1x5EFhiyOfAMAbOIH+o/ckA9eIZDTimM
         //iw==
X-Gm-Message-State: AOJu0Yx0d0rSWEjO+ye4FeSaS9Wl6A5Ey8CiF5M18dy+TTrYSbemhWtC
	uY5T9yrtVjc7xEPqrnAiB2zUmgknH+XCIQbClhfI+nmQHhh59rWsUdGZjQ==
X-Gm-Gg: ASbGncsFZ8zb82bTpklHD8UftM5oEKJOKuZG/dFhuIzNViG7bYgZbPP5dc3gM0bhOUc
	3bUj4xMkgyjhYN49UdDUcvNChoSkQKVnnMFuJWX8dM/lIoYZlNhXZhR8r0fwEfmbemtDemYnn63
	PnxXjHPlGJC0WWFfdEbjtPGpcOnfj1yDNExqOxycc2PvB49C2OOvU1pNmE+68q4MCQkqsdEoj5u
	eloDJaZoHR/nvVZwEXbrV99DynKzuPyixaA0X5IvxS63M3MrwTUY3RvKGmlYBIi9LumvcVw8ZCE
	CC8Yq+9cAZzdtOQFT7FeUdnPw8etP+Hp4IOQLzoLSnCdFw5+yrBqkDdRhl6fuEsea4c5b3BQgHe
	EUQIpSBoUp2UPmGRO4EvD9T5W6A==
X-Google-Smtp-Source: AGHT+IFGSnDBLGP71FCf0IDq+Ib7z25i5A0tqi+BjL72Xk+w9evo774TjgxskNQm0jN0+Qbab+5Ikw==
X-Received: by 2002:a05:6830:378a:b0:72c:4032:76f with SMTP id 46e09a7af769-732269c9c27mr4004544a34.12.1746820894854;
        Fri, 09 May 2025 13:01:34 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b2e5asm667326a34.19.2025.05.09.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:01:34 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/5] udevng: mhi: Collect WWAN net devices as well
Date: Fri,  9 May 2025 15:01:09 -0500
Message-ID: <20250509200131.42020-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509200131.42020-1-denkenz@gmail.com>
References: <20250509200131.42020-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

net devices that are part of the WWAN subsystem should be categorized as
part of the MHI device as well.  This is relevant for MHI devices that
operate in MBIM mode.  For such devices, the netdev has an intermediate
parent (the wwan device) instead of being parented directly to the MHI
subsystem device.

│ │ │ │ └─mhi0
│ │ │ │   ┆ P: /devices/pci0000:00/...
│ │ │ │   ┆ M: mhi0
│ │ │ │   ┆ R: 0
│ │ │ │   ┆ J: +mhi:mhi0
│ │ │ │   ┆ U: mhi
│ │ │ │   ┆ E: DEVPATH=/devices/pci0000:00/...
│ │ │ │   ┆ E: SUBSYSTEM=mhi
│ │ │ │   ┆ E: MODALIAS=mhi:mhi0
...
│ │ │ │   └─wwan/wwan0
│ │ │ │     ┆ P: /devices/pci0000:00/...
│ │ │ │     ┆ M: wwan0
│ │ │ │     ┆ R: 0
│ │ │ │     ┆ J: +wwan:wwan0
│ │ │ │     ┆ U: wwan
│ │ │ │     ┆ T: wwan_dev
│ │ │ │     ┆ E: DEVPATH=/devices/pci0000:00/...
│ │ │ │     ┆ E: SUBSYSTEM=wwan
│ │ │ │     ┆ E: DEVTYPE=wwan_dev
│ │ │ │     ├─net/wwan0
│ │ │ │     │ ┆ P: /devices/pci0000:00/...
│ │ │ │     │ ┆ M: wwan0
│ │ │ │     │ ┆ R: 0
│ │ │ │     │ ┆ J: n3
│ │ │ │     │ ┆ U: net
│ │ │ │     │ ┆ T: wwan
│ │ │ │     │ ┆ I: 3
│ │ │ │     │ ┆ E: DEVPATH=/devices/pci0000:00/...
│ │ │ │     │ ┆ E: SUBSYSTEM=net
│ │ │ │     │ ┆ E: DEVTYPE=wwan
│ │ │ │     │ ┆ E: INTERFACE=wwan0
│ │ │ │     │ ┆ E: IFINDEX=3
---
 plugins/udevng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 38de3df0f3c3..503c262abbff 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2397,8 +2397,9 @@ static void check_net_device(struct udev_device *device)
 	const char *iflink;
 	struct udev_device *parent;
 
-	parent = udev_device_get_parent(device);
-	if (parent && l_streq0(udev_device_get_subsystem(parent), "mhi")) {
+	parent = udev_device_get_parent_with_subsystem_devtype(device,
+								"mhi", NULL);
+	if (parent) {
 		parent = udev_device_get_parent_with_subsystem_devtype(device,
 								"pci", NULL);
 		if (parent)
-- 
2.48.1

