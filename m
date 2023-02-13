Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DE8F7C
	for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 16:52:20 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id bi19so10742347oib.2
        for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=US1hy+8euCoU/QgxjOFOU6J2YCQJB3ot1zFDfETD1/I=;
        b=h78KEp20mUq6nloWY6qlkvtaCWKgUkpN7fcQxQKEJswX5IoUW8saxBQKWRTXaTtRv2
         gESJ1Ln/b9cNHOdHF/xL9HSOixECtq75/IwRpCnE76oDAmaGQA016h0J2SctOaQi7TyO
         rIf4B7PUWBjwINP/jeOhrbB+tETdDD9sskxYdaTT9l4hCqHaf0llgj7gAxXkbo8nln61
         vHyt1WF7Iy4MJ5b0Zx3Bc6WSEvDkF/sIvgO75TJgwKr0QRByfYiJV5Wnw9WVNB0jUACi
         aokawuXPAE3EoeHUtsHd9Vo0WtBcx+PkY+urFtMTfW2yetYHavpFt8oQUQRXLXTfIJSC
         FMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US1hy+8euCoU/QgxjOFOU6J2YCQJB3ot1zFDfETD1/I=;
        b=RC7kWEOMYSFe1tEtlKIU1ROMLLOpuwVT2/iu1xDGdZslDi2lA2v6XjOcBsx1tF7/Ki
         Kv2zohUTrAehmICtvrYZuWeswLmywqhmpeQLM8tGCfOrsXm0cCCRfTcZfWQVlDGSatDh
         Ymkqp78Orq2i1QJoiUDcuH05YrNyAnXTq+5HRIGHKr2lRy8zRuAK9tTDa/gaCkx2HXqu
         /lYlO5oVpKdKT4B3zB7qlfFDrZYRS0InXNY3t1F+9ZHSQp2a6TxM5WbOSEmmtkhVzSGM
         QRPOESo4i6dd9mHehf8CyZoVmDPg2tPq5KHlP+/NbwadpEl408oebrKA7obmXlqAe0IJ
         qMfw==
X-Gm-Message-State: AO0yUKUTqZb7GSANhySUqy1rhp/yLOTuxkcJRIdlm2qMIlPsSQCYK+3i
	nhOumMfGTXySfLZXA1o7ckk=
X-Google-Smtp-Source: AK7set90XK9HzqIKmsSpO5ge9R7305Plkh91tRdsIonqRxU7PsEVioj/4j/2/PXIFwGAaHLfzLbV8A==
X-Received: by 2002:a54:4882:0:b0:36b:b779:dd6b with SMTP id r2-20020a544882000000b0036bb779dd6bmr11650248oic.59.1676307139495;
        Mon, 13 Feb 2023 08:52:19 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s16-20020a056808209000b0037d74967ef6sm3023571oiw.44.2023.02.13.08.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:52:18 -0800 (PST)
Message-ID: <849beb97-9939-ae1d-a6e8-24dd66097ada@gmail.com>
Date: Mon, 13 Feb 2023 10:52:17 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 3/5] gprs: extend on_lte() to check for M1 and
 Nb-IOT techs
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>, ofono@lists.linux.dev
Cc: patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-4-alex@shruggie.ro>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230211181105.7220-4-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/11/23 12:11, Alexandru Ardelean wrote:
> The BG95 is an LTE modem with Cat M1 and NB-IoT techs.
> So, when it happens that the modem registers to one of these techs (in our
> case Cat M1), and there is no GSM advertised by the operator, the modem
> will not attach.
> 

oFono doesn't really grok these technology types.  It must be taught to handle 
them properly.

> Following the current logic of LTE, it looks like we just need to extend
> the "on_lte()" function to allow for these techs.

Or maybe treat them specially if they're not handled like LTE?

> 
> Also, not checking the .read_settings callback existence. That looks like a
> hack done for EUTRAN. In our case, the BG95 is controlled by AT commands,
> so there is no .read_settings hook yet, and we don't seem to need it.

For LTE support, .read_settings must be implemented.  That is because you need 
to obtain the default context details (see my reply to the previous patch). 
This is needed for matching default context to provisioned ones, etc.

If NB_IOT* acts differently than LTE in this regard, then modifying on_lte() is 
probably not the right approach.

> ---
>   src/gprs.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 

Regards,
-Denis

