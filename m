Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009B23BD0E
	for <ofono@lists.linux.dev>; Thu, 24 Jul 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395956; cv=none; b=aCfxsgu2Pkv1Pj6mcsklui7iG7IjTGXI8azGf1f+Gb0Qn9JwHE7gmtksKZETgH5ijp1w9pkjOzQP2dSjQWO/ujWTzwogMvbgIYC8jyTLYMkKW5iRCR0qVV8EbJsvtv+Ma9IfvfhzCZmhXMgbYPj5MYUYc25YPES7BZcXPVKDtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395956; c=relaxed/simple;
	bh=BpLYDPaWiHUQeZaE/wE6eaCgie/I1YOQnFNQUMz0awc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAzEZeJ8wsDQHtuLJaFzUazIf4USiOD8Hjx+ok8ih7mipIAmlemFRM2On+xnJh8T3K10KCSyplhoCLE7LSkC0B0J0MSBB2kTYV+KYx1ldUnTu5xS+UdRSv4NLCwS6kS4QL9uMBPAsXUR0r4hud6gxpl2l+U/YKc/e+aVDfDb4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlqtoLZa; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlqtoLZa"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41b357ba04fso862226b6e.2
        for <ofono@lists.linux.dev>; Thu, 24 Jul 2025 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753395954; x=1754000754; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecLwSmOXUgxjaq8DCOgQFpcWewOcvKDRuHV0zDbyvX4=;
        b=RlqtoLZaU+wNIQ2jKm85Vnhtr90ILiqbdO2uXBgYxN0fbnL+lHPE9rWIflNmgKQIzA
         7rs7fxVGDMKtfy1uhCpj94SgtTdAGE+VlIByUaNhtVQAcF6kQkKcl2yDXXbXabmebcZy
         AIgZQxeC0aDnSB3c22FqGWalylrJgHDU1P6rSELHGkzBjv7t/JVUwpekTlu/Y/Cammfb
         AYXUe2zXorYgKpYoi0QYb+uACXBEygRZaDiJl4W6b6hESNAUR+9SLTOk8tt7JHADQehi
         EVwmptGSIH6Bi4eDZapgcEW+1bbevrPrw4+vOVOnhyOjnOiHW7rrKzANnS8hwXr4D22m
         yi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395954; x=1754000754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecLwSmOXUgxjaq8DCOgQFpcWewOcvKDRuHV0zDbyvX4=;
        b=VNXyyDlZUzbKvGUTbCMCE3+KPT2jMEOJEpmComb6SbvCI50oJTzXeh/tynYSW9Wada
         9oRb/S4MO2gag6DszVlEmqPJ6o7Q4eKtXn3X1QrOu4w3/DTo9LrXxIBlT2YS53CzkM8/
         CFjBW5tWJzkxTGVoEg+tD7rdCpH6V4hUnpVSTtq/S60qsdvtjhtWC+xClcMgNqAAnoVu
         ETVyui6tIdXkpKIAxTkozYwMzUBHm3znEe49ZCjPFpKI6b8ipkHf6ICK8lGu03EBugyn
         rlNsvtXGGyvwWNEs4unH5LR1/bDAHmyYg9MO/eNZAo7xIiiVVAraPHVe99YSSDH0r6rC
         Q/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVQlDXtXf3hOBkUd3gb0lq9CAf20fnVHzcye4z5LtqMGPdo8wD4Zek+ISyXUu22SEOaL+lstQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFJb/s7EsD5i0FzZZBVTya3FPaty3EXMsGyyI3BV9tJrmSZBMV
	bptztx2XNnvh8adtPFvwnlOeFAizqYi45PyqXPhWqWctuTte3kAb8GWv
