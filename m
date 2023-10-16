Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4023775
	for <ofono@lists.linux.dev>; Mon, 16 Oct 2023 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc82iw2P"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40776b1ff73so21709295e9.2
        for <ofono@lists.linux.dev>; Mon, 16 Oct 2023 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697456035; x=1698060835; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5crrLi5cHoM6okMYvfu5NhvGYLdGBEJVkwpRrCmgJo=;
        b=Lc82iw2PvT55vUKKbqMs6xdC2b/MBMU1HmHsDb9HGpL4gcyEfpYD3TLILGxE5+phA3
         tssYW+R29tgp/s2Tt8jnJ8J9w6pfJiCCHrCZ607Y/hEiaIGAYW8dMYl1hYC/SU7UXC0R
         YkEgyUDt6dEET3yenfpX1jcuROLAN4/gtc8aZtIGd9+178I3ZbXVguAgkH5wMi+n9TnV
         EK5TRLpW9C9UUuAI7kOEyaxd3N4Ea+Qj/NQH9JWO1r+VZaaXvc2ASoUNczcLsSdo0vMC
         TN96b0/6ErFqYqREXDiUG7QQLqBRgqzZbEYCxxGsBSPogsqAMz3JILLf+ESzXaKm0Mux
         yNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456035; x=1698060835;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5crrLi5cHoM6okMYvfu5NhvGYLdGBEJVkwpRrCmgJo=;
        b=vIUGCC0TTVOrqPIELMgqQ6VsA3BtiNT7WsKsKUiH+V2XZFq0kYgO9HHCwf7f7HgbJm
         /okJGejNLxrHAwfS1HtXi1I9VFMMPLoYYQYQxXQ5O1bQLkzVaEL2UUD7I6nm1TTYJfNy
         okxDn90otb91y2t0hA7rEZKnip69HvnEUo6sXzlCl43SVa0k1IjFfDi6hpQ+J/9pb/Xr
         cv7JzY1EgxpztYo5qSSKoVOdFSXsTOyeCpkXF5CpfYuNQo+ewxoclUMcznWE3FHIGo5R
         gK61/N+E9PodsPsFwplvHj893ild3nqk1VWrxBMOr7XZyrBaTi6A4TT9KdMhIQ3Thpd+
         o6kw==
X-Gm-Message-State: AOJu0YzG5W8FMCpzQ5RUOjshmxVqP9tftFgvK64tZdTGzofN1Lrqjx2p
	6iOv6OaA03LZBBBs9ZVtfjZqpAae1d7nLA==
X-Google-Smtp-Source: AGHT+IE8O5xIcdmX1sLk46o5rOqXed4O/G9U1sZ04iw+rxOhmDqUpNGxcVaESHXaUadJaEKtUV4T6w==
X-Received: by 2002:a05:600c:3787:b0:402:95a0:b2ae with SMTP id o7-20020a05600c378700b0040295a0b2aemr28439645wmr.32.1697456034501;
        Mon, 16 Oct 2023 04:33:54 -0700 (PDT)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b0032d8913f3dasm12847346wrd.97.2023.10.16.04.33.52
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:33:54 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:33:48 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Subject: isimodem/n900: CLIP and list-operators not working under Alpine Linux
Message-ID: <ZS0fnIsQP9t8V-kY@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Since a number of versions ago, the Nokia N900 modem does not return
anything to the `list-operators` command under Alpine/PostmarketOS [1].
With recent testing, it was found that even the CLIP is not displayed on
an incoming call.

However, both `list-operators` and CLIP are working fine in Maemo Leste,
a distribution derived from Debian.

The major difference between Maemo Leste and PostmarketOS is that the
former is a glibc distro, while the latter uses musl. I am mentioning
this in case it is useful, otherwise I have not yet found anything
specific between the two libraries that could cause the observed
differences.

By enabling the environment variables OFONO_ISI_DEBUG and
OFONO_ISI_TRACE, I was able to establish that, at least for the CLIP
issue, in both cases, the modem provides the CLIP details to ofono, but
somehow it gets processed differently. In order for my tests to be
consistent, I used the same ofono version in both Maemo and postmarketOS
(1.34.8).

With Maemo Leste (glibc), the following snippet is seen ("X" characters
are the calling phone number, redacted)

