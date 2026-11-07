Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068139;
	b=X/mxqKbrYaE1zLJorQ/aKBU4Z8sPogz8v043C9TsQZr1gGH9KFx3z3VhTUEUhrHOmtQ5
	 aIS+SAm+zuuewYYdoQi/EeTXDb1KuY6CC2b91f4ex8J7haiD65vP91s5UfisS5fDLSeeI
	 A37PulSeBccUxRBTFZNeGcpbglSh4NAROwivZOe+HTZErdPPIePP4HTTtgtmjV6oXqjuQ
	 GXWnnkVHQ4Z/7S91npINwz8+OjCms3IqNkbIejRB+pt9tE7N6NomepLJQWloU7PUACalC
	 n3//VRkw6BclOS4KOQhbu5/ZenrjfJdPTE0OnJ7D85rv0jtdx67zRdL/KSl9b2Y//RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8yYkOA+lLaJ4OMfDuFn/SkEaiQsXWfkMtlbOQZe8KmQ=;
	b=HZYBmK+zpX/laaknhpnkazEDrJj2Po7mO0GYBgBJC3bvZnz8/m7bMz1MfcraSjNi9ZOn
	 +vGZ/EOP/o/rW+b4ZVbf4Al+LnOqIskOUxm+QupL34NR9VsjKzgd4TKRTpK8e3asH41CN
	 6/tgJriIviBb65e4HU5G2NqduexZGdcvvlIkGkw5DAaympPGv6HbhYIyZ7BgO8gnAvMmf
	 Oaztq1DfOUbv49nkAL9/TtjSQEeTsI4FTKZBLNyQhBML1+VAyVZbcTv8nWEN8dIB138VA
	 atQ9wspwN0/UIpLsLBYOPldm/Ew9quQCaJVJVQvlF00V6Q5npd05faj7tAEAqnTaHmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbsp8z+a;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6B606AC2B
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E6B606AC2B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbsp8z+a
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11148975e9.1
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068137; x=1794672937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8yYkOA+lLaJ4OMfDuFn/SkEaiQsXWfkMtlbOQZe8KmQ=;
        b=sbsp8z+attQIdQDQFXfJWczU3oBNBXKkMBrjztDRlYfO9Bq08ByiiUU3slInJNLhHZ
         qfUo1pJRtTI2L7Iz8B8oYPWb3DBEXc5IeaexAdSsTec2yALtQv1TJzKu93y9hE/DNonP
         hrqq/BL/zObT0GbQl4zz/h1s/R7hCId9hyYDIjgV00gE15CrgCCQyhwuSOmW496MD7N7
         s2yNh6k/Krw6L8BnRtMhcTJqXeH+tCGyA/N2EZVtkYdI4GcpNZ1GahmxEs6k5ZZxLq4a
         TwAqPD6fIcZDrDHo5UknF+p2Tfx5fk/ppqGxZ21R208/KwZmqQDqe+bMfSIPKNUj0zPw
         LOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068137; x=1794672937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yYkOA+lLaJ4OMfDuFn/SkEaiQsXWfkMtlbOQZe8KmQ=;
        b=BM1IN5UYd4X4oD5YJwwT2mShcFJQYTSqRyJJoTtBO5/yujWjy5o6E+b4dOTJdtkzf8
         dR5mxMvGMIYvAKSgpwsI2eGieUbVB1w1CW71uP5kaGfgBCstPbBY8GOhx4g9MfFzIWFz
         zhRUNnGNNxhBEirnt4o+6oVCodRU5qfldyupaEXmuO0dMuAFfTDygEHsk/R3q7nm2HLe
         XLwbvgmoSh5sVSuJHGanj9jHfYzvwrCPXOp2y05yWwccpMbv4a/JOPU7Y0MrJOobxT9u
         3K0N/xoF9d5xx1zCo1YVKOGNS/8n6xS5xeMygaBG0NfguNEcLCJ7b+hkydDIhcLSyb0l
         XyLQ==
X-Gm-Message-State: APuU4Z8FOnySPubze2WOD24SMBtsBniToTMP7PvS1PyoF25k7XJ/SOrO
	R9kykmS5gVQ5zAsUrEi99Q/M28v4y5umqyfYSiUW7emZMV2bNHyra2tXAQX98w==
X-Gm-Gg: AYBFou26AljVMOqromdDEE67YlVBPDJW08OmdtARF4YbUZ5I2E1eCpG/YXvH+Zg4D8c
	K9AtfqKy3gIqUSGKIY8lzr1ucfATDpt4DNa4M07hdtXj23qd98ymIOzLBOVWTGmdYdrQe/4fixf
	eJ6sZLqpD+l9DmnTWfEYasxtYTfEpZXDxVIp5fsh/+jc6t+I6d4bu1RT72hKR2BwIQUbrU/WMIU
	drN2iyvsuK25D6wcse2WYxBm0IY9gdSyOiFxG/Df0sbWbLGFCFfNtISW9P1eLJp5X9dB3SpPn++
	BTACfmzIP0qeNWq86CKUvTtl8IlkAxvysUwPC6Azh5tLf7L039IhtyLkyL3qs/FoytnSXwY15Xn
	TQNXaCRS2dlE4EU4TON7/bx4rrTNrddQ6GY4UWcMn+dbAs+91xHX1SEh6Ec+CeP97XHxoioeF0U
	1jMS7FsOyR6b8fLHQ6T3orjKfs6owPHr9WvJgwYaCDB8kPKFpPQ6QiLRrhv20Nfs1Mz8HtrMEqe
	0Ezm0HEmGY6sx4jv8NiPSoXechbHBhus8AXsU8p7ls/5bhcTKpnDSUp5Hz7IftNGx3JcPhQDjDm
	RkRxE6KnQemumW+JL2AVeCNd5uqgys7D5EM2pTU4HmsO4njbrQ==
X-Received: by 2002:a05:600c:46c8:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4b6dd82aa22mr102181125e9.7.1794068137162;
        Sat, 07 Nov 2026 08:15:37 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm58577115e9.4.2026.11.07.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:36 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] atmodem: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:15:21 +0200
Message-Id: <20261107161521.471607-1-ivo.g.dimitrov.75@gmail.com>
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

The length check in cusd_parse() assumes two input characters per
output byte, which only holds for the hex-decoded paths.  In the GSM
7-bit packing path up to 320 input characters are packed into 280
bytes, overflowing the 160-byte stack buffer.  Limit the input to the
maximum number of 7-bit characters that fit (182), matching what
ussd_encode() already enforces for the UTF-8 path.

Fixes: ZDI-CAN-30187
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/atmodem/ussd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 59dd2e59..b7deca98 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -128,6 +128,14 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	case SMS_CHARSET_7BIT:
 		switch (data->charset) {
 		case AT_UTIL_CHARSET_GSM:
+			/*
+			 * Each input char is packed at 7 bits, so at most
+			 * 182 chars fit into msg (160 bytes).  This is also
+			 * the maximum USSD payload defined in GSM 04.90.
+			 */
+			if (strlen(content) > 182)
+				goto out;
+
 			msg_ptr = pack_7bit_own_buf((const guint8 *) content,
 							-1, 0, true, &msg_len,
 							0, msg);
-- 
2.25.1

