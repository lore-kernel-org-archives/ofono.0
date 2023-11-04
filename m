Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5A79F5
	for <ofono@lists.linux.dev>; Sat,  4 Nov 2023 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0L/xLGr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4084de32db5so27003545e9.0
        for <ofono@lists.linux.dev>; Sat, 04 Nov 2023 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699113532; x=1699718332; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvrPLlHblcgCSVrpKwoL1s1LMfo+4LwpICujcXk9Xhk=;
        b=e0L/xLGrxNXXpcmz1i9atZHLBoKK7JeYsvNdQRgQyGUApy7mUAwsMCbfxj6cTd1udW
         +RMWa8pgugRXZZn+Ncikwo0A7ybOq5ojfN3FdtmAUhJZUCNTNk2MJYi/Gm5p0NFIp7Qw
         0hXQNb6a9Iys0SK1OxvEOCkbgB9d3wimD+oDmuhfVGxMj0vZ8ShPNtocY22lo/l7/iFE
         C68mvuL2PAxaTcsthP1NzK6t92y+VspKUvNXq4DG7YMzhAcHq2A1Jt4AUpPLhplpPn5N
         PxTFINhae5Tlw5sOfFCe9SQZdCAQ2s+hUe6unSGwQ/haf9bVR2U43trmoeCUgx+JPimu
         Nr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699113532; x=1699718332;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvrPLlHblcgCSVrpKwoL1s1LMfo+4LwpICujcXk9Xhk=;
        b=gdnI6dyHdJCdx1SwzgRNr+6Y95oMZP4FWY2oNtfK/EJMnkxNTWSJDNNdG11jDqT2dc
         bU2veKXD4Nxu1EHA8G5j1iX0RYb9ohkxJgLH6YmpM0s3DNdpbJ1UPCOjhB68O4ThjQwP
         mUrVi5MRsOzgIa/B+5c8dinp7vzMCkM/1cIkIG3FzG5hJdGKmjO+5TRz55ybDEQLWcb+
         LBvH3XsImZmun3eqjcCifXk3U1eP10Q4DhhtZ8K4PTLRieLOnSiHNs5XZSRDeLrbOxvY
         YET6lhVq3uuJAZ1nSo64MhH4EkrY5rS5DhuLPdOD5oz6FQ7dsWnVbCDWZQsQz33LjPN2
         lqpw==
X-Gm-Message-State: AOJu0YzQ0GfQF15P9/aVpz0YaYQyupDVY72aYdUfbZTndYNfRD+PJGgE
	pyLkvmGyu4LSibjpPYwkzx5vp/OmuFoiZQ==
X-Google-Smtp-Source: AGHT+IFdiuj5xE4Pi6N96no6wxumC2EusMeSdU+/gHA9YckkE84K9f2xTy4/k8st4+SbDf/6x1SsGA==
X-Received: by 2002:a05:600c:a4c:b0:409:6737:326b with SMTP id c12-20020a05600c0a4c00b004096737326bmr7199594wmq.11.1699113531992;
        Sat, 04 Nov 2023 08:58:51 -0700 (PDT)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id q24-20020a7bce98000000b0040648217f4fsm6029232wmj.39.2023.11.04.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 08:58:51 -0700 (PDT)
Date: Sat, 4 Nov 2023 17:58:25 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: isimodem: reporting operator name to core from unsolicited
 indications
Message-ID: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

With isimodem (on Nokia N900), there are cases where the request to get
the current operator name fails. This seems to be operator-specific,
since it works fine with other operators for exactly the same raw
packets.  The ISI trace looks something like:

	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_REQ [id=0xE5 utid=0x2E len=8]:
	ofonod[27080]:     * 2E E5 00 3F 00 00 00 00                         : ....?....
	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_RESP [id=0xE6 utid=0x2E len=10]:
	ofonod[27080]:     * 2E E6 01 00 00 00 00 00 00 00                   : ...........
	ofonod[27080]: gisi: normal RESP to 0xb6c8d0e0 [res=0x0A, id=0xE6, utid=0x2E]
	ofonod[27080]: drivers/isimodem/network-registration.c:check_response_status() Request failed: NET_CAUSE_COMMUNICATION_ERROR
	ofonod[27080]: src/network.c:current_operator_callback() 0x57c940, 0
	ofonod[27080]: src/network.c:current_operator_callback() Error during current operator

However, there are also some frequent unsolicited NET_REG_STATUS_IND
messages that contain the operator name (SZ 02/Eswatini Mobile in the
snippet below):

	ofonod[27080]: PN_NETWORK (0x0A): NET_REG_STATUS_IND [id=0xE2 utid=0x00 len=124]:
	ofonod[27080]:     * 00 E2 00 04 00 18 00 02 00 00 00 05 00 53 00 5A : ..............S.Z
	ofonod[27080]:     * 00 20 00 30 00 32 01 00 01 00 00 00 09 18 01 2D : ...0.2.........-
	ofonod[27080]:     * 00 64 7A 36 56 F3 20 02 00 01 02 01 01 00 00 1F : .dz6V...........
	ofonod[27080]:     * 01 01 01 00 E3 24 03 00 00 0F 00 45 00 73 00 77 : .....$.....E.s.w
	ofonod[27080]:     * 00 61 00 74 00 69 00 6E 00 69 00 20 00 4D 00 6F : .a.t.i.n.i...M.o
	ofonod[27080]:     * 00 62 00 69 00 6C 00 65 E3 24 02 00 00 0E 00 45 : .b.i.l.e.$.....E
	ofonod[27080]:     * 00 73 00 77 00 61 00 74 00 69 00 6E 00 69 00 4D : .s.w.a.t.i.n.i.M
	ofonod[27080]:     * 00 6F 00 62 00 69 00 6C 00 65 00 00             : .o.b.i.l.e..
	ofonod[27080]: gisi: No error information IND to 0xb6c8f2a0 [res=0x0A, id=0xE2, utid=0x00]

