Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F93FC7
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:18 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id bk16so8254049wrb.11
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4KO7U1/s5Bgo92x/JLOGn76zOE2UzER0QuVYDAIvTs=;
        b=UuuLUoWgk0QeRdCTrEzNk8tChIhjjXca0rX7UhaQAsnRuY8fc2JMTx/SQXrGSGd0k2
         H1M2Irrda6+uSkaBZFNerEt3l6liNo7Bs8dS1TPTOwN0WNU9gg+A4W4cmQxrjacxUPdX
         NqKvR+CejkeX1B1RN5dAlE2wzdfnBekKrFf5vr8bjLzSmx87x8hFu03k+3T6NAcoMV83
         bFEOZ+0L17IVIbd/dCsoCE5Z53dUXe2s2b0R+Oe8hdyr5m+dqw89XhojOr1DRxCzSxaL
         dViiudfJ64V28hVBgMmYnL2JW3WrRpaq3gUcqioXs0pAMW4HyPZHFDQpNrtURXh++heb
         pM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4KO7U1/s5Bgo92x/JLOGn76zOE2UzER0QuVYDAIvTs=;
        b=E0sOTrgjDFDPJiUwJuzi2rbnEBm+5d0WpW3K+P6CXHtFd/8jV1eaUJfepP/te0u1fe
         DCTbFV93lur4lksGDN4JLeBZwmxdWhssUOcYIf+wRwMOGdkNvtP5/NZHH4bkbK+KhLOm
         iAaLeAPmzvDpHu1FZJ7xpphQJbGJ/IPk+XSzYLo56D+4Pcf62E95Ezu4NHTq19dFrRu8
         CeiswUHmbtzrX0RUdMcxetxICXKMowxvpl4myKT11r9E2KXrJUOZRZWZHHojIyouE/nR
         7cFHiZgFqf2c/8/3dhhlQmP699bcO4i2Ub+V6zv6PakzzlCX4Ddbztsh+6ShHdavVcQ7
         ywEg==
X-Gm-Message-State: AO0yUKUf3kvKMVsZidpy/TRuN73u8rTVo8bZUa89VgztkUh9qRXN7lz+
	XXcb6R5KNB7HkYYldSJedk/RTROzlNF//tCxE7MgZA==
X-Google-Smtp-Source: AK7set/Vx5/jw07Ctekz+X1Ulr0SxAgxDmNKsq22V/+SwuP3ssvIxrb8Us/zxr+fGmAb/v3RyhYcDA==
X-Received: by 2002:adf:f286:0:b0:2c5:c71:4a84 with SMTP id k6-20020adff286000000b002c50c714a84mr7707158wro.68.1676139076934;
        Sat, 11 Feb 2023 10:11:16 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:16 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 0/5] quectel: add support for BG95
Date: Sat, 11 Feb 2023 20:11:00 +0200
Message-Id: <20230211181105.7220-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

// This is a RESEND series, because the send to the ofono@ofono.org email
// has failed.
// It's not entirely clear that the new list may be 'ofono@lists.linux.dev'

The BG95 modem has currently 7 sub-variants (BG95-{M1,M2,M3,M4,M5,M6,MF}),
but we've tested and validated BG95-M3. The AT commands covered in the docs
(and ofono) should work with all the sub-variants.

The BG95 (family) is a smaller brother of the BG96, with the main
difference that it does not suppot QMI.

It supports AT commands to configure the modem.
The AT command-set is roughly similar to the EC21 and EC200 (already
supported by ofono). Which is why the selected vendor is
OFONO_VENDOR_QUECTEL_EC2X.

There is only one AT command (in ofono) that will not work (as for the
EC2X); that is 'AT+QINDCFG="act",1'. The 'AT+QINDCFG="csq",1' command is
supported (in that same group). Which is why, this change does not add a
new vendor ID.

It supports LTE Cat M1 and Nb-IoT. And ofono (in the atmodem driver)
supports only EUTRAN. Which is why some changes (in the GPRS code) had to be
done for BG95 to work with LTE-only carriers that support these LTE types
of tech.

Alexandru Ardelean (3):
  gprs: rework have_active_contexts() to check for non-active contexts
  gprs: extend on_lte() to check for M1 and Nb-IOT techs
  plugins: quectel: re-organize code for ussd & lte init

Mircea Caprioru (2):
  atmodem: gprs-context: fix ATD99 init for modems with no slave channel
  quectel: add support for BG95

 drivers/atmodem/gprs-context.c |  8 +++----
 plugins/quectel.c              | 43 ++++++++++++++++++++++++++++------
 plugins/udevng.c               |  1 +
 src/gprs.c                     | 32 ++++++++++++++++++-------
 4 files changed, 64 insertions(+), 20 deletions(-)

-- 
2.34.1