X-Gm-Gg: ASbGncsPJFw25UTwF9PCX7uQvAnLWqi713FVUwHHaMAM6H9XlGdQTQodMdDALDs/j2P
	lOEMhbkbKA9BL/oZu75Aab5RvNSJMMsdifBHmDgRVxSU15ntirAv0WhBr4GuKO9dIl84ToDoUts
	SYpWDzau8VC6l1JcoWwyqzkhMzDaU2D2NjJrkhJ6urspHoRNHHvpP+uFsw7Kxxp1yVw2aiCDzrk
	oLbfM3Q4buM8ou5SYBo2aO9Cvqga74vmtL/+JLvTC+uoPsWYhDuzQAkIYM9CO0L317sItTTP8MC
	/ll8u+ZEZLeDUR6FlDsqzZErpJGDkvop72etPC8/8AKxLBSoogJ3FUHTc33CrFMYr3A2df6pQOJ
	0LAtzTmkORbWTauR30aAP5zken1XUL0NEvGiA9VVBSV2fLd4PTCobi2QtcJ9t1JKCdlZ5JpuV3P
	k=
X-Google-Smtp-Source: AGHT+IER2fCf5VdpmayL8pm3XmlkJoCd7Il124l9iQ/hHwevhQ6gK6wbbJtvZ/gQTUkRCy5wnlimOA==
X-Received: by 2002:a05:6808:1b24:b0:40b:4208:8038 with SMTP id 5614622812f47-426c47e90bcmr6567390b6e.4.1753395953955;
        Thu, 24 Jul 2025 15:25:53 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-42a33569f67sm390178b6e.39.2025.07.24.15.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:25:53 -0700 (PDT)
Message-ID: <436eb716-a827-4c10-a90d-1b7edc67400b@gmail.com>
Date: Thu, 24 Jul 2025 17:25:51 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: droid: migrate to QMI from AT
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250724053251.592383-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250724053251.592383-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 7/24/25 12:32 AM, Ivaylo Dimitrov wrote:
> Drop GAtChat usage and move to qmimodem
> ---
>   plugins/droid.c  | 487 +++++++++++++++++++++++++++++++++++++++++------
>   plugins/udevng.c |  30 ++-
>   2 files changed, 450 insertions(+), 67 deletions(-)
> 

So the first question that comes to mind is: Why can't the gobi plugin drive 
this device?  One thing I see that is different is that this plugin uses 
QMI_DMS_OPER_MODE_PERSIST_LOW_POWER instead of QMI_DMS_OPER_MODE_LOW_POWER.  You 
also skip / hard code a few things, but that can be special cased by introducing 
a new attribute or two, similar to 'AlwaysOnline'.

On the upside, you should might get multi-context support and MTU handling for free.

<snip>

> +static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
>   {
>   	struct ofono_modem *modem = user_data;
> +	struct droid_data *data = ofono_modem_get_data(modem);
> +	struct qmi_param *param;
> +	uint8_t mode;
>   
>   	DBG("");
>   
> -	if (ok)
> +	if (qmi_result_set_error(result, NULL)) {
> +		shutdown_device(modem);
> +		return;
> +	}
> +
> +	if (!qmi_result_get_uint8(result, QMI_DMS_RESULT_OPER_MODE, &mode)) {
> +		shutdown_device(modem);
> +		return;
> +	}

These shutdown_device(); return; lines might be better served by a goto/label.

> +
> +	data->oper_mode = mode;
> +
> +	switch (data->oper_mode) {
> +	case QMI_DMS_OPER_MODE_ONLINE:
> +		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> +					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
> +		if (!param) {
> +			shutdown_device(modem);
> +			return;
> +		}

ditto

> +
> +		if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
> +					power_reset_cb, modem, NULL) > 0)
> +			return;
> +
> +		shutdown_device(modem);
> +		break;

ditto

> +	default:
>   		ofono_modem_set_powered(modem, TRUE);
> +		break;
> +	}
>   }
>   

<snip>

