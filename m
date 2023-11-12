Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D619458
	for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5pGUOUW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40806e4106dso21572695e9.1
        for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699821993; x=1700426793; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGxbZPifPn5/1JZOrpTNnQjwvOFNWGxTbV7NFbCu0sI=;
        b=d5pGUOUWxBZOeDdFG02uA0A3f8FbmEog8oQvhoS8vVtDkz6XJYvy62hK8a3G+cSUa9
         +FVOZUfjVTWTfhT6uZf2ymqTmzasxhfu34/Ns384MTzo7VBe7gjkqI/9TQDxelEjm9e5
         GTY90FvbZfsEqWSmXx9kjrD/ag9tf77i9ytEICc9ITPdBO2xRvVW/CXDL0ZmFeWlVgZl
         yNgtQHc3v8Els5Ll96/lidHP2527aWfON6arFucSntysd0LgvOehLpyBKQIuBAsei1Wi
         ENUSE/pof3htug59cd/+DYQPnLgr3BSqX+vpjdgIKKH+oGgqAJKlCCmnPX+/P3Ua8QCa
         +poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699821993; x=1700426793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGxbZPifPn5/1JZOrpTNnQjwvOFNWGxTbV7NFbCu0sI=;
        b=amU30T30SNPH/Mv4WmTwAFf6d1LhqpzzdpBrYIWI+vAN7mRgiTWNl0MQNaIVu3rvI4
         v2TurXBekPFV+dUB11E828jAgm1FxHGBmWRnzEebvB9L5UbhG68mZ/ZzWR35cTzS90BM
         bh8J4BJbJqmrgSumwWlJghWNHF8gLoyW9qjsmMrpuwT+8ZxGuCAH8bF2b8OzUH3olNKG
         YVCn3e8mjzsWar6VGWqFlLPA9qKa5w9LMYxeAcTU/+xLroAtjxztC79JqbAWnjZ1daJM
         u+VRe5UxaJRfp1EeBE/Hfs9jSybvlXmkLASzKm+43xaed4YawAYXpgqhipClpl/bUx3z
         3lag==
X-Gm-Message-State: AOJu0Yzpo1rujmZZnZ3prg4GoVP7ViYhp0sVS94DLq7ZIn0qvn/D3pm1
	mny8lc+E6DThkkhwxNutIxU=
X-Google-Smtp-Source: AGHT+IEXr1ZmVmRnc5HWEw4QCUYOqY59VlLoPK3cBAskdfwFKtQC5bRtrnn2lz/WvI5YVHNtyMt7xw==
X-Received: by 2002:a05:600c:997:b0:406:45c1:4dd with SMTP id w23-20020a05600c099700b0040645c104ddmr8025550wmp.14.1699821992595;
        Sun, 12 Nov 2023 12:46:32 -0800 (PST)
Received: from tp440p.steeds.sam ([41.84.247.172])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c218600b00405c7591b09sm5841814wme.35.2023.11.12.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 12:46:32 -0800 (PST)
Date: Sun, 12 Nov 2023 22:46:28 +0200
From: Sicelo <absicsz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: isimodem: reporting operator name to core from unsolicited
 indications
Message-ID: <ZVE5pI_Eb8R8aKLk@tp440p.steeds.sam>
References: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
 <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>
 <ZUti7nteHmcie5a7@tp440p.steeds.sam>
 <13f52749-bc4f-4391-9447-5df660d3384b@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f52749-bc4f-4391-9447-5df660d3384b@gmail.com>

Hi Denis

On Wed, Nov 08, 2023 at 09:16:59AM -0600, Denis Kenzior wrote:
> > This is where my lack of skill gets exposed - reg_status_ind_cb only has
> > access to netreg of type ofono_netreg, and nd of type netreg_data.
> > However the notify function, as called from name_get_resp_cb, requires
> > to be passed structs of type ofono_netreg_operator_cb_t,
> > ofono_network_operator and isi_cb_data. I am not sure I see how to pass
> > these from reg_status_ind_cb.
> 
> You can't, but that's okay because you don't have to.  The flow is like this:
> 
> *unsolicited NET_REG_STATUS_IND notification from modem*
>   drivers/isimodem/network-registration.c: reg_status_ind_cb()
>     - parse operator name and store it in nd->nitz.
>     - parse network status
>     - Invoke ofono_netreg_status_notify
>   oFono Core ofono_netreg_status_notify
>     - registered or roaming, call current_operator() driver method

