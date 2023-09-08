Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24610EE
	for <ofono@lists.linux.dev>; Fri,  8 Sep 2023 02:24:03 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6bcb5df95c5so1242572a34.1
        for <ofono@lists.linux.dev>; Thu, 07 Sep 2023 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694139843; x=1694744643; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0qntbtEX9RT8lz19R/9Gp84G1CbeC6t2vxa7/u3tM4=;
        b=CSmipFuOgtjvrdu3Jxu9tVkndRdk86xjyAhXBOGNMg85P70sPpjRpi3lHsEh1PAQXk
         MiRPmdl2IrzWqVnlpIqGsRKWnIhwSudjj8DX/wNoNVehZRr+Aca3RfhxKIuleIQJR/Ev
         yEjsYtzCo48xcTPzjtqryn7Yf5NpQg63V+iIEcuRQUBbHKuER6Ym/oOejQ+1jJakUyas
         XVKF9yX9fnvOCXQRsayUlM9mG7nrdhMvK7oqI28xpuw69gy59obf+EiuNdCOUyI6pLI8
         Og0RPdhWdl4DjtOEvPW4vKXuuGT0LJqpYrLVUeSnLv9PS+u5N6MPA05thwXSQiGrXTys
         16IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694139843; x=1694744643;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0qntbtEX9RT8lz19R/9Gp84G1CbeC6t2vxa7/u3tM4=;
        b=bm5hzgEUaLrmvfx/lZ9MmwPHrhfcDi7K2mkczISnMtvI/iaiqhhpU5iJcP1OjbFzxp
         0arriGDWXdeREArB6tIDVB/SvhfkiJLaQbkshIDKToSHbMQYmKnmroeYtrY4699oqT5C
         nHRumsLdvdgQVUGkNjD1igHpmwao873VoqaR8SDtPPQm4EhGqSCSAXS0Lzw5EKkcqgOC
         UsI4XYVeheTRgOLW58oyGqp1pYEY17WdPOPtMeAis2sN5swZOpZWDfFGOd1dQ4uqpgeL
         7nW3qfeDJoZJm68ilEFhZSjOaSC73OajINcgElA4Sny/GwEheXxZ5IjtnWKRxdBBL6TI
         onng==
X-Gm-Message-State: AOJu0Yw1Ohyd7h5jWLZdcBHBr0Z1UM9saAuQ5iJ5is6A8ktHw7hlRzg4
	v6hzyS2bjb4D6X8Sm0ciNQg=
X-Google-Smtp-Source: AGHT+IFjDrq7IOhYlG2qml2oix5hR0AfPyImowoPbDP584uAbYmZxBzmXcLmkSMohSyp/7xIxCJM9g==
X-Received: by 2002:a05:6830:1e48:b0:6bf:612:6c78 with SMTP id e8-20020a0568301e4800b006bf06126c78mr1135773otj.35.1694139842778;
        Thu, 07 Sep 2023 19:24:02 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f7-20020a9d7b47000000b006b87f593877sm312185oto.37.2023.09.07.19.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:24:02 -0700 (PDT)
Message-ID: <dc3b5e51-1b6e-f6e6-958b-0a6fba17d4a4@gmail.com>
Date: Thu, 7 Sep 2023 21:23:58 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LET context deactivation
Content-Language: en-US
To: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>, ofono@lists.linux.dev
References: <CAAcv5+6TL4qU9N-CsVDjusG=p-c4ZL3LYQQdCZyLDA4TkvJn3Q@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAAcv5+6TL4qU9N-CsVDjusG=p-c4ZL3LYQQdCZyLDA4TkvJn3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mohamed,

On 9/7/23 11:49, Mohamed Ali Fodha wrote:
> Hello,
> 
> I am using SIM7600 chip with ofono 1.31, when I set Online to true,
> the internet context is activated and it is not possible to deactivate
> it at all using the following command:

Note that on LTE the default bearer is activated when registering to the 
network.  One context always exists while registered to LTE.

> 
> dbus-send --system --type=method_call --print-reply --dest=org.ofono
> /csim7x00_0/context1 org.ofono.ConnectionContext.SetProperty
> string:"Active" variant:boolean:false
> 
> According to the log I saw always activate_primary which is
> automatically called after above command.

Are you running connman or something else along side oFono? Sounds like 
something is setting the context back up.

> 
> Any idea how to disable the automatic LTE context which is created?
> 

Hard to answer this without more context / info / logs.

Regards,
-Denis

