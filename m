Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDD154AB
	for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjquvUST"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso2370886fac.2
        for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699813891; x=1700418691; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY/tqnWwosqyQR1ZMuYdfjhQUFsRiPxSug8NClbCvqw=;
        b=GjquvUSTzngm2GTZzWuojJ15OQzvIEyTlEBEhi35DLabQAvfqtNQTF1sNilR411U62
         dPJ74QN/ByoQDWrEhxoRhc+dL2B6/Rxo+JQqlb83nTOsWke8cXIoZLMeZkoA1bfEs5ou
         ebhbgjwMt5HpPpu9A3LO2qw1CRvUmhSbgzpFcD69sFfm5mE9ntHefZgMo+zLDQqWi1EV
         EhriLkqAvQwa0N8rR3Vvar8LL1vY1+eX8BffueWsW7UJZcYGCIwDJCvifqGXE9OaKujH
         S59oF0PEyqOuZ1HtdD326PolYaxlUVRr8i+DWHYdEm5Y9i70PV7Sl4IefpRGa+q8VuPR
         a4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699813891; x=1700418691;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VY/tqnWwosqyQR1ZMuYdfjhQUFsRiPxSug8NClbCvqw=;
        b=WDgsPmns+rWZTo3JgcVvnvsDaW1tRL8T2jjQgWyEhcAZTPK1XWjTzmqPwXB77WD3dP
         6wZw9v7l2ews16d7FhFFBLLlneLAKiK06K4hVLUEGwS3/oyByjT1Nmt4KiCks0tH6Rg7
         yjjCJxTv8nEFkZioy91UB6PIGv+U3dl1eq6no+AyLN338gb07VPftR6y3ugDD1eoYfbz
         WL2CflWQT2opU/+0AAVGG7O+t4NoQTx1bw95CjYP3gEgKP59bKjZwNsMf/cuP4tVdgxl
         YIGf7yfxhX/COHapJjQMBCgTabSKKUWZWmoIS8UaeZUFz6xawGVjToHnxi8VbZYJpt2w
         p05w==
X-Gm-Message-State: AOJu0YyoNeZvGDsHMJ4Aic0CSPgB15CIcePB4/fsfj/YVq4IVEzQMBu9
	IloFqRkvLbG3tCZfL5uKS51kXE8a3P4=
X-Google-Smtp-Source: AGHT+IFUQ9yq4E8o02WwL1z2HaGZGCroPcb5MM4sSVgiM9ffzw0+f84s413gytOY5Pn6SIFZm/mcLg==
X-Received: by 2002:a05:6870:b694:b0:1bf:b863:b6d with SMTP id cy20-20020a056870b69400b001bfb8630b6dmr6546084oab.1.1699813891289;
        Sun, 12 Nov 2023 10:31:31 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j3-20020a9d7383000000b006b871010cb1sm587051otk.46.2023.11.12.10.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 10:31:30 -0800 (PST)
Message-ID: <4cd8c507-0685-449a-9a8a-9cb36512f5d7@gmail.com>
Date: Sun, 12 Nov 2023 12:31:28 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SIM7600G-H: cid 1 activated before atom registered
Content-Language: en-US
To: "G. Weinholt" <g@weinholt.net>, ofono@lists.linux.dev
References: <ZU354V7zyCseX1r2@castle.weinholt.se>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZU354V7zyCseX1r2@castle.weinholt.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/10/23 03:37, G. Weinholt wrote:
> Hello,
> 
> I have been troubleshooting a problem with a SIM7600G-H modem where the
> LTE network does not come up after reboot. It can be worked around by
> restarting ofono or connman.

After reboot of what exactly?
vi
> 
> A symptom of the problem is that the context can't be activated manually
> because GPRS is marked as not attached. I've verified with both the modem
> and Onomondo's signaling logs that GPRS is attached and oFono is wrong.

So how does restarting oFono help?

> 
> # dbus-send --print-reply --system --dest=org.ofono  \
>   /sim7x00_0/context1 org.ofono.ConnectionContext.SetProperty  \
>   string:"Active" variant:boolean:"true"
> Error org.ofono.Error.NotAttached: GPRS is not attached
> # mdmcmd /dev/serial/by-id/usb-SimTech_*-if02-port0 uart 'AT+CGATT?'
> Starting with device
> +/dev/serial/by-id/usb-SimTech__Incorporated_SimTech__Incorporated_0123456789ABCDEF-if02-port0, command
> +AT+CGATT?
> Received buffer: AT+CGATT?
> +CGATT: 1
> 
> OK

What do AT commands have to do with qmimodem?

> 
> There is an interesting log message: "cid 1 activated before atom
> registered". This message was added in the commit "gprs: Ignore activated
> contexts during init, list them later". That commit was followed by
> another commit: "atmodem: Implement the list_activated_contexts callback".

I'd have to see the log to say what exactly is happening, but...

gobi plugin sets up gprs in post_sim.  If your contexts are not being 
provisioned, then ofono_gprs_register() should be called prior to the modem 
going Online and prior to drivers/qmimodem/gprs.c ever issuing 
QMI_WDS_GET_LTE_ATTACH_PARAMETERS, which in turn generates the 
ofono_gprs_cid_activated() call in question.


Regards,
-Denis
