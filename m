Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABF244697
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422307; cv=none; b=ZsymtNWRfcbcd6ESmo07gB1bvzhA5Bqo0SGV4FKQMYqZROdjaZ822tkhBDKKwyPhOwTVLlnI249NUD6iiIjXINB2Ew+ucWeHAvHuyBWBJ1KEPjcUjS2M3yKDb4Fjdv7+qob/qHogB5+osLJ8aqwXTeZUy3GYRItbxjOyteAbeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422307; c=relaxed/simple;
	bh=Esg1km71ufIKlR071cv5QPOf15JfkpFqtGeOT0LShlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJP33NwfWdfx5Tk6hAkyJbETO1G6UYGyvS2f6/9jB+J2VT9t57vB3yTdhqxzKEpNNEEdL4HeoIe37PSolfR4yo/KD6x8eMf5dzu2DY1TE4IihGmyLt87VxnR4vxN0lWPTKEzgd2uy9N+jcXzaojB7u3PzzEmVIYf1TZXxGFPR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8oNI7n4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8oNI7n4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so322205266b.1
        for <ofono@lists.linux.dev>; Thu, 24 Jul 2025 22:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753422304; x=1754027104; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGWYuGGg+RkXmCYlUBkjSly8s4a2L5VH0Q8IxyQVMGM=;
        b=F8oNI7n4HvF478hbhYkw0CDi8l8ZAQfpGnVhW7iEWJd2PkPZ3epKj3qeRRMlYq7bkY
         MkK4nlXaypDTCGl+qTxWg4miwm9XgYX0SZBQZgfgK4qSjd/bOHDEBM03+VhJivfmzdbp
         ytMML6C4O5jNYLdnMznpwiQ1a4jLV0q16Ekpr9ru5QALzQ3+gVfvC3LWKWMfBylHZ8dW
         ygBhypSGSz2z7KbHpPD1EuU54+I8TnYMpWZM2PPgwh68Isj8Y3yqmudZmonTSCdkigam
         0YyFFrMr2SQZr8sj9y5gh7TRaSD9zTqh51gCqOsrtRDD+Um5mULF/UBGJhzlAAvH5ywI
         A8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753422304; x=1754027104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGWYuGGg+RkXmCYlUBkjSly8s4a2L5VH0Q8IxyQVMGM=;
        b=f24EHLMxKKSpi2xaZ0mxbPmT5+K0ko/P7gSZVSWkOqmZeZNzU9c95kXEcfAYH1MLIQ
         drIn3rXvxpvx0tS31H7X/NAr/4WAix2cncHZjFPATr5PxvUG7kCfUkY4Iv60cbFryFaV
         4+SXtAnqZ6iXpF2wegpLiBLt2xNMe4m0V4wjT/WVfHh5YxZpUDDeOtudgwnPJtkTYmYz
         hfkKpCgwo0hs5JvO6z/ZMbzvGEROjqR4YDQn/Vs68nbeg9+lh/mGKTITL0b7MJQWib2D
         9nQgqJjOn1wDmPdr8XEQLXgE5Vp7tLMApvfJRHXmHKZDMoNBMlHsta8Q6N9buN93fC95
         ts5w==
X-Forwarded-Encrypted: i=1; AJvYcCXgjHqEPzTFFgFoytd7N/HK1/agHbEYvSitWf4aV3nwNys9sWXFtoBA9DeqijfJ9d3Y/mMRoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ20rm94vSEuVFS0/zmNrCjriBUJrzQE59sqQc5KaVSvwhw8Ft
	f9sPGCb29xGauU1KCXL2fNLl46KIvJX4hpUw57AYHm6DPsmYEMmNdEr8I5MypQ==
X-Gm-Gg: ASbGnctpZ9o7TiW9g5gCWWQyaO4rbf4Winnm96kQpbX8z5FyIvV2y7hmHO43EyJrC1+
	97TvT72QhbO4RHdIM7s1CpReHc6RWVAjqtueWAWuKSAA5WNItZ5U44FI+PuLPNX5R8IpVoXSdCF
	ng/SEmcJcNbDLdudx36lESrIy9DqW9AFVRK9P3Vvtx6M2tL5G/w5j4iNQ0tNCvwETLXSY5soDAX
	9Q6Ho5N3tAHs4O57hrV48d9sxi/8wU4cvUh0fnuHesZDNXJCltCTH68oVV/zAN7CF1HZAMCFRlU
	v7D2PgQm/coTHcKfkcSWNMIZFZHbCc/xUOY9GHVvaqK+hERMfrvhco2nh5V8G7gqVbJ8e3NpF1e
	iVuMjm1H0FV0lCrURTTa4UOW/cjEKBOFKYB0=