> -static int droid_enable(struct ofono_modem *modem)
> +static void get_caps_cb(struct qmi_result *result, void *user_data)
>   {
> -	GAtChat *chat;
> +	struct ofono_modem *modem = user_data;
> +	struct droid_data *data = ofono_modem_get_data(modem);
> +	const struct qmi_dms_device_caps *caps;
> +	uint16_t len;
> +	uint8_t i;
>   
>   	DBG("");
>   
> -	chat = at_util_open_device(modem, "Device", droid_debug, "", NULL);
> -	ofono_modem_set_data(modem, chat);
> +	if (qmi_result_set_error(result, NULL))
> +		goto error;
>   
> -	/* ensure modem is in a known state; verbose on, echo/quiet off */
> -	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> +	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
> +	if (!caps)
> +		goto error;
>   
> -	/* power up modem */
> -	g_at_chat_send(chat, "AT+CFUN=1", NULL, cfun_set_on_cb, modem, NULL);
> +	DBG("service capabilities %d", caps->data_capa);
> +	DBG("sim supported %d", caps->sim_supported);
>   
> -	return 0;
> +	for (i = 0; i < caps->radio_if_count; i++)
> +		DBG("radio = %d", caps->radio_if[i]);
> +
> +	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
> +				get_oper_mode_cb, modem, NULL) > 0)
> +		return;
> +
> +error:
> +	shutdown_device(modem);

Like you do here :)

>   }
>   

<snip>

>   
> -static int droid_disable(struct ofono_modem *modem)
> +static void create_dms_cb(struct qmi_service *service, void *user_data)
> +{
> +	struct ofono_modem *modem = user_data;
> +	struct droid_data *data = ofono_modem_get_data(modem);
> +	struct service_request *request = NULL;
> +
> +	DBG("");
> +
> +	if (!service)
> +		goto error;
> +
> +	data->dms = service;
> +	request = l_queue_peek_head(data->service_requests);
> +
> +	if (qmi_qmux_device_create_client(data->qmux, request->service_type,
> +						create_service_cb, modem, NULL))
> +		return;
> +
> +error:
> +	shutdown_device(modem);
> +}

How is this function different from create_service_cb()?  Could you just use 
that one instead by queuing up a DMS request on the service_requests queue?

<snip>

> +
> +static int droid_disable(struct ofono_modem *modem)
> +{
> +	struct droid_data *data = ofono_modem_get_data(modem);
> +	struct qmi_param *param;
> +
> +	DBG("%p", modem);
> +
> +	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> +				QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
> +	if (!param)
> +		return -ENOMEM;
> +
> +	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
> +				power_disable_cb, modem, NULL) > 0)
> +		return -EINPROGRESS;

Leaking param here

>   
> -	if (sim)
> -		ofono_sim_inserted_notify(sim, TRUE);
> +	shutdown_device(modem);
> +
> +	return -EINPROGRESS;
> +}

<snip>

> +
> +/* Only some QMI features are usable, voicecall and sms are custom */

Not quite sure what this comment means?  I don't see any vendor customization 
for voicecalls or sms?  Maybe comment is stale?

