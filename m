Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70996198A17
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949769; cv=none; b=PyPBNUDkdYGSukJ9vByu8yFuBQExv6s2zBQRpj4hyRdXD0dHkVOvgpw+gFThdgkzMmQV1YuROZogcVVrIN3wwV46wE9btm3SjiF11ZCc+c80j7EkLNVeWlOIe5aVhNY/VcYLm8ApbNxPUtfJ0PhcJf/1h0rBi3XFVCNUYyfvE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949769; c=relaxed/simple;
	bh=Ge5OVkuGgQH+lSZ+dNtaT8rfpJXzkjatRHihQ/5RC8E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jPMRkO/upPld9fTa3ZbU6wmkrndKSc5nSClTEebBJS54vGcRSYFos8osS3PVwrWy5VeP6sgIIxLBEKUQOh4ucdyKiJ6GfQ4tPJQBM7l98PvygerSK4/izW3czFSINDdHDsmtUkNDEYIYYmNtQYEJac7Yp6oq2un5cjVQUETIJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXWedmsm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXWedmsm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43193678216so41071105e9.0
        for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949766; x=1732554566; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZzBzHsm/SceZYdVzB3+al5cPJKKcoXEyTQ276ky8mk=;
        b=PXWedmsm7PhEIrq/iUY3dYWAHQ2i21RVbzPknJ+JMjsA+ImZGL14akOIwZy/tx0biO
         NgVt4PbpYK8exhdsM8fE4fzz6GklY5nEhtkrHVtP68JwtydWexmttnlyAZeV07JJ+zWi
         YsoZiXfL6X152hcizBxfyB6ge91eAI3kPHP1/igA+Ugx6huvNkA9ntDVVFWAqLlNFAKw
         hr3IU8+7WewP4R9OVMi2EuNR7g4uBz6XhTdctKs9duQuQdBIE2uf0Zma0mW1zBlvbBa1
         Ynz7vX+RncWYEqJT5zgHKnk6eMEctPLJ1a6BkLDUtQOrm8P3aS0/0zSLMYXHBhxXDq2M
         XbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949766; x=1732554566;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZzBzHsm/SceZYdVzB3+al5cPJKKcoXEyTQ276ky8mk=;
        b=sIVDV4e0Hs/XcZ+XCFJxZ+12NgwNoe+Tt0biJkdbPBowzeGHOyp8y5GPyoIhqp6eS/
         jkumH9VyFwggLBzVcvTvZ1B6dh+rKnajgtRDRk4AG4wOABU/07T6vOfK88w3aYIT4oVv
         yfALbQXd4Ed5Islf1884U8bMrI73JRzzN169u6t2tzhpxEahWk3eVQJupSW3TNBkaevq
         FtvSc++weKt2X82eOqO4RaZ2hF2xwXCjWXRM3/oNgY8MB2BGT0T8dAgn4gcr/tc5gQyX
         e9UsrgqQ9jPTtcq9iZHXqdU+2NbZsRMBiy6thKHDG3FUtvuAEwsdGAlIcHs+MQR2Wc4D
         LYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6V2PXgz1e8IxpUNInf+MAsP4Y6pN7Yr2HQ9s8BIVEVliwDDE932sYBtMSzjS77IHF/uz2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YymXfYwEieltnRLkEJVL1/iL8k78KfuKhLj5gVPiytTEZGzMW89
	L15rwYv7vj74BJDbNc+GJpInVLXWWFBVsUB8rpEmEUpz8vp8qYd7PJkocQ==
X-Google-Smtp-Source: AGHT+IGrj+LroDpPEAu5EpmG6bpoRRlM8htAqLQdpB+UdOpMNQHVCU4m6E2taHWE4emoUOjkmIeAOQ==
X-Received: by 2002:a05:600c:1907:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-432df791b70mr106601365e9.29.1731949765428;
        Mon, 18 Nov 2024 09:09:25 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae5csm161072135e9.32.2024.11.18.09.09.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:09:25 -0800 (PST)
Subject: Re: [PATCH] qmi: sim: implement lock(LockPin method)
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <fb513766-cec4-48c0-977a-a4457b6021cf@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <49ee7849-1bc7-68e3-3498-ba9bfe27bc6d@gmail.com>
Date: Mon, 18 Nov 2024 19:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fb513766-cec4-48c0-977a-a4457b6021cf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis,


On 18.11.24 г. 18:54 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
> On 11/17/24 6:03 AM, Ivaylo Dimitrov wrote:
>> ---
>>   drivers/qmimodem/sim.c | 70 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/qmimodem/uim.h |  1 +
>>   2 files changed, 71 insertions(+)
> 
> Looks like this patch is on top of the query_facility_lock.  Please send 
> these as a series in the future, otherwise the CI gets confused.
> 