Thank you for your patience with my ineptitude here. I understand and
can follow nicely up to this point.

>   drivers/isimodem/network-registration.c: isi_current_operator()

isi_current_operator then calls (in my case),
  - create_name_get_req
  - when modem/network provides response to that _req, name_get_resp_cb
    is then called/run
  - name_get_resp_cb sees an error condition, while checking for
    NET_OPER_NAME_READ_RESP, then reports the callback has failed

>     - Return the nitz name
>

I agree that I want to return nitz_name (or other variable that is
suitable to use for caching the name) when the above check fails. The
question I am still unable to answer for myself is:

 * in name_get_resp_cb, how can i make the populated nd->nitz_name
   accessible/available for to use?

> Or better yet, fall back to returning the nitz name when name_get_resp_cb()
> fails somewhere in check_response_status(msg, NET_OPER_NAME_READ_RESP).

This also has the same question - I will need the populated
nd->nitz_name to be accessible in check_response_status, and I am not
sure how, yet.

In passing, I now also extract MCC and MNC from the other parts of
NET_MODEM_REG_STATUS_IND, so there are now two more pieces of
information to be shuffled around. Updated patch attached at the end of
this message.


Regards
Sicelo






From 691ef91c7c7ace745ca5ec04051210ade1097e69 Mon Sep 17 00:00:00 2001
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Date: Wed, 8 Nov 2023 23:33:23 +0200
Subject: [PATCH] reg_status_ind: parse operator names and mcc/mnc

---
 drivers/isimodem/debug.c                |  1 +
 drivers/isimodem/network-registration.c | 63 +++++++++++++++++++++++++
 drivers/isimodem/network.h              |  1 +
 3 files changed, 65 insertions(+)

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
index 8f70b3ee..1044dbee 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -192,6 +192,15 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
        struct ofono_netreg *netreg = data;
        struct netreg_data *nd = ofono_netreg_get_data(netreg);
        GIsiSubBlockIter iter;
+       struct ofono_network_operator op;
+
+       memset(&op, 0, sizeof(struct ofono_network_operator));
+
+       uint8_t len = 0;
+       uint8_t opername_type = 0;
+       char *long_opername = NULL;
+       char *alt_opername = NULL;
+       char *short_opername = NULL;

        if (netreg == NULL || nd == NULL)
                return;
@@ -209,16 +218,70 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)

                        if (!parse_common_info(&iter, &nd->reg))
                                return;
+
+                       /* Parse short operator name */
+                       if (!g_isi_sb_iter_get_byte(&iter, &len, 7))
+                               return;
+
+                       len *= 2;
+
+                       if (!g_isi_sb_iter_get_alpha_tag(&iter, &short_opername, len, 8))
+                               return;
                        break;

                case NET_GSM_REG_INFO:

                        if (!parse_gsm_info(&iter, &nd->gsm))
                                return;
+
+                       /* Parse mcc and mnc */
+                       if (!g_isi_sb_iter_get_oper_code(&iter, op.mcc,
+                                                               op.mnc, 8))
+                               return;
+                       break;
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
+                               /* Alternate full name (similar to long name, but may have less whitespace */
+                               g_isi_sb_iter_get_alpha_tag(&iter, &alt_opername, len, 6);
+                               break;
+                       case 3:
+                               /* Full name */
+                               g_isi_sb_iter_get_alpha_tag(&iter, &long_opername, len, 6);
+                               break;
+                       }
                        break;
                }
        }

+       if (long_opername[0] != '\0')
+               strncpy(nd->nitz_name, long_opername, OFONO_MAX_OPERATOR_NAME_LENGTH);
+       else if (alt_opername[0] != '\0')
+               strncpy(nd->nitz_name, alt_opername, OFONO_MAX_OPERATOR_NAME_LENGTH);
+       else if (short_opername[0] != '\0')
+               strncpy(nd->nitz_name, short_opername, OFONO_MAX_OPERATOR_NAME_LENGTH);
+
+       nd->nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
+
+       DBG("Short Oper: %s", short_opername);
+       DBG("Alt Oper: %s", alt_opername);
+       DBG("Long Oper: %s", long_opername);
+       DBG("MCC: %s, MNC: %s", op.mcc, op.mnc);
+       g_free(alt_opername);
+       g_free(long_opername);
+       g_free(short_opername);
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

--
2.42.0