ofonod[4233]: PN_CALL (0x01): CALL_SERVER_STATUS_IND [id=0x10 utid=0x01 len=4]:
ofonod[4233]:     * 01 10 01 00                                     : .....
ofonod[4233]: gisi: Success IND to 0x56dc40 [res=0x01, id=0x10, utid=0x01]
ofonod[4233]: src/audio-settings.c:ofono_audio_settings_active_notify() active 1
ofonod[4233]: PN_CALL (0x01): CALL_COMING_IND [id=0x03 utid=0x02 len=32]:
ofonod[4233]:     * 02 03 01 02 07 04 01 01 01 18 21 30 00 08 00 3X : ...........!0...X
ofonod[4233]:     * 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 00 : .X.X.X.X.X.X.X..
ofonod[4233]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x03 len=40]:
ofonod[4233]:     * 03 0F 01 04 0A 04 02 00 07 04 01 01 01 18 21 30 : ...............!0
ofonod[4233]:     * 00 08 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X : ...X.X.X.X.X.X.X
ofonod[4233]:     * 00 3X 00 00 BE 04 00 00                         : .X......
ofonod[4233]: gisi: Success IND to 0x56da48 [res=0x01, id=0x0F, utid=0x03]
ofonod[4233]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_COMING (0x02)
ofonod[4233]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x04 len=12]:
ofonod[4233]:     * 04 0F 01 02 0A 04 03 00 07 04 01 01             : .............
ofonod[4233]: gisi: Success IND to 0x56da48 [res=0x01, id=0x0F, utid=0x04]
ofonod[4233]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_PROCEEDING (0x03)
ofonod[4233]: PN_CALL (0x01): CALL_MT_ALERT_IND [id=0x05 utid=0x05 len=4]:
ofonod[4233]:     * 05 05 01 00                                     : .....
ofonod[4233]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x06 len=12]:
ofonod[4233]:     * 06 0F 01 02 0A 04 05 00 07 04 01 01             : .............
ofonod[4233]: gisi: Success IND to 0x56da48 [res=0x01, id=0x0F, utid=0x06]
ofonod[4233]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_MT_ALERTING (0x05)
ofonod[4233]: drivers/isimodem/voicecall.c:isi_call_notify() id=1,terminated,4,"XXXXXXXX","",161,0
ofonod[4233]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, status: incoming (4), id: 1, number: XXXXXXX called_number: , called_name
ofonod[4233]: src/voicecall.c:ofono_voicecall_notify() Did not find a call with id: 1


With postmarketOS, the same incoming call event returns the following:

ofonod[27080]: PN_CALL (0x01): CALL_SERVER_STATUS_IND [id=0x10 utid=0x01 len=4]:
ofonod[27080]:     * 01 10 01 00                                     : .....
ofonod[27080]: gisi: No error information IND to 0xb6c8ae90 [res=0x01, id=0x10, utid=0x01]
ofonod[27080]: src/audio-settings.c:ofono_audio_settings_active_notify() active 1
ofonod[27080]: PN_CALL (0x01): CALL_COMING_IND [id=0x03 utid=0x02 len=32]:
ofonod[27080]:     * 02 03 01 02 07 04 01 01 01 18 21 30 00 08 00 3X : ...........!0...X
ofonod[27080]:     * 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 0X : .X.X.X.X.X.X.X..
ofonod[27080]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x03 len=40]:
ofonod[27080]:     * 03 0F 01 04 0A 04 02 00 07 04 01 01 01 18 21 30 : ...............!0
ofonod[27080]:     * 00 08 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X 00 3X : ...X.X.X.X.X.X.X
ofonod[27080]:     * 00 3X 00 00 BE 04 00 00                         : .X......
ofonod[27080]: gisi: No error information IND to 0xb6c93e10 [res=0x01, id=0x0F, utid=0x03]
ofonod[27080]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_COMING (0x02)
ofonod[27080]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x04 len=12]:
ofonod[27080]:     * 04 0F 01 02 0A 04 03 00 07 04 01 01             : .............
ofonod[27080]: gisi: No error information IND to 0xb6c93e10 [res=0x01, id=0x0F, utid=0x04]
ofonod[27080]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_PROCEEDING (0x03)
ofonod[27080]: PN_NETWORK (0x0A): NET_RSSI_IND [id=0x1E utid=0x00 len=4]:
ofonod[27080]:     * 00 1E 64 5D                                     : ...d]
ofonod[27080]: gisi: No error information IND to 0xb6c8f1e0 [res=0x0A, id=0x1E, utid=0x00]
ofonod[27080]: src/network.c:ofono_netreg_strength_notify() strength 100
ofonod[27080]: PN_CALL (0x01): CALL_MT_ALERT_IND [id=0x05 utid=0x05 len=4]:
ofonod[27080]:     * 05 05 01 00                                     : .....
ofonod[27080]: PN_CALL (0x01): CALL_STATUS_IND [id=0x0F utid=0x06 len=12]:
ofonod[27080]:     * 06 0F 01 02 0A 04 05 00 07 04 01 01             : .............
ofonod[27080]: gisi: No error information IND to 0xb6c93e10 [res=0x01, id=0x0F, utid=0x06]
ofonod[27080]: drivers/isimodem/voicecall.c:isi_call_notify() called with status=CALL_STATUS_MT_ALERTING (0x05)
ofonod[27080]: drivers/isimodem/voicecall.c:isi_call_notify() id=1,terminated,4,"","",128,2
ofonod[27080]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall event, status: incoming (4), id: 1, number:  called_number: , called_name
ofonod[27080]: src/voicecall.c:ofono_voicecall_notify() Did not find a call with id: 1


From this it can be seen that the modem provided the same information to
ofono, but the evaluation was different in the two cases. Maemo returns
phone number type as 161, and clip_validity as 0, while postmarketOS
returns 128 and 2, respectively, in the isi_call_notify function of
drivers/isimodem/voicecall.c.

I would like to debug the issue further, and will appreciate any
pointers that may help me.

Regards
Sicelo

[1] https://gitlab.com/postmarketOS/pmaports/-/issues/86
