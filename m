Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886401D6195
	for <ofono@lists.linux.dev>; Wed, 28 May 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456245; cv=none; b=HrQEf9StEvSfQcZZs4lTKtminigXufkThibvE4CTaGKA6Rb8zoyrgIo7WPQXPWISqgUEPhsV0QQE5MHNjCPbvjV86RJ+Aft67e3b1nP3pmWKoU2wvyybGNkNEV5BYhoq3JfN8qpckPDUObC38WFlPitosrEBXmYy9aZxs7g6Kus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456245; c=relaxed/simple;
	bh=cnqJ9TXWKY8Kx9D/dDkXM793+Iyddh/ekpSF4VSOSFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=diwaD036lN9l9lW5vxE4tX0YwQ011MYNfRJu9+wK1S3HyGSh3ooMB13veik1PBN0t5qtaqT9u6QusFcpW8dkXAen6cnP7Tnm/3KnjfTkUKB+LCH/zIWTU4g3XtoqLOIkwiT5/3rUmgGIbxLRb2jXzPymi+zY6HSvKkWrtB7ajGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYKLm0Eh; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYKLm0Eh"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cc82edcf49so51764fac.1
        for <ofono@lists.linux.dev>; Wed, 28 May 2025 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748456241; x=1749061041; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWFLG7AccqrrOmkQSfkYzY617TejHbUT9u38puRevFY=;
        b=cYKLm0EhK5+4Sx2PhtIXtqIHhXsy7YykEhtw8z3qiRD9/yz0ONWYPr79n+OialM9wd
         Ss7m5l79OJ4pxV2Pn89vj3OP6HnD51nrrOyM/BVjH8wKnj1xNnwoi9EFR2WbdyuShR/H
         SBHS294rp6r65nHi+1iAXgg2JXTC+3Ab0iyC4+ySXU99y4YF8ErnlH89Fg3rVazF/8D/
         5cAusoVph6u8dZStsmn1H2oc15RSTRE1rTAhTMRyFTMWjLixS5Cp0A3WH3bX1LMJB6eT
         G/ul80eTsZ3WJuQ5LK9sjovjPM9/Np6/yIqeVaHUGr3fB2tNs2JQ3b7AqydT4Qu3L6ZP
         1U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456241; x=1749061041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWFLG7AccqrrOmkQSfkYzY617TejHbUT9u38puRevFY=;
        b=Q27Bx70We/ix2n3dx3+qyR46VE/tmuATvkmvfYfF2PGCuBBr3Tn6Rl/vsTCcRdvH7a
         TAHK4UGb5dTyIoROAWnqtcrfENfYP8NGeujAZbc7f31O8MErmg/d96ET56QABVUna+Nn
         IL9+ori4Nbg9tQEXrkZ9z9OmF6EtTGsFdcrOXa44nHAfXQUHNUZ/vvqFvhLkNN/TlUs2
         jCM0d0dnOtkrdV1tED3zEe2EeM31VXA3mMjaNaOw+ZLWWQafDFAeIOgE9N0dRK3CiHRV
         c9ANJHszjHryNzLXaKCOMfZz0V/FfuSisXecdb2xyCqfe79N/Y+nKVfXlDfFGrJRvYCE
         xMxw==
X-Forwarded-Encrypted: i=1; AJvYcCXF3fxUx+B8h7g/LsUVL6w53BpUM8RmKp9HbxsEyJBPW813IlWaOWDfLPE7UGVOHYvFOiYLYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6H8TQphvaV3hoBwGw5Jje5COu511kKUam24g+GpNm/8kuYvJp
	WwwJEl8CrGU4V/df/CDxAKBBmy62fcU52wjRBDP/UBvtO2F0dMZcPJXzu25AAA==
