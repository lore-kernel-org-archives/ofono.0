Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E30322
	for <ofono@lists.linux.dev>; Wed,  8 Nov 2023 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIJ09Rz+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f06931e4f7so3579972fac.1
        for <ofono@lists.linux.dev>; Wed, 08 Nov 2023 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456621; x=1700061421; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbgPekoJ7L3YGIf40YcGMARJq/7jlmZdXGo4yrXVv+Y=;
        b=SIJ09Rz+MPSC26f/OGLWlJNtClwJpNdmBirSogeM0rXMa2c8ue6RUYGTtqYX7EsGeN
         rLgn1NxZGd5bnb7c5xEPXf+nza7A9D7o9MRO+zNC1vg2Qhkjz0B9tEdpnGcd3CFgPTCF
         K63GWpoVlPr4foynZKEeRTeFyrt/Q2H9/V7T96+hzfCE3Qz2eJHTFc7f2NX99a+/tR5a
         +3oNYmgYY2KEV/SztI3hhNIA5xBWSR4aZt54migiwzhV03vmXkkZYpEP0NTjAm3q0glU
         pNJ/at9CC21XxwX+Dtj4x5HNNKvjXchUrYFP2cvjIIyctAziHEaZRatXa5eOOkbHH1KH
         7bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456621; x=1700061421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbgPekoJ7L3YGIf40YcGMARJq/7jlmZdXGo4yrXVv+Y=;
        b=syifv18orwWpeqXog1zgbPfUJn+9V3anKbtfFcpmFW2wLtXlpORAoo26tgLq0SUQT2
         xKzQc96GYaNe6H/xR5fJMi2Z2ARIO0Etx4STRU2hqMAgDUkHZV8fo+rLmhj/yWhh3d+l
         xFqu94D3Nuffw50YXZMkkdpmJfUGe0WQopMbtE4w4suSySDfUQ31tX/q9nE8LwStlkCU
         sDcHW+3Q22jAu4bjo6REMtQNzS3FN750eHX83Y7IJVAWchAkXV6ripOp/XRxUbazRTTO
         BAJwGUiIXkTLVv3ikH095NrmW7K8/+0009NI6p36ZCHcAb8QRuNotpT26pFIFRjxiO6Z
         D+Dw==
X-Gm-Message-State: AOJu0Yz/zIXuEKWVIyg9v5lNjCCyMUjxFP/Knr9K2PdUt/cQYKfQ9DRz
	06HVoL/+e0zUM/D7xNWnKGg=
X-Google-Smtp-Source: AGHT+IFrxd7aKBbl2KPbSColmWe8tgJfC7GJA37PwPbmHMYxSzJV/6Q8Ws8+4INajRGtoJF4CRlxVA==
X-Received: by 2002:a05:6870:ac8e:b0:1f0:5248:c6a6 with SMTP id ns14-20020a056870ac8e00b001f05248c6a6mr2243703oab.51.1699456621303;
        Wed, 08 Nov 2023 07:17:01 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dy12-20020a056870c78c00b001c5a3e31474sm336855oab.45.2023.11.08.07.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:17:00 -0800 (PST)
Message-ID: <13f52749-bc4f-4391-9447-5df660d3384b@gmail.com>
Date: Wed, 8 Nov 2023 09:16:59 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: isimodem: reporting operator name to core from unsolicited
 indications
Content-Language: en-US
To: Sicelo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
References: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
 <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>
 <ZUti7nteHmcie5a7@tp440p.steeds.sam>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZUti7nteHmcie5a7@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

> 
>> Refer to ofono_netreg_status_notify implementation here:
>> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/src/network.c#n1347
>>
>> Every time the network registration status is notified to the core, and it
>> is roaming / registered, the driver current_operator method is invoked.
>>
>> You can try to handle the NET_REG_STATUS_IND in the driver
> 
> This is what the POC patch I posted tries to do.

Right.

> 
>> cache it and
>> invoke the above notify function to the core. Then in the current_operator
>> driver function, return the cached name.
> 
> This is where my lack of skill gets exposed - reg_status_ind_cb only has
> access to netreg of type ofono_netreg, and nd of type netreg_data.
> However the notify function, as called from name_get_resp_cb, requires
> to be passed structs of type ofono_netreg_operator_cb_t,
> ofono_network_operator and isi_cb_data. I am not sure I see how to pass
> these from reg_status_ind_cb.

You can't, but that's okay because you don't have to.  The flow is like this:

*unsolicited NET_REG_STATUS_IND notification from modem*
   drivers/isimodem/network-registration.c: reg_status_ind_cb()
     - parse operator name and store it in nd->nitz.
     - parse network status
     - Invoke ofono_netreg_status_notify
   oFono Core ofono_netreg_status_notify
     - registered or roaming, call current_operator() driver method
   drivers/isimodem/network-registration.c: isi_current_operator()
     - Return the nitz name

Or better yet, fall back to returning the nitz name when name_get_resp_cb() 
fails somewhere in check_response_status(msg, NET_OPER_NAME_READ_RESP).

Regards,
-Denis
