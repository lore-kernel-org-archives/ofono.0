Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D3137C42
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231512; cv=none; b=DaonusiYA3G8GLvDuopRuA1V4clmvmIJrpp4+uAIrEnUPpwMt++SwF4KJR3x/381P2vE0ItoRTfAoFWh2iGkZsDxKeQxLCiF5tsKcIYTbDdLDXEs4AKgTRh4dcb3k6Q6O7hnsHzNoxUPlGepQ45Si2Au7afcbL96+nmS8gJjyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231512; c=relaxed/simple;
	bh=aK7NGRowlcrGS36jXsdmIpyrJ8HANZw4rrCv4Xj31xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzjvSfMU+9hxuxRc6ExlrQgQjPbszBQEGlKKKdzjUzntusR9tsaDP4lJAgYbrYCLmeOu+OLzrUI7ugAThHckv9LgSGNpHLk1BMXlum6A11PUTOcgDFc8cezTAiy06a0vO2hx1814uJlc1/jhd0USXwOVJ7g9iUaj0ZK45t51j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7esHQ/G; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7esHQ/G"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c1234beb3so594913fac.0
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716231510; x=1716836310; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YE/50fVZUygll5/E+J0lzqNDHyTiqwcXxiLuvz283u0=;
        b=i7esHQ/G4F5GVG/BYrggYBEW6TsLlcnu2a0QelWEbcvwq18iTT4A+1mZXq0EHOqgUz
         OPQIfKUQpAg7JrKRd4XLqQ/LCBp+qcXDNQgcvwj9dwsiKeCfubAEWKvp1cz5JcC5cI0s
         1IN8o5ok0omvBgZ1PRibyqzhVW0Di/xOH0eh91gBfcA5aJRnQP0oyvYf8DqJsS4fqh/0
         5gx83g3U50FpnqN8klAAU2skq/ttpSx1gECgLvFlrKppZM4kh1kOUT7MjucS/S1yHDDb
         BoeKUd4aWu6VAKmK6emyU4ic03j6e7RkBpK00emIYMX3kHnu2w5dL0OexVMRbcc5CSMs
         Au4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716231510; x=1716836310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YE/50fVZUygll5/E+J0lzqNDHyTiqwcXxiLuvz283u0=;
        b=NF9get2unxLE4el03UCoNSAWaLY/8McNocBRrxXbEI8vyNWlJC0o+ATjLQSzFZGr/g
         oYPEoQFyfNgHouoXuS7xTzNHvin84oxkiCVeys869UVkhGG3D7WQ/4Kfhz4QjUmtLckx
         XdYaOk8mt31bq1PTK4C/wNkO3kE6U2D0z2FwaWx3n5SeY7XXZFsDEIk+dEVZjPVXWyJM
         RojdS+D4m5FFC/yf8NrFPGs1OwxOYsygR9usdSgluPqjC6mW0s7lgoGk5FnEcLmBSjQU
         0L7/0EM9+PoCkXd2t2+6d3Zxd0HNTxjhYCE+nLgNuyrV6xRHOlEpNcmK2S4bq4VAgRJI
         H2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXH+FATEv1KAdI2oKriu+g0AU8dDhrlN2bBECDZkn5Z/1cPnDs3i+5K8CVQPoCysXdcbdquTrQGHbDa6B58MCi0C8chlM=
X-Gm-Message-State: AOJu0YxDngH7kUFt8F7txJhz6KOgFfYpcNp9LzaMzAHXWKLlVsmeoTk1
	CleSfqsJ8zWAbFpHpoYBEJvFwO6eRc53PtftDv6o5SV45HbO+j6A
X-Google-Smtp-Source: AGHT+IE/CpVViNwADtAparpOZtZZqrMdJyZtb/9Wa3eFG9KM/+tY/rEM4D9bUBmgnl3ILvBboNDWsg==
X-Received: by 2002:a05:6870:160e:b0:23c:a5b7:5709 with SMTP id 586e51a60fabf-248e4e690bcmr3178914fac.1.1716231510030;
        Mon, 20 May 2024 11:58:30 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2412a68aa62sm5512163fac.29.2024.05.20.11.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 11:58:29 -0700 (PDT)
Message-ID: <d4d09174-1f12-420d-8ba2-96e2f3f9aa7d@gmail.com>
Date: Mon, 20 May 2024 13:58:28 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC - Add AT interface to qmi device
To: Tony Lindgren <tony@atomide.com>
Cc: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Merlijn Wajer <merlijn@wizzup.org>, Carl Philipp Klemm <philipp@uvos.xyz>
References: <2269874.vFx2qVVIhK@adam-laptop-hp>
 <42fea483-2770-45bc-9744-7063174b9ca7@gmail.com>
 <20240519182635.GF5156@atomide.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240519182635.GF5156@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony,

>>
>> Have you considered simply using AT commands for calls and SMS?
> 
> At least on Droid4 the ttyUSB AT interface is bit buggy.. But there may be
> a generic way to trigger lost QMI events based on the USB AT interface
> notifications.

Hmm, okay.

> 
> What we accidentally discovered with the Maemo Droid4 modem patches was
> that triggering a dummy QMI call on serial (muxed TS 27.010) notifications

Can you clarify? QMI call on the QMI character device or on the AT port itself?

> would trigger the lost QMI notifications :)
> 
> So we have the call below in the out of tree patches to kick the USB QMI
> modem based on the AT interface notifications:
> 
> int mot_qmi_trigger_events(struct ofono_modem *modem)
> {
> 	struct motmdm_data *data = ofono_modem_get_data(modem);
> 
> 	if (data->wms == NULL)
> 		return -ENODEV;
> 
> 	return qmi_service_send(data->wms, QMI_WMS_GET_SMSC_ADDR, NULL,
> 						NULL, NULL, g_free);
> };
> 

I'm fine with this approach if the handling of this quirk is done by the modem 
driver.  The modem driver can manage both QMI and AT ports.  What I want to 
avoid is coupling between technologies in the atom drivers themselves.  In other 
words, QMI SMS driver should not depend on anything related to AT commands.

Regards,
-Denis