> +static void droid_pre_sim(struct ofono_modem *modem)
> +{
> +	struct droid_data *data = ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "qmimodem",
> +				qmi_service_clone(data->dms));
> +	ofono_sim_create(modem, 0, "qmimodem",
> +				qmi_service_clone(data->dms),
> +				qmi_service_clone(data->uim));
> +	ofono_voicecall_create(modem, 0, "qmimodem",
> +				qmi_service_clone(data->voice));
> +	ofono_location_reporting_create(modem, 0, "qmimodem",
> +					l_steal_ptr(data->pds));
>   }
>   
>   static void droid_post_sim(struct ofono_modem *modem)
>   {
> -	GAtChat *chat = ofono_modem_get_data(modem);
> +	struct droid_data *data = ofono_modem_get_data(modem);
>   	struct ofono_message_waiting *mw;
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +	const char *interface;
>   
> -	DBG("");
> +	DBG("%p", modem);
> +
> +/*	ofono_phonebook_create(modem, 0, "qmimodem", data->qmux);*/

Remove?

> +	ofono_radio_settings_create(modem, 0, "qmimodem",
> +					qmi_service_clone(data->dms),
> +					qmi_service_clone(data->nas));
>   
> -	ofono_ussd_create(modem, 0, "atmodem", chat);
> -	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
> -	ofono_call_settings_create(modem, 0, "atmodem", chat);
> -	ofono_netreg_create(modem, 0, "atmodem", chat);
> -	/*
> -	 * Droid 4 modem has problems with AT+CPUC?, avoid call meter for now.
> -	 */
> -	ofono_call_barring_create(modem, 0, "atmodem", chat);
> -	ofono_sms_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
> -	ofono_phonebook_create(modem, 0, "atmodem", chat);
> +	ofono_sms_create(modem, 0, "qmimodem",
> +				qmi_service_clone(data->wms));
>   
>   	mw = ofono_message_waiting_create(modem);
>   	if (mw)
>   		ofono_message_waiting_register(mw);
> +
> +	gprs = ofono_gprs_create(modem, 0, "qmimodem",
> +					qmi_service_clone(data->wds),
> +					qmi_service_clone(data->nas));
> +	if (!gprs) {
> +		ofono_warn("Unable to create gprs for: %s",
> +				ofono_modem_get_path(modem));
> +		return;
> +	}
> +
> +	gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
> +					qmi_service_clone(data->wds_ip4),
> +					qmi_service_clone(data->wds_ip6));
> +	if (!gc) {
> +		ofono_warn("Unable to create gprs-context for: %s",
> +				ofono_modem_get_path(modem));
> +		return;
> +	}
> +
> +	ofono_gprs_add_context(gprs, gc);
> +	interface = ofono_modem_get_string(modem, "NetworkInterface");
> +	ofono_gprs_context_set_interface(gc, interface);
> +}
> +

<snip>

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 320cd3a6..7777996d 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -870,7 +870,9 @@ static gboolean setup_telitqmi(struct modem_info *modem)
>   
>   static gboolean setup_droid(struct modem_info *modem)
>   {
> -	const char *at = NULL;
> +	const struct device_info *qmi = NULL;
> +	const struct device_info *net = NULL;
> +
>   	GSList *list;
>   
>   	DBG("%s", modem->syspath);
> @@ -878,21 +880,29 @@ static gboolean setup_droid(struct modem_info *modem)
>   	for (list = modem->devices; list; list = list->next) {
>   		struct device_info *info = list->data;
>   		const char *subsystem =
> -			udev_device_get_subsystem(info->udev_device);
> -
> -		DBG("%s %s %s %s %s", info->devnode, info->interface,
> -				info->number, info->label, subsystem);
> +				udev_device_get_subsystem(info->udev_device);
> +		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
> +						info->number, info->label,
> +						info->sysattr, subsystem);
>   
> -		if (g_strcmp0(info->interface, "255/255/255") == 0 &&
> -				g_strcmp0(info->number, "04") == 0) {
> -			at = info->devnode;
> +		if (g_strcmp0(subsystem, "usbmisc") == 0) {
> +			if (g_strcmp0(info->number, "05") == 0)
> +				qmi = info;
> +		} else if (g_strcmp0(subsystem, "net") == 0) {
> +			if (g_strcmp0(info->number, "05") == 0)
> +				net = info;
>   		}
>   	}
>   
> -	if (at == NULL)
> +	if (qmi == NULL || net == NULL)
> +		return FALSE;
> +
> +	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
> +
> +

No double empty lines please

> +	if (setup_qmi_qmux(modem, qmi, net) < 0)
>   		return FALSE;
>   
> -	ofono_modem_set_string(modem->modem, "Device", at);
>   	ofono_modem_set_driver(modem->modem, "droid");
>   
>   	return TRUE;

Regards,
-Denis
