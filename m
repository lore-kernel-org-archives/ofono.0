Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94812D1EF
	for <ofono@lists.linux.dev>; Thu,  4 Apr 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264613; cv=none; b=KS8rJUVdgP4XbPdc1ZF/DRZJkS8NPGCG1rGlt+iigTN+8GMminOKKtJN0bpkqkXiS0tRXXevIP9fP0kbs31zJZ+fSc52bwT36kgRnDVOUb2TGM0yA4yBbVo8BpPKpV/6w1jYhfOxe1O9FvH0Wtl9h8AO/QZpPnDvL9IIwlt+mN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264613; c=relaxed/simple;
	bh=/vjuN6I/qKIKyfKbyxwDk+D9ARsOhfCkQ9zqHaQkeR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aAL9Kx7xZsrkz4hvn8pfMJo7TXZaCJ1XKLm/nEWnNtmXiyWuPvcaXAhJ94SJGdCZiuxeAZcTThVW5KCIIj+w/OXM3iDW16WQtj9h/qXBjw1HoQHA5osqveVVjkoMgSvvghtG86ocYgIKw3gssYHaNNqQ8vkKXFxYKI+HyyvU2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QolJREgk; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QolJREgk"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a9f44c33f1so10394eaf.1
        for <ofono@lists.linux.dev>; Thu, 04 Apr 2024 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264611; x=1712869411; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aYft/VvJPiz9Btj2HjPS1dbYH7CW0fMwmy8GZchi74=;
        b=QolJREgkSGzey/0UGMvBTKRvXc5SwBZ0pPvz3BxEREu3Pa6jVOwmb3yja7w4qFFX67
         quYY8y+hv1fcRtETdNKJCnMp1I5jHUFsQVnaeohlG0pLqO1gwt9x9req9AQp5JhTi2A1
         WOMgro5lCYFyPF5pC01o11z4wblY3KacIvu06xZiWR6sbpgfPb8BSMhcJDkwbbXvyJtx
         jPcHvxs7tkxWHQCj/M/uAHoOZKuy0EHT1Y8AoNhg4Y4UaNO9b1KPISblnLtcOwnz3PVH
         sl2MDYQLRkzq2GMESgefYHA1+BeMuJSih9kyLy6KYfS+q1w3lhYcMJGYXsb/gVYO3i19
         RI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264611; x=1712869411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aYft/VvJPiz9Btj2HjPS1dbYH7CW0fMwmy8GZchi74=;
        b=AhlHKYJ7gHdgDnedr45ns/+GrtXrtP73gJfUpc4PPYcoVWHVqKBhukI9NnFhlUVfsE
         VVI3cDxOJjT79Gtu+0jc1NmjJkIDWYmGosrFYGlRTb5wy3oAtdWUP8aBkmAowTHHl7Dg
         NpjSH40RYMkOgp0rSPiV7yekkQMWY2VF/Z6+RzW4kYcxxU7iN0gE7zLxqAd2e0220Fza
         M7KVkJ+ABBCnUm31/RCAeotD/pmUTxpM/UCf10JcHeDHFj1AElS5Sg3XiBOhEIysCOjD
         HVSndiA95D36L2OBIuTtfJYfhgGoluI6W9z6SayPtDRcs7ye7GihAjaXbCyJHlF1xP//
         HKYw==
X-Forwarded-Encrypted: i=1; AJvYcCVmb1UstEom6Xoz8vgbTWeYeTqifCYK5pGg3Kg7wHQMCeqxF7ZLc6NTtNn7vIvMyye110LZlHube/EqgK54MVVLwsg75Cw=
X-Gm-Message-State: AOJu0YxY86XN7ZxokXO3UxR4QT/vRMIjSTE7PwntYRSB1G4yw7sdiccc
	J8nGGV3R5CuF7VkWAnlJQbR/86Y0Qh+KqfJnjFkEnNNfWWmmHClf8fB72wwM
X-Google-Smtp-Source: AGHT+IGd832reGxsosmtV2+z5z2IkOczhD6+dNpJo5Yl4+CcrS/CG2fVJBHdZWzuuKjDoRmm9NRfxg==
X-Received: by 2002:a4a:ee97:0:b0:5a1:4150:6f57 with SMTP id dk23-20020a4aee97000000b005a141506f57mr3730207oob.9.1712264611258;
        Thu, 04 Apr 2024 14:03:31 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b46-20020a4a98f1000000b005a4a656860bsm6755ooj.2.2024.04.04.14.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 14:03:31 -0700 (PDT)
Message-ID: <63524371-e1be-41d6-80fa-e68e40008222@gmail.com>
Date: Thu, 4 Apr 2024 16:03:30 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] qmimodem: voicecall: Implement active call hangup
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240402212625.5348-1-adam@piggz.co.uk>
 <20240402212625.5348-3-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240402212625.5348-3-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/2/24 16:25, Adam Pigg wrote:
> hangup_active iterates the current list of calls, looking for the first
> active call and then calls release_specific.  This then sets up the
> parameters for a call to QMI_VOICE_END_CALL, with the only paramters

typo: 'paramters'

> being the call-id.
> 
> end_call_cb will then be called and will parse out the call-id and check
> for success.
> ---
>   drivers/qmimodem/voice.h     |  1 +
>   drivers/qmimodem/voicecall.c | 84 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 84 insertions(+), 1 deletion(-)
> 

<snip>

> +static void release_specific(struct ofono_voicecall *vc, int id,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_param *param = NULL;
> +
> +	static const uint8_t QMI_VOICE_END_CALL_ID = 0x01;
> +
> +	DBG("");
> +	cbd->user = vc;
> +
> +	param = qmi_param_new();

As mentioned before, qmi_param_new() can't fail, so feel free to drop !param check

> +	if (!param)
> +		goto error;
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, id))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb,
> +		cbd, l_free) > 0)

item M4

> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
> +static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
> +				void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct ofono_call *call;
> +	enum call_status active[] = {
> +		CALL_STATUS_ACTIVE,
> +		CALL_STATUS_DIALING,
> +		CALL_STATUS_ALERTING,
> +		CALL_STATUS_INCOMING,
> +	};
> +
> +	DBG("");

item M1

> +	for (uint32_t i = 0; i < L_ARRAY_SIZE(active); i++) {
> +		call = l_queue_find(vd->call_list, ofono_call_compare_by_status,
> +			L_INT_TO_PTR(active[i]));
> +
> +		if (call)
> +			break;
> +	}
> +
> +	if (call == NULL) {
> +		DBG("Can not find a call to hang up");
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}
> +
> +	release_specific(vc, call->id, cb, data);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;
> @@ -594,7 +674,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
>   	data->voice = qmi_service_ref(service);
>   
>   	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
> -			     all_call_status_ind, vc, NULL);
> +				all_call_status_ind, vc, NULL);

This belongs in patch 1.

>   
>   	ofono_voicecall_register(vc);
>   }

Regards,
-Denis

