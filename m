Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350D134CEA
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291567; cv=none; b=lNOECelW2D3MYms1r7mFiHWP652Ka70AxWj/1pujIk4bhrWSLSVo4qLt/b6PWPWWIBW+3OwIsAL25cXkfc/CCaGKP2KYDYzL8YpZic5Jm78qzFL/TbStqeytAN9qg/zdCW1uHG2rPu3raxR4omgWJnTYd8imNjbOwJinHpX5tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291567; c=relaxed/simple;
	bh=IH/J8B9T8UsNUQiok4hBLaliB/DwbCAh21ZDVEdorrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qnuAJDaJaCyk6wTyesGcUzapkmAYugb4GZFP07y2nEL7DVNvB8Y9YFOlaCexgUXN1BM1dZiU9tDve0BxNida05PZwNnVSNl5y4XZ7gsWVUcKPdGeoZIaq8Rq/LdEgH+Jf8FTmaLOsa/eN49gjWbloXSBZUryri8etJYau39aCSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrDTBFKW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrDTBFKW"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5acce3cbc9aso11952eaf.1
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291564; x=1713896364; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GsRGt5PiUyjmqdiJq+ESAZk16h17laBDdxzM3BofN4=;
        b=DrDTBFKW0C8LX69sGXEzW1qR8lGskqeFiMiXcoLn3H0L9REore8sWSMyMAzC+eA4LE
         2S5c6im3tadj/0cMtEKFxi4ciH7r4lPkrRnbTY6qJ+QivbLioSh/zPmKKiLuINmUFdZk
         QOVPaPEwv1d8VYcab0XJgYe78jWnpIzcKhMQLNdg552W5+79/4QaGCDeYu87DVb46HhT
         G2tRdONuKUza2gOvYwB8rN+VWELx+3siB6HkKRy4crHsiEwWogrSDr31DJOCM6LBjNtH
         qBPG0meH8x0jAU1SB0uSKRZmlQbdR2qrWbKtL8VdnlXauBAVsdgjvsqf8pQb3gobOw1K
         0Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291564; x=1713896364;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GsRGt5PiUyjmqdiJq+ESAZk16h17laBDdxzM3BofN4=;
        b=q/oaKLPvEWqPIwR9tN0FPbw63E7+vRbb4VHMkbvdYxxBa//Z2It9SEkh1Hbpo0HdD/
         gQlcQW9JO21Wq0dSwmeJPqCUo9dcPl4+cFn9V44zL8lkmDctt0mCYie+4dORp8boH1p7
         4Q9yHkTShaz6aMFnjW2YOR5DLBdFk70WO0/gKwYZ15RXrQiVwF/G+uPK8B2pyQY83/0p
         BxyZQujRt9tZlr7NVtzyIo9yRb28ueeiGBVCgz61wsrelySPzfvkUEVlJnAbgT0GnfGG
         cgXrclod+aG7XCfjv/0x/RGBa/pxHtaU+2f95ee7DeI2psmJcHiSfJzR8qDNXYMc/qrX
         lcog==
X-Forwarded-Encrypted: i=1; AJvYcCV3OBhtilVvUxNwlYIjbopyMEUtW7iCboAnOIjx0QtCbF78wmCejrOpFKhjCQchN8JuS9auU2CwOJuYDEF0TLSVJ0/XBcM=
X-Gm-Message-State: AOJu0YzUS6NTuKTVwM1aTh/DDXYvw4PBlPvAcPrxZSwelwiQrlEHLMPc
	XQGfrl9vHJckSv8b5FvZbHdEoul/WUT8Ugn84ziixVBg2YJItTcvCZ3pag==
X-Google-Smtp-Source: AGHT+IG2UsHQA+ZFV9PsH3d1o2dS3C/OreX1Gv/cXCqI//LLM+4Hk9leaHfQ0fHuv5v2fhPoXvROJg==
X-Received: by 2002:a4a:2549:0:b0:5aa:6b6a:62c with SMTP id v9-20020a4a2549000000b005aa6b6a062cmr77206ooe.2.1713291563994;
        Tue, 16 Apr 2024 11:19:23 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e21-20020a056820061500b005a4694c37a8sm2650806oow.20.2024.04.16.11.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 11:19:23 -0700 (PDT)
Message-ID: <950b986c-983b-4dde-8876-163b7d37f37b@gmail.com>
Date: Tue, 16 Apr 2024 13:19:22 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qmimodem: voicecall: Implement call answer
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <20240413215318.12236-2-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240413215318.12236-2-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/13/24 16:53, Adam Pigg wrote:
> The answer function set up the parameters for a call to the service
> function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
> answer_cb will then be called which retrieves the call-id and checks
> the status of the result.
> 
> ---
> Changed in V4
> -Minor rework to the answer function
> ---
> ---
>   drivers/qmimodem/voice.h     |  1 +
>   drivers/qmimodem/voicecall.c | 70 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 71 insertions(+)
> 

<snip>

> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 8c86eee7..4b87921e 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -93,6 +93,14 @@ static bool ofono_call_compare_by_id(const void *a, const void *b)
>   	return (call->id == id);
>   }
>   
> +static bool ofono_call_compare_by_status(const void *a, const void *b)

Nit, similarly to my comment in patch 1, lets use 'match' in the name.  Perhaps 
ofono_call_match_by_status?

> +{
> +	const struct ofono_call *call = a;
> +	int status = L_PTR_TO_INT(b);
> +
> +	return status == call->status;
> +}
> +
>   static void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
>   						int call_id)
>   {
> @@ -465,6 +473,67 @@ error:
>   	l_free(param);
>   }
>   
> +static void answer_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	uint8_t call_id;
> +
> +	static const uint8_t QMI_VOICE_ANSWER_RETURN_CALL_ID = 0x10;

RESULT_CALL_ID

> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_result_get_uint8(result, QMI_VOICE_ANSWER_RETURN_CALL_ID, &call_id))
> +		DBG("Received answer result with call id %d", call_id);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd;
> +	struct ofono_call *call;
> +	struct qmi_param *param = NULL;
> +
> +	static const uint8_t QMI_VOICE_ANSWER_CALL_ID = 0x01;

PARAM_CALL_ID

> +
> +	DBG("");
> +
> +	call = l_queue_find(vd->call_list,
> +					ofono_call_compare_by_status,
> +					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
> +
> +	if (call == NULL) {
> +		DBG("Can not find a call to pick up");
> +		return;

Hmm, CALLBACK_WITH_FAILURE?  And probably warrants an ofono_error()

> +	}
> +
> +	param = qmi_param_new();
> +	cbd = cb_data_new(cb, data);
> +	cbd->user = vc;
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_ANSWER_CALL_ID,
> +			call->id))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_ANSWER_CALL, param,
> +			answer_cb, cbd, l_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;

Regards,
-Denis