X-Gm-Gg: ASbGnctPiINwgz9FmDrNeX+yXORTDTxA0IN/gkg9vj9oD+EImeQ5HfE7O6XqgSoUxZE
	EPa5ewhTB50C8Ai3anHIBtk+IT/6WqOxjqJDr2ZTVWjfLSbItpoQxBYER8KsdeQQ+Tqya1jQb5W
	MLtz3C9RJOACb0Di0REL057eiDzdWPP8tJp0iY9A7EGDsTdHNMkjnGoWfQIc4k5cThTl1F6fUDc
	cn0VGpdt6H1VJej604wuZctPQ0Q0mk+gstVxQHkBXRUVwXdnfN6RxL0ccii3WX/qhjWDKeJS09v
	iv0hT018JIiwtCK3b/S2zgmBs0aIo7HXGtTajDZ8KQRd5kSPsVEFoIyT6JRnOoAlv1Tq+j7B+pA
	88Zc0tuhwPdtw1EZB
X-Google-Smtp-Source: AGHT+IH/yUHgZfxj+TH3J8OTvOrqEwj8Brjcu6aVlaadHvKr+7gLOkaBxicLwG2DE0zRConmd/pmrA==
X-Received: by 2002:a05:6870:1e86:b0:2c1:650b:fc86 with SMTP id 586e51a60fabf-2e861dc55c7mr8885439fac.1.1748456241191;
        Wed, 28 May 2025 11:17:21 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2e8e16be981sm332929fac.4.2025.05.28.11.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 11:17:20 -0700 (PDT)
Message-ID: <31df1157-aeca-4e03-a0d0-f4313becf90c@gmail.com>
Date: Wed, 28 May 2025 13:17:19 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sim7100: query until AT channel is ready
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250523131708.2225801-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250523131708.2225801-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 5/23/25 8:17 AM, Sean Nyekjaer wrote:
> It's seen that the AT channel contains unknown data upon power on.
> Query the modem until it answers with OK. Create a timer to re-issue
> the AT command at regular intervals until the modem answers OK.
> 
> plugins/sim7100.c:sim7100_enable()
> plugins/sim7100.c:open_device() devkey=AT
> src/modem.c:get_modem_property() modem 0x261f20 property AT
> plugins/sim7100.c:open_device() devkey=PPP
> src/modem.c:get_modem_property() modem 0x261f20 property PPP
> AT: > AT\r
> AT: < \r\r*A
> PPP: < \r\r*A
> AT: < AT\r
> plugins/sim7100.c:init_timeout_cb() 0x261f20
> AT: > AT\r
> AT: < AT\r
> AT: < \r\nOK\r\n
> AT: > ATE0Q0V1\r
> AT: < ATE0Q0V1\r\r\nOK\r\n
> AT: > AT+CGMM\r
> AT: < \r\nA7672E-FASE\r\n\r\nOK\r\n
> plugins/sim7100.c:cgmm_cb() modem model: A7672E-FASE
> plugins/sim7100.c:cgmm_cb() before CFUN
> AT: > AT+CFUN=4\r
> AT: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> PPP: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> AT: < \r\nOK\r\n
> plugins/sim7100.c:cfun_set_on_cb()
> src/modem.c:modem_change_state() old state: 0, new state: 1
> ---
> 
> Is this the way to do it? It's quite weird that the serial channel
> doesn't respond in a sane maner after power up.

I've never seen this before.  oFono does perform a tcflush() when opening the 
port, so this garbage must be coming in after the port has been opened.  I'm not 
sure what else could be done besides what you're doing here.

