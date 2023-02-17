Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A7746A
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 15:17:15 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id e18-20020a056830201200b0068bd8c1e836so220312otp.3
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP/tK1MFhc2YqVdyq7N4r3KE8nJGQPC2bBiuCOC3TU8=;
        b=Ns1YY94Ygu05xE8CdHA2YjWKbUpMrbr6vXchiN+sWZH5y9aB3U13GLZ7O6H10ekVbh
         ihsTb8s0Q0KsYT6tUSoRpg+rKDLCOKDI7r0BPRb/rW+I1QWotLNv74rJ/ejsK4JdweUv
         0tzHykp7rQ7ReNGuWKEPWfNRngEON2Qrxsjho+W2PUXtd4kKpyasG8jw7fz4nLEnNe6C
         7UI2XG2zWW/FcptjcjDqEg5bCDvLf936GHOwboY3X5kjNpgZ2rcO8p5ZId8ULeXqG3My
         212l/qNoCQgDfNaxzrF7qbrKiHHMbFCuaNS5qUdcT+EEcrY8CEfmUD1jMag866hEOEbe
         ad+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP/tK1MFhc2YqVdyq7N4r3KE8nJGQPC2bBiuCOC3TU8=;
        b=Bn51vMS2BpJbFxFdqOWrj8WVZql01vWDseAhvX7ezmqf3fLa2uOZ/4aRmeHgADbLVy
         vrYf7u0i+tFGupIs/IWnqkLEB7fTiwMFvVinDNi3CfwQ6lwypCkMp5+h/+jI9aueFcv6
         hHMuWpAGfAQyoNZ9J353sVXfZiT3t1EHFCeWD/vC2+OeX+aZcgXa/CmXc9CfKNQ7JoGr
         QcfTMHpybTyr4G1LFHS5ucHaamvagK5j4gv9bRmQuqNxtf98wCTV4ATyIw52v6Qmpj9Q
         DuF3DLCMNq2Wnh1DkSHHEI0BERgTJULynazBQoBMi8tCbvvf22g+mkVKbin6Mfhl7zze
         6bJA==
X-Gm-Message-State: AO0yUKVm3thel+ZyZlS7mBb0RE2BpinqxI8l9FZ/eLfXRmPTsZsHCLP5
	yWhK2ZppYttOB6puiWVXBdQ=
X-Google-Smtp-Source: AK7set+/3eeHlz1MW24e3FopkdYenAk5jshjp7fjcL20FQYstbafWvQlUDKexl2A/vZT8uCByrlDGA==
X-Received: by 2002:a05:6830:264f:b0:690:a6b3:a2f6 with SMTP id f15-20020a056830264f00b00690a6b3a2f6mr3195907otu.0.1676647034441;
        Fri, 17 Feb 2023 07:17:14 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056830110100b0068d752f1870sm1962218otq.5.2023.02.17.07.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 07:17:13 -0800 (PST)
Message-ID: <f1ac996c-c9fe-8d07-fd6d-5cfb83e68eb5@gmail.com>
Date: Fri, 17 Feb 2023 09:17:12 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for
 modems with no slave channel
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-2-alex@shruggie.ro>
 <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com>
 <CAH3L5Qr7LNSHEv7N3B1JC7_vnbiiruxZd+x_-GxU+Yo4XvJkpQ@mail.gmail.com>
 <CAH3L5QrM8akr3ChdmqAOLHNd5hTArTXkVcUHtz6MFH+5kT8Upg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAH3L5QrM8akr3ChdmqAOLHNd5hTArTXkVcUHtz6MFH+5kT8Upg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

> So, it seems we have an issue with our current modem FW.
> It may be too old and we need to update it, to have things running smoother.
> The kernel 'option' driver enumerates 4 /dev/ttyUSB{0,1,2,3} ports.
> One thing that was confusing (for me at least), is, (in oFono) the Aux
> port feels more like Modem port in the context of the atmodem driver +
> quectel driver (and at least for BG95). But that's just semantic
> probably.

You may also want to check whether your device isn't really an mbim or qmi 
device in disguise.  Some of the devices I've seen over the years will actually 
ship with a single (reduced functionality) AT port, but have to be driven by 
other protocols.

I know nothing of this hardware, just throwing this out there.

Regards,
-Denis
