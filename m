Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925433;
	b=ILkeKHpN2CfyCUw738UHgZ1QytFJ1wSMvvmod6NJ6S/Kt7JZ0leipaHptTe/ptMCtGyl
	 nY9j8CMfiaReD1H6VGAiSVPhjsQolps2S1SbzAqwUrdhofIFdZI5fAmKBxMVhRDqX02+/
	 jMKXCqjsz2LwY7ZTf8kbV2aLpBm9ABHu12I8tGshwaAJSNofvLEN505RJDVg9msbh7hPM
	 9SCvHygFvgh8UZ+7Ax580Qx+MDyRXsPp1bv7UClQcY1t0YPVYzbZK0p7TQrUyUwkcg9Iz
	 yGkgysfN5EV80DYn+I1wjcaPsY8fBBKXA0ARklybi7bh86GTgLNwvsIxD2TAmUPvqBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0pHdJQrZKm05XlANfKHxku9kLrK8hGoBJpJqe2g3GAk=;
	b=KfqCGh0f99mnJNbjSH27Lm0JgqiIGf7NvNlCUvkp6CYLop4ZmwZcKD5nenXY1ePJUWwg
	 CfcVlsvSqpucpiNUsF6GqKiCN6pwsXO40so5lhq48bTzWOBj0Q4fu1AwoMKLfOSBZGwqt
	 Hucn/rJmFbQVp0H213wAQ0eyr4Uwss+OZur+s/K9F1Bxxq0jPRQA+ushow8J1sneA06+k
	 tgB0gzQAHZsx322Ebd2WTvdbMk1j/PMMJJ3aaZ9XnoSZ3Eo2itaSWN/KhdAkmd41s25hu
	 usgjLQFfy+ZA+TF4sVGR8GgBv/a8DLVLlSpFKpMJnfv8qgcwtvHFVRHIoPT8g6NRPwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=connectedcars.dk;
	spf=pass smtp.mailfrom=connectedcars.dk;
	dkim=pass header.d=connectedcars.dk header.i=@connectedcars.dk header.a=rsa-sha256 header.s=google header.b=mwz5CxP9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF27606A334
	for <ofono@lists.linux.dev>; Tue, 17 Nov 2026 14:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF27606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=connectedcars.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=connectedcars.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=connectedcars.dk header.i=@connectedcars.dk header.a=rsa-sha256 header.s=google header.b=mwz5CxP9
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50715c2757so622412966b.3
        for <ofono@lists.linux.dev>; Tue, 17 Nov 2026 06:23:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925430; cv=none;
        d=google.com; s=arc-20260327;
        b=PYMxJ1z8n7UlD/rvGRlgQTCOci8m99/2Rx2vh1TCxjTJN/3ykr6j9+Am42aTJMyt/T
         M4jIhPiT8Z1p/AvRaxn0dLpxv3jtgUa94un0WGlK5uHft8e9IlSyiAlnN/qQs2FtpGpR
         pwH5eG8NPHPxyR0FDSsprFDj6371kUIumSlwXqrRK6HZrAyEoQUpb67t+HNIDGuc/YD4
         7BjBzmGEN4pt8iL1/Sg0mRvEv4vIK4siujJlOU19HjetHvt2zgmJXMgMncm/WtRZODJO
         X3JxVx8P8evch57+GD+XqyB1zYGLK9PtPm9z3/AvoB/ZMSy7Upxw9rs3Dw6wBHQc8fbb
         trHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0pHdJQrZKm05XlANfKHxku9kLrK8hGoBJpJqe2g3GAk=;
        fh=j0TGK8xchw4BN0C0cfv/r02RmBV/JB+1P303G55JUhs=;
        b=eUX6UgesKEYpCpxYQuVLawCF+e71ku82lUBkv6w3NoH3TyZj3joAHVyCrLYdumXM+f
         gzkSALwA2e/GyIaMfGDuiT+9LHqgsnV0h6Q6iu/kx9TOsNBNb1Gpa/JiLUEKkhPhekPW
         3IaWPEbgyxSWO8mYIxlytAJ/XMmkkLqN2khOnLSI9uIdayuGv2FqF+/PRP6Wft7iiKE8
         XVHFCnRq0JG7CtOB0E1x/pRoDrfbMCMIe29SVVlOv6UbX+1RqcsmKi+VdpxHG4nfug7s
         Q5d9JBYCOCq7W+HThvVJSQLsBv63y1NjqgVPDfW0Q2Yb4mSWdvIR7lc1OXjSalnZuJSS
         p0uw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connectedcars.dk; s=google; t=1794925430; x=1795530230; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pHdJQrZKm05XlANfKHxku9kLrK8hGoBJpJqe2g3GAk=;
        b=mwz5CxP922bcWnCDwwJ13ky9AvR3JZtzbYgTpwQDHi5AbTM475LY64gtmNi3HlTC5K
         SSVz4IfgdZDQeN6DN+woXpJmpUldjqBwMncbQNYfndON1MJ+wNp/6lQZERGR56addL6z
         a6KT2NNE64VioGAA6NCV05q1+25lEvLPZRPic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925430; x=1795530230;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0pHdJQrZKm05XlANfKHxku9kLrK8hGoBJpJqe2g3GAk=;
        b=f7bZTD2FTtCGwEAcjEFJe+FrE5a+n4kTVHYibU0Pp+ZKKMB/Ai9CX+A4aouW+WBCIx
         JtFPkAUGoHOx60hoAm/zoqPJ8mdo8MigY4+Cq6CIY7fza0JYnQQmF9PR4C9hFrySIN3/
         fJ9Cqv/WIdksWXVf89eSFtQVM+SFQqt6lVBEnyHkABj8wdf3C8py1eqGGROWJTXLhyyT
         v2BgLhzMeI2doLrNzKhx851oD3YWL4/8WiUiQk/tew5Fur406mvjicyggP7gDreoajmP
         3U4pTaRwwkn1SlQbcM4B/9OydTini+SJsfHIByjILqQ2mMhNTskvPv8fSV5j54tHKp3a
         JvMg==
