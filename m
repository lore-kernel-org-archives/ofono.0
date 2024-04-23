Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606ED57870
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867029; cv=none; b=USlE0ZqTquccR45L7N6WGI3GM+fimklu2am04WjJjDGjouHDdUB7DUZVky7THI9Mt4Ubhwi8RELdFCr7qz19vSMdjHazmQrTzW+UqB5a72pHExiezQqPeeRiCDP1pRGjgcHcMfbbfubaIaDjev/c5SOhCjzZ93mqq2GT99Fsypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867029; c=relaxed/simple;
	bh=LVx65k2ij8RBiFEQsK64BYE3iAd/1VhGqr+4acD7lVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0bV3SRTRVgw0REBWEHhlMH7yJmOy4i89BRO6wjWBSYlwnuAr9bhJYg4/wKNRz/IjP1v5+0jpWVxY3Gk+Y0IHZfJkZulFYQ/VoEEKuoaM4uq1nOtfz/IdWZNbjqbfQ7iU5qdAiJKdB/KGuNHrKuSsBL8tdKfikxhKTrZl/2d28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGsTLr54; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGsTLr54"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-349545c3eb8so3970698f8f.2
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713867025; x=1714471825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1hfB0mXleParRfswPi2L4aouHdm120CKOJNKi7qdEU=;
        b=RGsTLr54oDNoYodXv/sstEuDoP2Gb8jquijW0l7ha2cRhzgfQfF1ACKF7PWdL7VbXZ
         jUvUjvECgB4zCcWh/tkO1PiBhcrzQakGOtOcaK9Uo6Ev07/rrAfr8ejpqoJCFnBMen9V
         7X+dBXuaUPQquBHTLizJheJVxL+PcyCL8UR+egjWcvf6erI2CUvzJVNV4MHVi9aj0PJ8
         5N0enGqaHqwvbRSNh8DycOOr4ksH8UXCeIJLng8V6X+fYspCO67IcMKIYpcIWNtq6P0D
         nGoQiYKimUJWKEVGhY9+tglQfl4hcYIEcFZk+WAgybUYrcCq1i6vaNliQseBO1mLcDqu
         u9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867025; x=1714471825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1hfB0mXleParRfswPi2L4aouHdm120CKOJNKi7qdEU=;
        b=Ue/AMo/S3YDyd+KsRW63MyDU8iK0WGVeZzRbe329GslQNtht1nTiGkF5iD7dGDqsOE
         yC5cxfExpA6+ouINzYuiOkRnsZpLsxBAUDaXSM8aRSKgQjCBbxAVogo/SmpDoL6vKZIX
         AsWvPCK+4M44WzrDv3im9uSUqccsN4L5HEx9/PTasSQvdTFUQuuLI5sCPLZ9a8d10rrd
         4kJTBm99gLvfqtvUt1yL2kyLulcuc0oR+2XBbUjcKYGAD9YoyJbtocmNXbkJdsjS/jVq
         L5Xtt7NmN8eW62Dj3H1s31+0vV73wMT8JcmvklCSLhd3sRmLuV3xWr9tvtZ7hTPKdq8c
         Smbw==
X-Gm-Message-State: AOJu0YzB8TTb1pHi/e/aZ+KTNPOVB1kBhc6mauBDvorxKxI8qGYh4Lrp
	JDx+ItEXvyKrRPLnpjbyHbI3rDFKa/IXmMje2UTpkcLGlreg+TxAB/zB7w==
X-Google-Smtp-Source: AGHT+IE+cdVGuE40t6FSYNer98M5Rb1FLS4YChHxI3WoxYaKZxCY9Qaf7rqL5/A4l+e7EXR5chRPWA==
X-Received: by 2002:adf:e48c:0:b0:34b:14ae:8355 with SMTP id i12-20020adfe48c000000b0034b14ae8355mr3317523wrm.58.1713867025199;
        Tue, 23 Apr 2024 03:10:25 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000050c00b00349ac818326sm14223245wrf.43.2024.04.23.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:10:24 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Tue, 23 Apr 2024 11:10:21 +0100
Message-ID: <1934099.7Z3S40VBb9@adam-laptop-hp>
In-Reply-To: <159a23ff-bd7d-44bc-b723-6dbb08aef6d9@gmail.com>
References:
 <20240421194926.13149-1-adam@piggz.co.uk>
 <20240421194926.13149-4-adam@piggz.co.uk>
 <159a23ff-bd7d-44bc-b723-6dbb08aef6d9@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

