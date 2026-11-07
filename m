Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068591;
	b=4baSA/G/A69JqvRVFhjO9rAm3Y9yVN4QbS2f+O4ncoPFhZmzUhzbBk7BHPRPBvTzp+ec
	 7qY+3U7+JHQ2DM9H/AoEUjRVdpSMx5WLKbZ8YfFnh3FT0nX4BXx9ZdWjRvdxxJljIgYR6
	 DWA39I0BraybamiDw9z1Qe8rmIjTveJrUNcxBv+mebaIRb0WCzF42RDKk6O5ybYnmTcFq
	 8BXSoQyEpysEZAqjpboeWwKR4vz4uYGHIvk0sUK+UjMtDcyb1uNPZx6tRVIJpKptPpYPi
	 Gm9D9/rqMBjWgo/4LQF9ywcPDoyl/BY0dZTPwga7pAGfvnEDQj04b75L9rY3vwrBHlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UMKEfozDdaiLDcrVvo51Jgtq7s6MJ05l9UlXaaYRQ9Q=;
	b=e4f0G/xDlc6wjY2lbXOqjDQF8vdlzjoeIJiVL2TOu/rJG/IxG+cEQ4wUgtG+1zoRDXML
	 1ZSYdEKLA6fCdBifoHlHtrazJkpLkklLQiSaGxvMOTHmFofvjsVyQRmHrzXr6DYgBsPqz
	 G434vtAlVqC0GhWnbdlkGUeCBCKJ5dJuoHemqZLm6hERFtMUxdhI++yPBIHtD04CQcghY
	 GhdYnVqPiROqlJ2lJmcFtnJDpXaFb4A8dnGQk/7rS1F9/Zh9rsVxVI2tECYeFNqT4fGl7
	 j512/vF3dWz4ts6CV+LRp8iSGEaGB24XHTpk+GCGp9j9oOx+3ftSfpHBUYImlEQRfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9q53jzE;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43282606A32C
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43282606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9q53jzE
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-491aaed7565so916023f8f.2
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068590; x=1794673390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMKEfozDdaiLDcrVvo51Jgtq7s6MJ05l9UlXaaYRQ9Q=;
        b=r9q53jzEdTgt++RYp09aYq/Koac1I/1Tpt3vOMjZPPxend0ilN5sdWvptmGlZ3uEYt
         e8pt294Jqp/V5ZqY5728iTqOupFE5tG/KaEMPoJDMH71Mr7SmD1x9wdSLX6zZhqjK5sD
         AwJZ37/rZzOOjhy/MbS4mgoc50rHTbyoS3loC251DeIK4rU0MI/uNsHCtbguZ9frex4h
         G6CmoPiCdDA1G6t8ftaPT6zt+G+3APe4F56GniD0IH5b0jTh7VyCVQbuHOIDgN15dFPV
         5nMKndbt2+6Dv4v8PfauV0uMNK7HNv3GvEpuz/vUOalFA1aZLMOGiWZqR6ByKHkLiZrZ
         fMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068590; x=1794673390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMKEfozDdaiLDcrVvo51Jgtq7s6MJ05l9UlXaaYRQ9Q=;
        b=gvY6pIBxX82HjQ0O7It6idFwDe13AbaNaihH4w7kF2gBsCz6hGXFe9GlTyNRLJfsYZ
         M9jqU5D2WrA6oaNlbC1we2WQz6ffiuN+7uDQGOpLpWnkC/jkEhihgCFply295zSVhhlJ
         BnKGtsNsVDVR+t8CFmXMJn0U48fzWGJSZcP53dSK2L5aAy/cjFSpdCW98klAAin3D1O5
         KI6qFMkio2RLDHKy2yoMa51lRNugSlajECMMs1gE9KKz2AmsIpwKN4PIwCKPCAzGZ9l3
         tBvWW8mYFBHxXMYei92rJ8FA78ghqF2IkyqDgTi2WMRR9sjC/HVF7EddaiU/FSq5F32k
         q/Wg==
X-Gm-Message-State: APuU4Z+0SCW+XdLHTbqjaTdZCW9kHNWIyT4fwvE/PjribZ49jXhUgZ8L
	0RM/n162mwRJraeLPhafVipSy0nwtsc+ksla4rwPKAljyh7wckf67/Hg6mCYRw==
