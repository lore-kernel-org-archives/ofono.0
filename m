Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36749179AF
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097061; cv=none; b=OSC3pD2+th16GyG7kDI3KIeM/xWRpqTReix8h/00W9bm//Yi2yEsNK4R7sDP6QlKtGlCEaeqLcMJAQL+883igTzB5H8xuCk5HCQpsLDilRCpeO+rEXVMsLauKinRnNdKJgzCXJIwAUrfd8b8WLhdSFBxQao9fcbiA3FKhUyx3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097061; c=relaxed/simple;
	bh=HKXA4XdTxGefTIGQ80/Qe1Utjgr/lo1uHDKL0Rd6KzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9LfKj9gej1VzwqvflsejE/nkQMu/rxWdyEkmLPV8QI/zOKlqpIve1m0Cmnojm9t7Xbjrnrn3OOYeeRZ+giiVXlbAWo+LVIh6PkjXeEA3WP7TgGYmjJxkOOXRkkLSMG6qpObzUCsoXEQT5q+bmI4Efr9WRyBl8OF8e2CT7JHCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8e1YTxp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8e1YTxp"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a4f9f94e77so3738432eaf.3
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097059; x=1712701859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy33ebB5lB7yt6ni9z0zmRuorlB53ZnKc680YtOSEc0=;
        b=H8e1YTxpSOOV0oRgQF1bh1QS1WQrFl+6xaaCc+qXZa3Gpj1pc+NWt1aMeI+kYQm+1j
         0iOPZRzHAJAAlOyrOugBpGHAzre3p2ZyVGLcAq0jub0RklYvyBXh5DIEd7R6kvm/BK6y
         DkT/lCkJnt82J9F+wZfJBUKcFDqDWgu8G9QW1jR4pZtEusSC7kHQBB7E1YpdBPWSWNC5
         /vKVfkSVNZaeOhPj8Dp1Qs0N8UlYIgn4Si9heSS2O2DQrx1rat0WBI0OUhtj/pB1Ca0Z
         W1wKjYGHk+pFcxhJhVSvaHL2SzBw0GsyvaqlnpvDGlfQdznB/zfHsFjLDCDQ1iplO8Eg
         scuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097059; x=1712701859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy33ebB5lB7yt6ni9z0zmRuorlB53ZnKc680YtOSEc0=;
        b=ARCFXLjEvkdn6EbJOi/fuxIcZHuUuuasPWFLx71A1VHSoNVXO6Avd0sSSukOwSnoET
         P8AAlJ7irDGXIK83okO2M6qIePoGtCEp1eqfe7+atPeIVCrA6EA5ObNqUT+JzzsdN6hr
         3QYY+N6SyzBx6p8Da84nqjjZbV4l070ONue/0ZwF9aBh7Ibec4SXXwN9fk/ERV2Imk2y
         7IYLeR/1qtoe19QFfOFVwka+Ra8oPLDrUon+EdOp3+UAPAs2qNEDG5++Svbv0Thq+Juf
         4Fhw2kT8jd0PDtCLShc10H2cBkZeeXxb3pbGSrI9B2vcyee7a7XQhXwh9gu4XMv9O5Lv
         0zpg==
X-Gm-Message-State: AOJu0YxOxt+uL/v3JWFRDS5IZ7BYhdi8kGmgjtKoF9Jtbt/P7WAmMNcE
	oI1R0iaG0VmBstvPSvTCCtTuHYlcM9OzyB63jTMRuTFYfwpms9tzW0BpnFXY
X-Google-Smtp-Source: AGHT+IGHz7eLFR5OEpl1CatCz+oYX1L4IagCHfNDTa+XUL2k0ElHP5ZWc6bpn5/j/UFMU0X3dEZevQ==
X-Received: by 2002:a05:6820:285:b0:5a4:b99f:83c7 with SMTP id q5-20020a056820028500b005a4b99f83c7mr11282326ood.9.1712097059177;
        Tue, 02 Apr 2024 15:30:59 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:30:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/13] data: Mark some MVNOs via the "spn" attribute
Date: Tue,  2 Apr 2024 17:30:29 -0500
Message-ID: <20240402223054.2819526-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most likely these MVNOs use GID1/GID2 or some other magic to be
auto-detected properly.  Mark them using the SPN tag so major US
carriers can be autodetected easier.
---
 data/provision.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 6856ce0f0eaf..e55ecc6f8d67 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14372,6 +14372,7 @@
     "ids": [
       "310240"
     ],
+    "spn": "Ting",
     "apns": [
       {
         "name": "Ting Data",
@@ -14430,6 +14431,7 @@
     "ids": [
       "310410"
     ],
+    "spn": "Tracfone",
     "apns": [
       {
         "apn": "att.mvno",
@@ -14450,6 +14452,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "SpeedTalk",
     "apns": [
       {
         "name": "Cellular (MMS)",
@@ -14480,6 +14483,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "Mint",
     "apns": [
       {
         "name": "mint",
@@ -14495,6 +14499,7 @@
     "ids": [
       "310260"
     ],
+    "spn": "US Mobile",
     "apns": [
       {
         "name": "US Mobile",
-- 
2.43.0