I was thinking it will take me a while to implement $subject 
functionality, it turned out to be easy.

As query_facility_lock needs changes anyway, I'll resend as series.

>>
>> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
>> index b1d8f22..65c0fa6 100644
>> --- a/drivers/qmimodem/sim.c
>> +++ b/drivers/qmimodem/sim.c
>> @@ -844,6 +844,75 @@ static void qmi_query_locked(struct ofono_sim *sim,
>>       l_free(cbd);
>>   }
>> +static void qmi_lock(struct ofono_sim *sim,
>> +        enum ofono_sim_password_type passwd_type,
>> +        int enable, const char *passwd,
>> +        ofono_sim_lock_unlock_cb_t cb, void *user_data)
>> +{
>> +    struct sim_data *data = ofono_sim_get_data(sim);
>> +    struct cb_data *cbd = cb_data_new(cb, user_data);
>> +    int passwd_len;
>> +    uint16_t info_len;
>> +    uint8_t pin_id;
>> +    struct qmi_param *param;
>> +    uint8_t session[2];
>> +    struct {
>> +        uint8_t id;
>> +        uint8_t enabled;
>> +        uint8_t length;
>> +        uint8_t pin[0];
>> +    } __attribute__((__packed__)) *info;
>> +
>> +    DBG("");
>> +
>> +    switch (passwd_type) {
>> +    case OFONO_SIM_PASSWORD_SIM_PIN:
>> +        pin_id = 0x01;
>> +        break;
>> +    case OFONO_SIM_PASSWORD_SIM_PIN2:
>> +        pin_id = 0x02;
>> +        break;
>> +    default:
>> +        goto error;
>> +    }
>> +
>> +    if (!passwd)
>> +        goto error;
>> +
>> +    passwd_len = strlen(passwd);
>> +
>> +    if (passwd_len <= 0 || passwd_len > 0xFF)
> 
> strlen returns a size_t, so checking < 0 doesn't really make sense.  
> Also, the core already performs validation of the pin using 
> 'is_valid_pin'.  So I'm not really sure any of this validation is needed?
> 

I borrowed the code from qmi_pin_send(), shall I create another patch 
removing the checks there too?

>> +        goto error;
>> +
>> +    param = qmi_param_new();
>> +
>> +    /* info */
>> +    info_len = sizeof(*info) + passwd_len;
>> +    info = alloca(info_len);
>> +    info->id = pin_id;
>> +    info->enabled = enable ? 0x01 : 0x00;
>> +    info->length = (uint8_t) passwd_len;
>> +    memcpy(info->pin, passwd, passwd_len);
>> +
>> +    qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, info_len, info);
>> +
>> +    /* session */
>> +    session[0] = 0x6; /* card on slot 1 */
>> +    session[1] = 0x0;
> 
> Hmm, can we get some #defines for these magic numbers? Or static const 
> variable declaration?
> 

sure, will create a separate patch (introducing some #defines) and 
fixing qmi_pin_send() as well.

>> +    qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
>> +                    sizeof(session), session);
>> +
>> +    if (qmi_service_send(data->uim, QMI_UIM_ENABLE_PIN, param,
>> +                    pin_send_cb, cbd, cb_data_unref) > 0)
>> +        return;
>> +
>> +    qmi_param_free(param);
>> +
>> +error:
>> +    CALLBACK_WITH_FAILURE(cb, cbd->data);
>> +    l_free(cbd);
>> +}
>> +
>>   static void get_card_status_cb(struct qmi_result *result, void 
>> *user_data)
>>   {
>>       struct ofono_sim *sim = user_data;
>> @@ -987,6 +1056,7 @@ static const struct ofono_sim_driver driver = {
>>       .query_pin_retries    = qmi_query_pin_retries,
>>       .send_passwd        = qmi_pin_send,
>>       .query_facility_lock    = qmi_query_locked,
>> +    .lock            = qmi_lock,
>>   };
>>   OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
>> diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
>> index 439e25b..602ec0f 100644
>> --- a/drivers/qmimodem/uim.h
>> +++ b/drivers/qmimodem/uim.h
>> @@ -11,6 +11,7 @@
>>   #define QMI_UIM_WRITE_RECORD        35    /* Write a record */
>>   #define QMI_UIM_GET_FILE_ATTRIBUTES    36    /* Get file attributes */
>> +#define QMI_UIM_ENABLE_PIN        37    /* Set PIN protection */
>>   #define QMI_UIM_VERIFY_PIN        38    /* Verify PIN */
>>   #define QMI_UIM_EVENT_REGISTRATION    46    /* Register for 
>> indications */
> 
> Otherwise, LGTM.
> 
> Regards,
> -Denis

Thanks,
Ivo