Thanks for the thorough review and merging the others....

On Monday 22 April 2024 22:00:41 BST Denis Kenzior wrote:
> Hi Adam,
> 
> On 4/21/24 14:49, Adam Pigg wrote:
> > The send_dtmf function sets up a call to send_one_dtmf, which will call
> > the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The parameters to
> > this call are a hard coded call-id and the DTMF character to send.
> > start_cont_dtmf_cb will then be called which will set up a call to
> > QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> > stop_cont_dtmf_cb will check the final status.
> > 
> > ---
> > Changes in V4
> > -Removed unused enum
> > -Minor formatting fixes
> > -Ensure data->full_dtmf is free'd
> > -Use cb_data_ref/unref between chains of dtmf calls
> > 
> > Changes in V5
> > -Store the cb and cbd obejects in the voicall_data  struct
> > ---
> > ---
> > 
> >   drivers/qmimodem/voice.h     |   6 ++
> >   drivers/qmimodem/voicecall.c | 114 +++++++++++++++++++++++++++++++++++
> >   2 files changed, 120 insertions(+)
> 
> <snip>
> 
> > @@ -605,6 +609,114 @@ static void hangup_active(struct ofono_voicecall
> > *vc, ofono_voicecall_cb_t cb,> 
> >   	release_specific(vc, call->id, cb, data);
> >   
> >   }
> > 
> > +static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> > +{
> > +	struct voicecall_data *vd = user_data;
> > +	uint16_t error;
> > +
> > +	DBG("");
> > +
> > +	if (qmi_result_set_error(result, &error)) {
> > +		DBG("QMI Error %d", error);
> > +		CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd-
>send_dtmf_data);
> > +		return;
> > +	}
> > +
> > +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
> 
> This calls back into oFono core unconditionally.  Doesn't this imply that
> you're handling only a single DTMF character?
> 
Currently, ive only been able to test using single character invocations, 
using the num-pad on the phone app.  Do you have any suggestions on how to 
trigger multiple characters?


> > +}
> > +
> 
> <snip>
> 
> > +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> > +				ofono_voicecall_cb_t cb, void 
*data)
> 
> Both cb and data are not saved anywhere and are only used on the error path.
> The initial invocation in send_dtmf() also passes in NULL for data...
> 
> So again, I think this implies only a request which uses a single DTMF tone
> character would work?

Im saving the cb and data params in the initial call, and used them as vd-
>,,,, where needed (i think!)
All the user_data params are being set to the vd object so I can get a handle 
on the params in there.
> 
> > +{
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> > +	struct qmi_param *param = NULL;
> > +	uint8_t param_body[2];
> > +
> > +	DBG("");
> > +
> > +	param = qmi_param_new();
> > +
> > +	param_body[0] = 0xff;
> > +	param_body[1] = (uint8_t)dtmf;
> > +
> > +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, 
sizeof(param_body),
> > +			param_body))
> > +		goto error;
> > +
> > +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, 
param,
> > +			start_cont_dtmf_cb, vd, NULL) > 0)
> > +		return;
> > +
> > +error:
> > +	CALLBACK_WITH_FAILURE(cb, data);
> > +	l_free(param);
> > +}
> > +
> > +static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
> > +{
> > +	struct cb_data *cbd = data;
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
> > +	ofono_voicecall_cb_t cb = vd->send_dtmf_cb;
> > +
> > +	DBG("");
> > +
> > +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> > +			*vd->next_dtmf == 0) {
> > +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
> > +			CALLBACK_WITH_SUCCESS(cb, cbd->data);
> > +		else
> > +			CALLBACK_WITH_FAILURE(cb, cbd->data);
> > +
> > +		l_free(vd->full_dtmf);
> > +		vd->full_dtmf = NULL;
> > +	} else
> > +		send_one_dtmf(cbd->user,
> > +				*(vd->next_dtmf++),
> > +				send_one_dtmf_cb, vd-
>send_dtmf_data);
> 
> This function doesn't seem to be invoked?
This function is passed into send_one_dtmf but yes, potentially goes unused, 
unless it gets invoked in the macro call?  Ill double-check the original 
implementation to see if i messed anything up, but open to suggestions :)
> 
> > +}
> > +
> 
> <snip>
> 
> Regards,
> -Denis




