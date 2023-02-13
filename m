Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534D8F7C
	for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 17:07:33 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-16346330067so15935375fac.3
        for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxTKQB5RZmaizO8+r9dNkZ+utV3LWw7GM2A4WG0qIC0=;
        b=OnVNIYgdMywl3gtVx/I3mfADZiSCEtDmixWPb41HbxScpnB7PXDnclnVWDXwWehEu0
         HBJp2uKRx/aLGdRmDU8K1HrMPorkoxym2h2Ft6vYa0AI+IIGPd9HJznw630WDdKGvyIG
         l1/K6qkSHUIOdqqTOlkqsNX+WFDRlEQWsXYgGBBmkXDJmka0/9A/Y94X30/OFZN7zq3Q
         XpRotD5d8kAkY4LPfh6TOGPOc9g/6mlbdrjUN3/0/lfjCj6SFcDrsCIPhRtExw0G9ado
         ZpzLrNOZMrFsoR2xaM0xHQ9hodSI86v/DURYPR2EVhTdaE2tEhgAjDdIflm2NeXOmf3P
         LIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxTKQB5RZmaizO8+r9dNkZ+utV3LWw7GM2A4WG0qIC0=;
        b=F9+xUUI2zNqXXCwqR/pHa7SlA7Qv/dUIcDKe8+DKnsAlI5vDvU+j/wnSTgHj+hWl/H
         QOaRFhZxKS2NVv5Grx0m2UxLWgJlcldiYAz+Gby7EjwTxl/KQMmcsWSf8YOi7PgL3kiT
         NU5l0mGFI1FFZSNh+MAROD6Qmrp8DCba/aOgSkYOozR3lIX54ETx1eWJfxf9dUAwRY/J
         Ej3sCTNiXu+uM6bAvPsQYB6Ah3IX+mMWboGr5aVUnE8gzjw3hGhZFwXj1BVvrA7a/84w
         dRic2XkdZKbBi65j8LuPtuUG1JNBLWBlW0NR+omIBpqeDHudtGgiqf+4nhJ5MWlJFn/k
         LREg==
X-Gm-Message-State: AO0yUKU/feQNWbyzpGgTZQsceujFgrl87TGbFIbykkeo66CviY4ucVmI
	GMDRzuJULMYmmHZDw89fS+M=
X-Google-Smtp-Source: AK7set+DtVYSr7+2jeXJqXp3fRjdukj/s6Up/Ajo+xv0/pgQvi6KDihF632EghgU0/gmlATAlh7www==
X-Received: by 2002:a05:6870:4190:b0:163:a1a3:912b with SMTP id y16-20020a056870419000b00163a1a3912bmr16499823oac.56.1676308053064;
        Mon, 13 Feb 2023 09:07:33 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z3-20020a056870e14300b0014ff15936casm1286708oaa.40.2023.02.13.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:07:32 -0800 (PST)
Message-ID: <6b1d80f0-3158-71a2-9b22-c56991d1fd11@gmail.com>
Date: Mon, 13 Feb 2023 11:07:31 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 4/5] plugins: quectel: re-organize code for ussd &
 lte init
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>, ofono@lists.linux.dev
Cc: patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-5-alex@shruggie.ro>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230211181105.7220-5-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/11/23 12:11, Alexandru Ardelean wrote:
> The BG95 modem (family) supports LTE, but not USSD.
> So, we'll split the init of the LTE separately, and add a helper function
> (called quectel_model_supports_lte()) which will return true if the modem
> supports LTE.
> ---
>   plugins/quectel.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