X-Google-Smtp-Source: AGHT+IFM1tVXn5jXggfnudhVzl/ey8IJ+3hMMdIEcpC9ODY8hwjKCMd4c8HVMpJH4jgfDiTvh4nlFQ==
X-Received: by 2002:a17:907:7283:b0:ae0:a483:7b29 with SMTP id a640c23a62f3a-af619c0d81emr90243366b.49.1753422303535;
        Thu, 24 Jul 2025 22:45:03 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af47c496014sm218598966b.14.2025.07.24.22.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 22:45:03 -0700 (PDT)
Message-ID: <8a106853-70a3-4217-bd4a-c1d6adc58d1c@gmail.com>
Date: Fri, 25 Jul 2025 08:45:01 +0300
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: droid: migrate to QMI from AT
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250724053251.592383-1-ivo.g.dimitrov.75@gmail.com>
 <436eb716-a827-4c10-a90d-1b7edc67400b@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <436eb716-a827-4c10-a90d-1b7edc67400b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 25.07.25 г. 1:25 ч., Denis Kenzior wrote:
> Hi Ivaylo,
> 
> On 7/24/25 12:32 AM, Ivaylo Dimitrov wrote:
>> Drop GAtChat usage and move to qmimodem
>> ---
>>   plugins/droid.c  | 487 +++++++++++++++++++++++++++++++++++++++++------
>>   plugins/udevng.c |  30 ++-
>>   2 files changed, 450 insertions(+), 67 deletions(-)
>>
> 
> So the first question that comes to mind is: Why can't the gobi plugin 
> drive this device?  

Now you asked, I am wondering too :). For sure gobi was not working in 
an year or two when I tried it back then.

One thing I see that is different is that this
> plugin uses QMI_DMS_OPER_MODE_PERSIST_LOW_POWER instead of 
> QMI_DMS_OPER_MODE_LOW_POWER.  You also skip / hard code a few things, 
> but that can be special cased by introducing a new attribute or two, 
> similar to 'AlwaysOnline'.
> 

I wonder if QMI_DMS_OPER_MODE_PERSIST_LOW_POWER is not the proper state 
for all QMI modems when disabled. After all we don't want modem to auto 
wake-up. Besides droid, I have one quectel here that is supported by 
gobi, will test with it.

> On the upside, you should might get multi-context support and MTU 
> handling for free.
> 

nice.

Ok, will try to make it work with gobi, if it does not, will re-send the 
current one with the requested fixes, otherwise will send a patch for gobi.


Thanks,
Ivo

