Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068178;
	b=RIxwE8g8SMW7UhvUr9/j6KcCFu9I47JKCda/l8ZOg2AQiNq9s9B+nUmfj9oZXb1LDOTT
	 B0EE0wTFtFk+8/Yf/DwYm0qsHat7A3mBNQUgT8WmNedXblGZmUE87twjfSwCewv5aIK9Z
	 pHSRER/SkkB16eEWmvrhldnv89FGuf4ekZRu1/LQz4fCmCouRql6nroQ9tUEAT9DmNEeE
	 K0VgxWzW/P+lZBPnl58AYi/QOYPL6Jp5n2oqAXGZZXo9+hTYf+VmRXdFHQfO9WfDwmMOB
	 O0x+k4i9anzww5/0fH+Wq/5UkRfKJqf6SdLxKFdkFGDLeYM/Aygv6HRdfFYbTv8rz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7oar9k0pNx1SrA0u/o1HIuV/EpkZpf38+Q0v6YfcR/M=;
	b=bSzMPrSSK+Kgu9WpJ32PX8rgb8Pd3N3K23/+jbEMFWqwa/G+kAD9kISI4h+Yw7lLH06V
	 ySVHNRUW/KZG8JqFYQglRxBcgIuQeMPlUhy9GU1Q+QyR/S1vD8LNHTAudS+6KVtgJrulL
	 ccj5w0LRtonSd68ldG9EQXE1yRm6TvIJoVegNUrh7HLHJaLxQbpAVL1y/xp+f7o34r+hA
	 7+Fp0sZrOb7CVcDYTR7pRjD5XUZeHN5v0WGW7GlBwAsBO62js0Io7RIOkmKIJiVrX+ECr
	 pN9bFR0cnCB9jza5AYaxfs8wYE2dR8L6w5cWzTFEmOKZ7Zs412UPM30w5IUeOPE7ARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmkHl9qf;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94997606A33C
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94997606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmkHl9qf
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso952332f8f.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068176; x=1794672976; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7oar9k0pNx1SrA0u/o1HIuV/EpkZpf38+Q0v6YfcR/M=;
        b=XmkHl9qfwKRT98ySoiVyb7ukfV7GhGi9hA4q5k7zSBjBNDV6872dXa5CcFGYQvMPOX
         yCV/wGnhBmueGzYOtylvbkJWEXJygajICrx94DfGaXjkYxFxjICGpHFZQmXyBlASrOt2
         mWJQAZK/njyTZE+UBKfGRwZ1MUTCiSf4QbalIwNiUYSEz+WCbcHsYg4hLl+TrRTlFp2c
         9V9Bh6qpE14w2NoEv+Q2ymndvIJRJ0mhJOO1mOtcA5xJ/O54k6/x5imAAmuBRi0moVho
         cgWhD+pwdHLByOEcrxZl9g62L4ntqm2vRbhNR8eYBmiKlM6cvfrogelrNQhZHCBxTosD
         za9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068176; x=1794672976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7oar9k0pNx1SrA0u/o1HIuV/EpkZpf38+Q0v6YfcR/M=;
        b=AkmYzL7nyijKow+I4up4ozy5kXCEQslE5YfxJzoMNIBMgPAC0SvlDOgLdy4KMX9PrT
         nsnQI7+C8d8C0RChPxDASTE7N1QxRX6+UN81LCopu8qJmakRATCMay78n/MTBGJsOxQ6
         7HWycqtuOEknnV1CkDy/RbA1SKBk2mnGD7bcjmMKcOVXMAh1R+G0+lQrY7IwmtGL52CH
         v4Uy1UWdILjyS9Oe+TrSKXnS/5VrReGR/aMBew1dIvXsDRTqDswxYjfLMPijU/l5WIOp
         Zr1b1nOaJgOSv5agsTF6xd3lGVdJpNkK1nUmyjv8jcAHUfxS1co+OGqccE4pa8UmvTvj
         RS/w==
X-Gm-Message-State: APuU4Z9clf8yH9LT2ddf1jBqN0oyeNVhvA//VTgKmfxBToAAMTjLQ6xe
	vf28QdZfEX2hY75TyCCalU70VfGKu6alAoTKHOvtqaHiX3HhJrl6Ro+TdqGIwQ==
X-Gm-Gg: AYBFou3uUJzNwfxhA2P/bhfz4v8d4b9/QwKESumDg1i0BO3uMCW1MUIXYLdUKrxfBlw
	Msuxqbdu4doj+ukdnkJ2WruW9RoGX66GcLlfyTMhuF64y38fEIMIH7lVqGpSFShc68r39TJKelt
	+IbeV8BzrRR5qVQ/A2LinFF6ddEacUsbUV/YyciAVRtFJa78LDI99zPoXFV1F+ThjeAsebYj9e2
	AMcz5IiXI4WV1GjSofbkGavQJGdBYL5uJFFhrlMu8uG2HqsqdNm6kXH09fo59fWVLt+E+TiBy8q
	/SjApdWHXbQttWK6n3KxF5gZIQYF4fxB5zw/Cm3cVIRnjd3UAvpRypAKWf5fUFyOJmfsGeMLTiE
	13xz3eFaGltvPyQwAFPVa5SWL0yGIXzaGbdStz0CTBc9zCK9FopIUPPQjInEfWPeGhADRVDgVne
	hVzmEpHrojc+iPjzo/PZrAuRuHFRYt0Q2D3F8bv2DbXWhKyYLOGV/E8cqYEXn1SG4Yw6+AoLA+p
	r3QVHnT5D+NlBluO1HSojobqfCmnA/WWHzJn9OY94NbBVJx7M1LG6ONf7xj3f4W1MGlzcSBWU7Z
	Uc8FG4pvW27I9u4fTv99m3Xi/2s0mZbvMycH9jfLD3EbpSUc9UOURiufOyps0t7Qxj7wpTM=
X-Received: by 2002:a05:6000:29dc:b0:493:2eb8:e7fa with SMTP id ffacd0b85a97d-4932eb8f125mr6363775f8f.43.1794068175852;
        Sat, 07 Nov 2026 08:16:15 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm10492960f8f.46.2026.11.07.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:15 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] atmodem: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:15:44 +0200
Message-Id: <20261107161544.471673-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The *TLTS notification handler parses the timezone offset with an
unbounded %s conversion into a 4-byte stack buffer.  A malicious modem
can overflow it with an arbitrarily long string.  Limit the conversion
to %3s, which is enough for the largest valid offset (e.g. "+08").

Fixes: ZDI-CAN-30186
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/atmodem/network-registration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index ba5a93bb..73693d96 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -992,7 +992,7 @@ static void tlts_notify(GAtResult *result, gpointer user_data)
 
 	DBG("time %s", time);
 
-	if (sscanf(time, "%02u/%02u/%02u,%02u:%02u:%02u%s", &year, &mon, &mday,
+	if (sscanf(time, "%02u/%02u/%02u,%02u:%02u:%02u%3s", &year, &mon, &mday,
 						&hour, &min, &sec, tz) != 7)
                 return;
 
-- 
2.25.1

