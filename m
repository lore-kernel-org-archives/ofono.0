Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433388;
	b=aLSRdGrDH/T5vm/yW+F8Lj+dzUp3wqARIPWY0W3dK5FGFpF/DWd7BZp1bgdJUvkKs7mK
	 7AoBq7l00/oI+wOsB/bIyskqF00f4nTyqXAEzzZHmPzAv3qpwygG/X0UBgy2ODC/MQj7z
	 sL8JGwi6WzvJnjraMerzXFo5XdLr/WH49zZML9wmz6ooRmotYhyEtEtHfS3CcBzXfIfsX
	 yW28fXaD8RZZkH9pWtBDPkqRg8XelWwgO5G36F7XhzL9tOOldJAral84i+B4GtwU/idYV
	 W/msA8B1pxrUIqwPkIVz0BMHFkG6Mnl3uszPktMp3shEkG7kuB+w3ubQ86/HiFyc37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GV6o1IuXGL79ZbSEdXNpgocv0V5ogyKLI/G/f5L5jj0=;
	b=oWVVyyeKRt5dkhz6IeVDEX9yHxkfINq75iaCsDCUXcf7bAqnwgiJgj/GO3LMMAV+8oUM
	 9vdgdeBl8HNilnqLmWgKlHapqouMFk28yQsEdZ5nF1t4TcSVvKeculA0Kl6qzaJQsdEkH
	 VfS6P9MNj9SCHnDUxuC69JUpb2GMXDA++8aT3SecUw6jacAA5tV/SYJvZgrOkMoXtYM0S
	 KCzIbRhCCKDxX/RkNWtZflMeXBCCPKM1DNu+o6j2Rt4ghLE/hPw3vj5E9xNcSkuGWUss/
	 jZaIAdGgPzX6TmMXzRt5Or7XrKcwzkaG9/1nWshGxrx8jBymBuCySTkcBFUxCydY6gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uz4ZCkHD;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF079606A324
	for <ofono@lists.linux.dev>; Wed, 11 Nov 2026 21:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF079606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uz4ZCkHD
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be47aa555cso3293054e87.3
        for <ofono@lists.linux.dev>; Wed, 11 Nov 2026 13:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794433386; x=1795038186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GV6o1IuXGL79ZbSEdXNpgocv0V5ogyKLI/G/f5L5jj0=;
        b=uz4ZCkHD1NlVBMQt7Ue936mvtdmaVk34RuEPu8CFZRfs/dysGfpFSiDVhJwsy5nk06
         e6ewrExFY0NPXQkPc+FoLq1EwosHkHebAVyBAIXmyru2mXvphXQz1rBPrXQScrvn/r44
         mvQrIOUoEYvS1A9XcZwJuZehyPMi0fxyR0WJWK6V5HKOaNqhr0Pr4TXYg25poE5jIKR3
         dEtG/XUmyrmw0qyP6xEUZBJsDxhOgJ/lad5bNZJXBVLy6iOL/bSpLT50ShhsnhdK1gQU
         LQGxTDTYJMfwDFpFqCdgKAABzfr7MM/hLpsKBpKm4npqh6aN/mcd1yBBX1914zj8pZbl
         67Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433386; x=1795038186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GV6o1IuXGL79ZbSEdXNpgocv0V5ogyKLI/G/f5L5jj0=;
        b=ta2tlBd2WlxxnkQ6MrN1XGMtIaKDGLvt+9LegEHVHO0MJLc4yr2nTGdN/UhWySgAlV
         4ozSVxn/JsB6M3Yq7OD3ztow6Ukuvcq+rPle5a3+GgDpsaUtVHKsRUcxusKyNkhjWUwd
         f7F/zI4S36lAnatILwBUTGFANLP/GXmf65ahRz6PVr6tazToHKdqu2EN16Dq3jOCpO6w
         QZQVVdRudx5CUF9ijl8VVqwNBHATKKjZHcGp1PN12Jkz5fkmqNtw+Vrn8iWNGNmRRzux
         5W8dsP1SIiZpVd1RIDTV80cqtCfd7QARjRQ+ucILj47QUP+voNexD2mXfOBtu2cXrAIf
         9u0Q==
X-Gm-Message-State: APuU4Z98W5+JbX6QMEYnFWn50d+KtEZGjt3kwrCtvGb1zFHaGVh8Ja2I
	ssgUwZG50FT2WFxY9pm75wXRcIIwJZgj3+qDzv3rUeWVso3eURTjkViiMWL6aw==