> <snip>
> 
>> +static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
>>   {
>>       struct ofono_modem *modem = user_data;
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>> +    struct qmi_param *param;
>> +    uint8_t mode;
>>       DBG("");
>> -    if (ok)
>> +    if (qmi_result_set_error(result, NULL)) {
>> +        shutdown_device(modem);
>> +        return;
>> +    }
>> +
>> +    if (!qmi_result_get_uint8(result, QMI_DMS_RESULT_OPER_MODE, 
>> &mode)) {
>> +        shutdown_device(modem);
>> +        return;
>> +    }
> 
> These shutdown_device(); return; lines might be better served by a 
> goto/label.
> 
>> +
>> +    data->oper_mode = mode;
>> +
>> +    switch (data->oper_mode) {
>> +    case QMI_DMS_OPER_MODE_ONLINE:
>> +        param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
>> +                    QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>> +        if (!param) {
>> +            shutdown_device(modem);
>> +            return;
>> +        }
> 
> ditto
> 
>> +
>> +        if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
>> +                    power_reset_cb, modem, NULL) > 0)
>> +            return;
>> +
>> +        shutdown_device(modem);
>> +        break;
> 
> ditto
> 
>> +    default:
>>           ofono_modem_set_powered(modem, TRUE);
>> +        break;
>> +    }
>>   }
> 
> <snip>
> 
>> -static int droid_enable(struct ofono_modem *modem)
>> +static void get_caps_cb(struct qmi_result *result, void *user_data)
>>   {
>> -    GAtChat *chat;
>> +    struct ofono_modem *modem = user_data;
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>> +    const struct qmi_dms_device_caps *caps;
>> +    uint16_t len;
>> +    uint8_t i;
>>       DBG("");
>> -    chat = at_util_open_device(modem, "Device", droid_debug, "", NULL);
>> -    ofono_modem_set_data(modem, chat);
>> +    if (qmi_result_set_error(result, NULL))
>> +        goto error;
>> -    /* ensure modem is in a known state; verbose on, echo/quiet off */
>> -    g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
>> +    caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
>> +    if (!caps)
>> +        goto error;
>> -    /* power up modem */
>> -    g_at_chat_send(chat, "AT+CFUN=1", NULL, cfun_set_on_cb, modem, 
>> NULL);
>> +    DBG("service capabilities %d", caps->data_capa);
>> +    DBG("sim supported %d", caps->sim_supported);
>> -    return 0;
>> +    for (i = 0; i < caps->radio_if_count; i++)
>> +        DBG("radio = %d", caps->radio_if[i]);
>> +
>> +    if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
>> +                get_oper_mode_cb, modem, NULL) > 0)
>> +        return;
>> +
>> +error:
>> +    shutdown_device(modem);
> 
> Like you do here :)
> 
>>   }
> 
> <snip>
> 
>> -static int droid_disable(struct ofono_modem *modem)
>> +static void create_dms_cb(struct qmi_service *service, void *user_data)
>> +{
>> +    struct ofono_modem *modem = user_data;
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>> +    struct service_request *request = NULL;
>> +
>> +    DBG("");
>> +
>> +    if (!service)
>> +        goto error;
>> +
>> +    data->dms = service;
>> +    request = l_queue_peek_head(data->service_requests);
>> +
>> +    if (qmi_qmux_device_create_client(data->qmux, request->service_type,
>> +                        create_service_cb, modem, NULL))
>> +        return;
>> +
>> +error:
>> +    shutdown_device(modem);
>> +}
> 
> How is this function different from create_service_cb()?  Could you just 
> use that one instead by queuing up a DMS request on the service_requests 
> queue?
> 
> <snip>
> 
>> +
>> +static int droid_disable(struct ofono_modem *modem)
>> +{
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>> +    struct qmi_param *param;
>> +
>> +    DBG("%p", modem);
>> +
>> +    param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
>> +                QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>> +    if (!param)
>> +        return -ENOMEM;
>> +
>> +    if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
>> +                power_disable_cb, modem, NULL) > 0)
>> +        return -EINPROGRESS;
> 
> Leaking param here
> 
>> -    if (sim)
>> -        ofono_sim_inserted_notify(sim, TRUE);
>> +    shutdown_device(modem);
>> +
>> +    return -EINPROGRESS;
>> +}
> 
> <snip>
> 
>> +
>> +/* Only some QMI features are usable, voicecall and sms are custom */
> 
> Not quite sure what this comment means?  I don't see any vendor 
> customization for voicecalls or sms?  Maybe comment is stale?
> 
>> +static void droid_pre_sim(struct ofono_modem *modem)
>> +{
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>> +
>> +    DBG("%p", modem);
>> +
>> +    ofono_devinfo_create(modem, 0, "qmimodem",
>> +                qmi_service_clone(data->dms));
>> +    ofono_sim_create(modem, 0, "qmimodem",
>> +                qmi_service_clone(data->dms),
>> +                qmi_service_clone(data->uim));
>> +    ofono_voicecall_create(modem, 0, "qmimodem",
>> +                qmi_service_clone(data->voice));
>> +    ofono_location_reporting_create(modem, 0, "qmimodem",
>> +                    l_steal_ptr(data->pds));
>>   }
>>   static void droid_post_sim(struct ofono_modem *modem)
>>   {
>> -    GAtChat *chat = ofono_modem_get_data(modem);
>> +    struct droid_data *data = ofono_modem_get_data(modem);
>>       struct ofono_message_waiting *mw;
>> +    struct ofono_gprs *gprs;
>> +    struct ofono_gprs_context *gc;
>> +    const char *interface;
>> -    DBG("");
>> +    DBG("%p", modem);
>> +
>> +/*    ofono_phonebook_create(modem, 0, "qmimodem", data->qmux);*/
> 
> Remove?
> 
>> +    ofono_radio_settings_create(modem, 0, "qmimodem",
>> +                    qmi_service_clone(data->dms),
>> +                    qmi_service_clone(data->nas));
>> -    ofono_ussd_create(modem, 0, "atmodem", chat);
>> -    ofono_call_forwarding_create(modem, 0, "atmodem", chat);
>> -    ofono_call_settings_create(modem, 0, "atmodem", chat);
>> -    ofono_netreg_create(modem, 0, "atmodem", chat);
>> -    /*
>> -     * Droid 4 modem has problems with AT+CPUC?, avoid call meter for 
>> now.
>> -     */
>> -    ofono_call_barring_create(modem, 0, "atmodem", chat);
>> -    ofono_sms_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
>> -    ofono_phonebook_create(modem, 0, "atmodem", chat);
>> +    ofono_sms_create(modem, 0, "qmimodem",
>> +                qmi_service_clone(data->wms));
>>       mw = ofono_message_waiting_create(modem);
>>       if (mw)
>>           ofono_message_waiting_register(mw);
>> +
>> +    gprs = ofono_gprs_create(modem, 0, "qmimodem",
>> +                    qmi_service_clone(data->wds),
>> +                    qmi_service_clone(data->nas));
>> +    if (!gprs) {
>> +        ofono_warn("Unable to create gprs for: %s",
>> +                ofono_modem_get_path(modem));
>> +        return;
>> +    }
>> +
>> +    gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
>> +                    qmi_service_clone(data->wds_ip4),
>> +                    qmi_service_clone(data->wds_ip6));
>> +    if (!gc) {
>> +        ofono_warn("Unable to create gprs-context for: %s",
>> +                ofono_modem_get_path(modem));
>> +        return;
>> +    }
>> +
>> +    ofono_gprs_add_context(gprs, gc);
>> +    interface = ofono_modem_get_string(modem, "NetworkInterface");
>> +    ofono_gprs_context_set_interface(gc, interface);
>> +}
>> +
> 
> <snip>
> 
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 320cd3a6..7777996d 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -870,7 +870,9 @@ static gboolean setup_telitqmi(struct modem_info 
>> *modem)
>>   static gboolean setup_droid(struct modem_info *modem)
>>   {
>> -    const char *at = NULL;
>> +    const struct device_info *qmi = NULL;
>> +    const struct device_info *net = NULL;
>> +
>>       GSList *list;
>>       DBG("%s", modem->syspath);
>> @@ -878,21 +880,29 @@ static gboolean setup_droid(struct modem_info 
>> *modem)
>>       for (list = modem->devices; list; list = list->next) {
>>           struct device_info *info = list->data;
>>           const char *subsystem =
>> -            udev_device_get_subsystem(info->udev_device);
>> -
>> -        DBG("%s %s %s %s %s", info->devnode, info->interface,
>> -                info->number, info->label, subsystem);
>> +                udev_device_get_subsystem(info->udev_device);
>> +        DBG("%s %s %s %s %s %s", info->devnode, info->interface,
>> +                        info->number, info->label,
>> +                        info->sysattr, subsystem);
>> -        if (g_strcmp0(info->interface, "255/255/255") == 0 &&
>> -                g_strcmp0(info->number, "04") == 0) {
>> -            at = info->devnode;
>> +        if (g_strcmp0(subsystem, "usbmisc") == 0) {
>> +            if (g_strcmp0(info->number, "05") == 0)
>> +                qmi = info;
>> +        } else if (g_strcmp0(subsystem, "net") == 0) {
>> +            if (g_strcmp0(info->number, "05") == 0)
>> +                net = info;
>>           }
>>       }
>> -    if (at == NULL)
>> +    if (qmi == NULL || net == NULL)
>> +        return FALSE;
>> +
>> +    DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
>> +
>> +
> 
> No double empty lines please
> 
>> +    if (setup_qmi_qmux(modem, qmi, net) < 0)
>>           return FALSE;
>> -    ofono_modem_set_string(modem->modem, "Device", at);
>>       ofono_modem_set_driver(modem->modem, "droid");
>>       return TRUE;
> 
> Regards,
> -Denis