They are handled by isimodem/network-registration.c:reg_status_ind_cb,
which currently does not extract the operator name info.

I have written some initial code (attached at the end of this email)
that is able to extract the operator name in the `reg_status_ind_cb`
function. The challenge so far is that I have not figured out how to
report this operator name to core.

Storing it in `nd->nitz_name` as in the `name_ind_cb` function,
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers/isimodem/network-registration.c#n882
does not appear to be enough, since this does not have a related 'sync'
to core. So I think that function is also not fully functionally yet.

I would appreciate some pointers/suggestions, then I can test on device
and submit a proper patch.

Sincerely
Sicelo



diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 18055791..8edcd972 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -1190,6 +1190,7 @@ const char *net_subblock_name(enum net_subblock value)
                _(NET_REGISTRATION_CONF1_INFO);
                _(NET_ROAMING_CONF1_INFO);
                _(NET_AVAIL_NETWORK_INFO_COMMON);
+               _(NET_REG_STATUS_IND_OPER_NAME);
                _(NET_OPER_NAME_INFO);
        }
        return "NET_<UNKNOWN>";
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/network-registration.c
index 8f70b3ee..f36f8472 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -174,6 +174,15 @@ static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgid)
 
 static gboolean parse_common_info(GIsiSubBlockIter *iter, struct reg_info *reg)
 {
+       uint8_t len;
+       char *tag = NULL;
+       if (g_isi_sb_iter_get_byte(iter, &len, 7)) {
+               len *= 2;
+               if (g_isi_sb_iter_get_alpha_tag(iter, &tag, len, 8)) {
+                       DBG("Short operator name is %s", tag);
+                       g_free(tag);
+               }
+       }
        return reg && g_isi_sb_iter_get_byte(iter, &reg->status, 2) &&
                g_isi_sb_iter_get_byte(iter, &reg->mode, 3);
 }
@@ -193,6 +202,11 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
        struct netreg_data *nd = ofono_netreg_get_data(netreg);
        GIsiSubBlockIter iter;
 
+       uint8_t len = 0;
+       uint8_t opername_type = 0;
+       char *long_opername = NULL;
+       char *alt_opername = NULL;
+
        if (netreg == NULL || nd == NULL)
                return;
 
@@ -216,9 +230,44 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
                        if (!parse_gsm_info(&iter, &nd->gsm))
                                return;
                        break;
+
+               case NET_REG_STATUS_IND_OPER_NAME:
+
+                       if (!g_isi_sb_iter_get_byte(&iter, &opername_type, 2))
+                               return;
+
+                       if (!g_isi_sb_iter_get_byte(&iter, &len, 5))
+                               return;
+
+                       /* Name is UCS-2 encoded */
+                       len *= 2;
+
+                       switch (opername_type) {
+                       case 2:
+                               /* Alternate full operator name */
+                               g_isi_sb_iter_get_alpha_tag(&iter, &alt_opername, len, 6);
+                               break;
+                       case 3:
+                               /* Full operator name */
+                               g_isi_sb_iter_get_alpha_tag(&iter, &long_opername, len, 6);
+                               break;
+                       }
+                       break;
                }
        }
 
+       if (long_opername[0] != '\0') {
+               strncpy(nd->nitz_name, long_opername, OFONO_MAX_OPERATOR_NAME_LENGTH);
+               nd->nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
+       } else if (alt_opername[0] != '\0') {
+               strncpy(nd->nitz_name, alt_opername, OFONO_MAX_OPERATOR_NAME_LENGTH);
+               nd->nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
+       }
+       g_free(alt_opername);
+       g_free(long_opername);
+
+       DBG("Operator name is %s", nd->nitz_name);
+
        ofono_netreg_status_notify(netreg, isi_status_to_at_status(&nd->reg),
                                        nd->gsm.lac, nd->gsm.ci,
                                        isi_to_at_tech(&nd->rat, &nd->gsm));
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index 7449a1d0..3282b383 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -90,6 +90,7 @@ enum net_subblock {
        NET_REGISTRATION_CONF1_INFO =                   0x59,
        NET_ROAMING_CONF1_INFO =                        0x5A,
        NET_AVAIL_NETWORK_INFO_COMMON =                 0xE1,
+       NET_REG_STATUS_IND_OPER_NAME =                  0xE3,
        NET_OPER_NAME_INFO =                            0xE7,
 };