X-Gm-Gg: AYBFou29qpEAYBuO7p2k0lq+Z8X10R28bKTmw3tn08zXCP997FSFKKLXC1wZfTgfoFD
	y50tnf73aHIoMiPq3/BTX92/N/vtCtOwosfKF+2yMu8H8Naa5bpdGbm2L1PjA5du1m5PON6YZ3U
	qO/KUoMW6FtE5/h4UY8kp3V5wLsZlhXZHhjqVusw+Zn5PjCWexk+yAK0HEaVANTWIxKw/T5+PnX
	mCZL5WWRlnIvSopF1HIeknHVyPR886oC6dlMSYCv3C/nzU3Hoafz/TWlIjiuXMUpvoVwcD/JoQC
	OSIlQ9v9R0QGoUygvwiR3+qlKtxJFqgT9AalPfKugHxRRIWlrkQFhySVcV0jWR+Yjn9Dcg18G7d
	bFkaG2rhyOAb0iR6VIZcHycnKgERg67ULmreTfcPlLa8TPpHyLkMxeJrGf5N/Qb334E+g0eq6cN
	1xUK5KwDmGpLAi+KdKQCU0iyuk/A9q2q7HOQIOGHS01w1/oiDhcjzASwkYV26AxRoDtoQXGrek1
	Tnt/WQsfmuTYJqRGyzWnEepkKpbCGO9DNAk8C/KChW7lVN1u14798Q5uMGGKA6Pa9BAAnVYAma7
	l5vZqbd6qam+98390jfSr+Y=
X-Received: by 2002:a05:6512:12c5:b0:5c1:45a9:c2ae with SMTP id 2adb3069b0e04-5c15d644128mr1004743e87.23.1794433385813;
        Wed, 11 Nov 2026 13:43:05 -0800 (PST)
Received: from MATRIX ([31.28.200.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a100sm1190220e87.10.2026.11.11.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:43:05 -0800 (PST)
From: Andrey Larionov <id.dozer007@gmail.com>
To: ofono@lists.linux.dev
Cc: Andrey Larionov <id.dozer007@gmail.com>
Subject: [PATCH] atmodem: Filter unspecified PPP DNS addresses
Date: Thu, 12 Nov 2026 00:42:26 +0300
Message-ID: <20261111214226.1983661-1-id.dozer007@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When the PPP peer rejects the secondary DNS option before supplying an
address, ipcp_rcn_rej() clears REQ_OPTION_DNS2 but leaves dns2 at its
initial value of zero. Once IPCP is up, ipcp_up() converts that value to
the non-empty string "0.0.0.0". ppp_connect() then includes it in the
ConnectionContext Settings DomainNameServers array, for example:

  DomainNameServers: [172.25.0.1, 0.0.0.0]

A connection with only one DNS server is valid. RFC 1877 section 1 says
that primary and secondary addresses are negotiated independently, and
section 1.3 states that no secondary DNS address is provided by default.
3GPP TS 27.060 V17.0.0 section 9 (pages 13-14) requires IPv4 DNS
information over the TE-MT PPP link to be delivered as defined in
RFC 1877.

Skip unspecified, empty and missing DNS addresses when building the
list. Keep it compact and NULL-terminated so that a usable secondary
address is retained even if the primary address is unavailable. The
example above is then published as [172.25.0.1]. Log the filtered list,
using "(none)" when no usable DNS address is available.

This only changes the exported settings and logging, not IPCP negotiation
or the handling of previously supplied nonzero addresses for rejected
options.

References:
  https://www.rfc-editor.org/rfc/rfc1877.html#section-1
  https://www.rfc-editor.org/rfc/rfc1877.html#section-1.3
  https://www.etsi.org/deliver/etsi_ts/127000_127099/127060/17.00.00_60/ts_127060v170000p.pdf
---
 drivers/atmodem/gprs-context.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -70,15 +70,22 @@ static void ppp_connect(const char *interface, const char *local,
 	struct ofono_gprs_context *gc = user_data;
 	struct gprs_context_data *gcd = ofono_gprs_context_get_data(gc);
 	const char *dns[3];
+	unsigned int n_dns = 0;
 
 	DBG("");
 
-	dns[0] = dns1;
-	dns[1] = dns2;
-	dns[2] = 0;
+	if (dns1 && dns1[0] && strcmp(dns1, "0.0.0.0"))
+		dns[n_dns++] = dns1;
+
+	if (dns2 && dns2[0] && strcmp(dns2, "0.0.0.0"))
+		dns[n_dns++] = dns2;
+
+	dns[n_dns] = NULL;
 
 	ofono_info("IP: %s", local);
-	ofono_info("DNS: %s, %s", dns1, dns2);
+	ofono_info("DNS: %s%s%s", n_dns ? dns[0] : "(none)",
+			n_dns > 1 ? ", " : "",
+			n_dns > 1 ? dns[1] : "");
 
 	gcd->state = STATE_ACTIVE;
 	ofono_gprs_context_set_interface(gc, interface);