X-Gm-Message-State: APuU4Z+6EXTs0B0eaa9fRYr9jxbcOhHNdZIVHtE2lChVGp/LOyzzV58/
	R6LC0s4QbchdCYMU9pERsJXCKYR/K9CYnyVTy51r4oDQWZ7Y8KtIB2iy+rt5Dy2L5ZBCCpK2Rky
	jcfx0qjnt8a2uKcubHREimsYFzpwYDQG8KQDOlVRLTvfRaERBBIpll29rZA==
X-Gm-Gg: AYBFou2i1XUn+x3DIP1JTdtekHIcicyBWHdjSTQ3bOdXWyXT28TNux8yvG1z1OPVWhL
	0Y1MWUmyvuFjr5Z2zA9qOQRwhpTpUk9NsfnuwwIJ8vtsAr6Vi2sGfdcBpUrz1mJBb0iVG5eytmB
	seW+PNCbK1pyuA5hseJL40B7yYshTLJHpRMf8YO6B/zAUVCsO3hVNfdxufQlPF03CLyMBA3zitC
	/aqoG3AVvGJmf6FTUfne+DPdaFQw2Zuf4D3rRTElolwigtvXB6PU4CkhrqjQ1dSm9BgkBRdtzfD
	aCUQAlqbKazMAVW+k2appulBTwM61Oje85MZhq/tY6d3Z7hnkR4N4zI6NxVZlOdew1RfEZwuT2L
	xxN5t5mMXWMNSgnjC7X6Cc1M23TK5ebfYunvO56sTiFcboe3v3qG7j7nvgKl+7kv7RLXtLko+JF
	kkdZgkXB61Nur6DXGU++ZP
X-Received: by 2002:a17:907:3da0:b0:c49:cf38:3baf with SMTP id
 a640c23a62f3a-c509614e5a1mr1159641366b.5.1794925430066; Tue, 17 Nov 2026
 06:23:50 -0800 (PST)
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Viktor Kim Christiansen <vkc@connectedcars.dk>
Date: Tue, 17 Nov 2026 15:23:38 +0100
X-Gm-Features: AclHuK_qiLy0oIzIr2HAjs1mCKNj3vRnzdMec6PrPELNiRUpSnAJBdS-UCqSmLo
Message-ID: <CAGRJfpa7T5ChbXFXhWfKWLoACVEizbV4nF+yS9fZDhHrXr8hYQ@mail.gmail.com>
Subject: PATCH] atmodem: reject activation until PPP shutdown finishes
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey there! Here's a patch, I'm not sure this is the correct way to
send it hope this is good enough :)
- Viktor/Viterkim
---

at_gprs_detach_shutdown() starts PPP shutdown asynchronously. The core
releases the context immediately, so a new activation can arrive before
ppp_disconnect() has finished with the old session.

Accepting that activation overwrites the driver's CID, state and callback.
The old disconnect then completes the new request and clears its CID, but
the queued CGDCONT callback still runs and dials CID 0. If PPP connects,
its success callback reaches pri_activate_callback() with no pending
D-Bus request and oFono aborts in dbus_message_new_method_return().

Reject activation while the driver is not idle, before changing any of
the old session's state. The caller can retry after PPP shutdown finishes.

---
Reproduced with oFono 2.19 on a SIMCom A7671E by restricting LTE bands
while PPP was active, causing detach followed by fast reattachment.
Three controlled unpatched trials aborted; three patched trials
reconnected and passed PPP ping and a fresh USB control query. The
patched trials include the binary built by BitBake. The original crash
also reproduced with the normal HAL client and no debug tracing.

The affected upstream file at base-commit is byte-for-byte identical
to the tested 2.19 file. This submission draft applies cleanly there;
a full build or device test against that upstream revision has not
been run.

 drivers/atmodem/gprs-context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -231,6 +231,9 @@ static void at_gprs_activate_primary(struct
ofono_gprs_context *gc,
        char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
        int len;

+       if (gcd->state != STATE_IDLE)
+               goto error;
+
        /* IPv6 support not implemented */
        if (ctx->proto != OFONO_GPRS_PROTO_IP)
                goto error;

base-commit: 00c3cb126746b1f68abd5605f5eed655d0fcde2f