X-Gm-Gg: AYBFou0IIoIKkJHcY8lR4zJ4cKy6lBwk5Mtm/OJnNnoyu/Y1pH/v2F9aq99mjNZHk10
	tLxeT3tANvyu1BjASpqC+oIuws4FWZo+vh8UwBXziPKFJZnFpsqtTtv64c5ZiUfkhX1tiYgyTuG
	LY8eU3Mx6LMLKWvrf7yVmHS/9HxUyJiSP39DD55NQwglwGjm+MUm4uT8tFqzoy83w1VNYEJD7Uz
	1EsiQklVpMMjYAZ/k4K7CjibL/ID4+p8ZJzIGLo0mKM2l2ap99b2he6qTcr64OvFj+hPOTCKNEv
	zJmnFcrdoB5FbHg/9O5wMnrf+cujG4yj2CvdVaXS1SSGnC6PS7a9fEt6SpVXnrVCsiQpUoXJxiU
	kzMHq3qKZAj4F3YOOV5n/J9S5uXXqHGKOGVkA7vFP1iSTOkzqsf2RGSnZ+CPp9c6AX+78IvQhWl
	1Vh7pDGDn/eU31TIGqPv6PdA5TmEkUYjo4OqlSfspvxQVBJpxCn8A+8NLZUmtl0XRQ8MYEoCKNr
	qD32Xo6yn1fHNqoxjEAlR/v3jq0nbDDJm1UScCh8CXHMjvLePps6Hz+InRljzwW8ccmVZoAUJcu
	LOLfmt+3kGMm1SLhVzeUNHhwWRqMw6qsg1GeXovJj/7G3/pzng==
X-Received: by 2002:a05:6000:454f:b0:48d:f4ea:49c9 with SMTP id ffacd0b85a97d-4927835f07bmr7333995f8f.54.1794068589375;
        Sat, 07 Nov 2026 08:23:09 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm10487667f8f.51.2026.11.07.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:23:08 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] mbim: Fix possible heap-based buffer overflow
Date: Sat,  7 Nov 2026 18:22:19 +0200
Message-Id: <20261107162219.472399-1-ivo.g.dimitrov.75@gmail.com>
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

The length field of an incoming MBIM message header was used to
compute the number of bytes to read into the fixed-size segment
buffer without validating it against the negotiated maximum segment
size.  A malicious modem could claim an oversized segment and overflow
the heap buffer via readv(), or underflow the byte count with a
length smaller than the header itself.  Validate the claimed length
against the segment buffer capacity before reading.

Fixes: ZDI-CAN-29089
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/mbimmodem/mbim.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index f12f2e61..8584513f 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -628,16 +628,27 @@ static bool command_read_handler(struct l_io *io, void *user_data)
 	hdr = (struct mbim_message_header *) device->header;
 	type = L_LE32_TO_CPU(hdr->type);
 
-	if (device->segment_bytes_remaining == 0)
-		device->segment_bytes_remaining =
-					L_LE32_TO_CPU(hdr->len) -
-					sizeof(struct mbim_message_header);
-
 	if (type == MBIM_COMMAND_DONE || type == MBIM_INDICATE_STATUS_MSG)
 		header_size = HEADER_SIZE;
 	else
 		header_size = sizeof(struct mbim_message_header);
 
+	/*
+	 * The segment buffer holds max_segment_size - HEADER_SIZE bytes
+	 * and receives hdr->len - header_size of data.  Reject segments
+	 * that claim a size the buffer cannot hold, or that are too
+	 * small to even contain their own header.
+	 */
+	if (L_LE32_TO_CPU(hdr->len) < header_size ||
+			L_LE32_TO_CPU(hdr->len) - header_size >
+				device->max_segment_size - HEADER_SIZE)
+		return false;
+
+	if (device->segment_bytes_remaining == 0)
+		device->segment_bytes_remaining =
+					L_LE32_TO_CPU(hdr->len) -
+					sizeof(struct mbim_message_header);
+
 	/* Put the rest of the header into the first chunk */
 	if (device->header_offset < header_size) {
 		iov[n_iov].iov_base = device->header + device->header_offset;
-- 
2.25.1