> 
> Before this patch ofono would get stuck in enable and transmit CFUN=4,
> our software would then restart ofono and everything would be fine
> again.
> I have done nearly 50 power cycles with this patch all being successful.
> 
>   plugins/sim7100.c | 75 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 62 insertions(+), 13 deletions(-)
> 
> diff --git a/plugins/sim7100.c b/plugins/sim7100.c
> index b6389b09..d52e5b92 100644
> --- a/plugins/sim7100.c
> +++ b/plugins/sim7100.c
> @@ -22,6 +22,7 @@
>   #include <glib.h>
>   #include <gatchat.h>
>   #include <gattty.h>
> +#include <ell/ell.h>
>   
>   #define OFONO_API_SUBJECT_TO_CHANGE
>   #include <ofono/plugin.h>
> @@ -57,6 +58,9 @@ struct sim7100_data {
>   	GAtChat *at;
>   	GAtChat *ppp;
>   	enum sim7x00_model model;
> +	struct l_timeout *init_timeout;
> +	size_t init_count;
> +	guint init_cmd;
>   };
>   
>   static void sim7100_debug(const char *str, void *user_data)
> @@ -154,6 +158,47 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   									NULL);
>   }
>   
> +

nit: No double empty lines please.

> +static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
> +{
> +	struct ofono_modem *modem = user_data;
> +	struct sim7100_data *data = ofono_modem_get_data(modem);
> +
> +	/* ensure modem is in a known state; verbose on, echo/quiet off */
> +	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
> +
> +	l_timeout_remove(data->init_timeout);
> +	data->init_timeout = NULL;
> +}
> +
> +static void close_serial(struct ofono_modem *modem)
> +{
> +	struct sim7100_data *data = ofono_modem_get_data(modem);
> +
> +	g_at_chat_unref(data->ppp);
> +	g_at_chat_unref(data->at);
> +	data->at = data->ppp = NULL;
> +}
> +
> +static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ofono_modem *modem = user_data;
> +	struct sim7100_data *data = ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (data->init_count++ >= 30) {
> +		ofono_error("failed to init modem after 30 attempts");
> +		close_serial(modem);

Do you also need ofono_modem_set_powered(modem, FALSE) here as well?  You're 
also leaking timeout here.  If this is a hot-pluggable modem, then the timeout 
also needs to be canceled / freed in .remove()

> +		return;
> +	}
> +
> +	g_at_chat_retry(data->at, data->init_cmd);
> +	l_timeout_modify_ms(timeout, 500);
> +}
> +
>   static int open_device(struct ofono_modem *modem, char *devkey, GAtChat **chat)
>   {
>   	DBG("devkey=%s", devkey);
> @@ -172,16 +217,22 @@ static int sim7100_enable(struct ofono_modem *modem)
>   
>   	DBG("");
>   
> -	err = open_device(modem, "AT", &data->at);
> -	if (err < 0)
> -		return err;
> -
> -	err = open_device(modem, "PPP", &data->ppp);
> -	if (err < 0)
> -		return err;
> -
> -	/* ensure modem is in a known state; verbose on, echo/quiet off */
> -	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> +	if (g_at_chat_get_channel(data->at) == NULL) {

What does this do?

> +		err = open_device(modem, "AT", &data->at);
> +		if (err < 0)
> +			return err;
> +
> +		err = open_device(modem, "PPP", &data->ppp);
> +		if (err < 0)
> +			return err;
> +
> +		data->init_count = 0;
> +		data->init_cmd = g_at_chat_send(data->at, "AT", NULL,
> +				init_cmd_cb, modem, NULL);
> +		data->init_timeout = l_timeout_create_ms(500, init_timeout_cb, modem,
> +				NULL);
> +		return -EINPROGRESS;
> +	}
>   
>   	/* query modem model string */
>   	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
> @@ -196,9 +247,7 @@ static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   
>   	DBG("");
>   
> -	g_at_chat_unref(data->ppp);
> -	g_at_chat_unref(data->at);
> -	data->at = data->ppp = NULL;
> +	close_serial(modem);

Just FYI, this change now makes CI complain:

     plugins/sim7100.c: In function 'cfun_set_off_cb':
     plugins/sim7100.c:246:30: error: unused variable 'data' 
[-Werror=unused-variable]
       246 |         struct sim7100_data *data = ofono_modem_get_data(modem);
           |                              ^~~~
     cc1: all warnings being treated as errors

>   
>   	if (ok)
>   		ofono_modem_set_powered(modem, FALSE);

Regards,
-Denis
