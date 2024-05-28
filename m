Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF313B5B9
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884832; cv=none; b=DDZwKnQxGSgh+QEzEyzssrVwVPrxsPJqUk2FtOS6tecwPH5bKj70xoHCVRkBnc042BcpdAqOSMrnQUCzOJ8jbzkCsVapt51QIvUinpd+h/3ZyQssrgLs+051mDjwdXMjEJhZKlWwqgx9VcLFn5j9rTZ0gnElNTyisVKFyjRvSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884832; c=relaxed/simple;
	bh=2VCQCZWAL7Hrk8o0hKl7ESz8l8wlB9FCI6E01BV9evw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLQ/WBxxEbjsVkFTR8e0nh99W6nz1WFz9k0ouBWxWBnnnFl3rDv8IaUJIESPazv9ec8W8vihhSDIykRWCK9oYhsKfj0cF6kcjCHZUuabFHO28xLFTTrtr4ozVreWo2v/tIBGsFe/PdtdRrgT7sy7pzEzwnt2PLzPlv+/PgjflK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wAjLZoVU; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wAjLZoVU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=sesTDXCtkUhrwepGkTATrPMmpieT/o32gobqzEJlzDQ=; b=wAjLZoVUiyWW/J5PqAZoHlOgRr
	enZhS1IaCOvWtv8FbqwsVo0tzgG7hGSKtlBONn3OBtmHImtSx9+/Fa0WpSkA0Q7BEBFXNi2/I90TS
	XdXfNlpZ5g4wGDQIUZa2eqzOVcM78euga8PcHedu3IKJaDKIfMXg1jO1nPEL27V3DPiYKWIoNGM5y
	llI01CrbJs4+X/nbqrs6DjjQi76wHjTdMYNR3dF4/d+nZIi3k6ZdJvIQiDY9mnun1A7pyZ08unQMb
	mY/xSkJYC/eOxIwPk/sxpLGNrm3XrqLImkfeyT1QH7YwBtwMNOox/azR0jbpEGKJnFKGmIp3TMXC4
	wfykg6Ow==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1sBsAe-000My3-Eu; Tue, 28 May 2024 10:27:00 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1sBsAd-000E3e-2j;
	Tue, 28 May 2024 10:27:00 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] quectel: fix use after free
Date: Tue, 28 May 2024 10:26:47 +0200
Message-ID: <20240528082648.2010586-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27288/Mon May 27 10:29:01 2024)

Exitting ofono before going online with a quectel modem procudes the
following use-after-free error:

^Cofonod[776]: Terminating
=================================================================
==776==ERROR: AddressSanitizer: heap-use-after-free on address 0xb4150734 at pc 0x005ad063 bp 0xbefa26c0 sp 0xbefa26c4
READ of size 4 at 0xb4150734 thread T0
    #0 0x5ad060 in ofono_sim_remove_file_watch ../git/src/sim.c:2621
    #1 0x5ad060 in unwatch_sim_ecc_numbers ../git/src/voicecall.c:2820
    #2 0x5ad060 in voicecall_unregister ../git/src/voicecall.c:2849
    #3 0x57f910 in __ofono_atom_unregister ../git/src/modem.c:336
    #4 0x57f910 in __ofono_atom_unregister ../git/src/modem.c:329
    #5 0x57f910 in flush_atoms ../git/src/modem.c:492
    #6 0x57f910 in modem_change_state ../git/src/modem.c:586
    #7 0x58013e in set_powered ../git/src/modem.c:974
    #8 0x58054a in __ofono_modem_shutdown ../git/src/modem.c:2279
    #9 0x58054a in signal_handler ../git/src/main.c:85

0xb4150734 is located 4 bytes inside of 8-byte region [0xb4150730,0xb4150738)
freed by thread T0 here:
    #0 0xb6a88110  (/lib/libasan.so.8+0x97110) (BuildId: 1374acedfadbe21a32d37a0a1f15e27d16516851)
    #1 0x641216 in sim_fs_free ../git/src/simfs.c:123
    #2 0x641216 in sim_fs_free ../git/src/simfs.c:103
    #3 0x5de12c in sim_remove ../git/src/sim.c:3239
    #4 0x57f95a in flush_atoms ../git/src/modem.c:495
    #5 0x57f95a in modem_change_state ../git/src/modem.c:586
    #6 0x58013e in set_powered ../git/src/modem.c:974
    #7 0x58054a in __ofono_modem_shutdown ../git/src/modem.c:2279
    #8 0x58054a in signal_handler ../git/src/main.c:85

previously allocated by thread T0 here:
    #0 0xb6a8891c in __interceptor_calloc (/lib/libasan.so.8+0x9791c) (BuildId: 1374acedfadbe21a32d37a0a1f15e27d16516851)
    #1 0x597b3e in sim_fs_context_new ../git/src/simfs.c:155
    #2 0x597b3e in ofono_sim_context_create ../git/src/sim.c:2549
    #3 0x597b3e in watch_sim_ecc_numbers ../git/src/voicecall.c:2925
    #4 0x57f506 in call_watches ../git/src/modem.c:314
    #5 0x4977be in at_clck_query_cb ../git/drivers/atmodem/sim.c:1612
    #6 0x556cf4 in at_chat_finish_command ../git/gatchat/gatchat.c:465
    #7 0x5583ae in at_chat_handle_command_response ../git/gatchat/gatchat.c:527
    #8 0x5583ae in have_line ../git/gatchat/gatchat.c:606
    #9 0x5583ae in new_bytes ../git/gatchat/gatchat.c:765
    #10 0x559ef6 in received_data ../git/gatchat/gatio.c:122
    #11 0x563400 in dispatch_sources ../git/gatchat/gatmux.c:184
    #12 0x56402c in received_data ../git/gatchat/gatmux.c:272

The reason is the voicecall atom holding a reference to the sim atom,
which is read in the voicecall_unregister() path. Avoid the error by
simply instantiating the sim atom before the voicecall atom, which makes
the latter being unregistered first.
---
 plugins/quectel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 18cc3312..3586864f 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1343,8 +1343,8 @@ static void quectel_pre_sim(struct ofono_modem *modem)
 
 	ofono_devinfo_create(modem, data->vendor, "atmodem", data->aux);
 
-	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
 	sim = ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
+	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
 
 	if (data->sim_locked || data->sim_ready)
 		ofono_sim_inserted_notify(sim, true);
-- 
2.44.0

