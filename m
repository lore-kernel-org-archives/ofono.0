Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AE3C1E
	for <ofono@lists.linux.dev>; Mon,  6 Nov 2023 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwZesaWD"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f0656b5c99so1590497fac.1
        for <ofono@lists.linux.dev>; Sun, 05 Nov 2023 19:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699239802; x=1699844602; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCP7tfD9mtUs06lt6q1FYXKx905mODT3EtJGsuK2N8w=;
        b=NwZesaWDUsVe5nfKKL1vIoDoWQJpmtR2an+jAVNNbqr/eiR1FO/AtDQNGhv0WQieI1
         f0K+gKNdtt00JU+WRkrKS+DhoXCmfVGy0cGQtjWDLPfJy9NVkWGrkAnz8TZ6rvoCCqW9
         T2jcoXmPpq7yA+etzn2ZmeWaiguCuNH3e+TmHi+o0Tqr45a1mLBUY1yGwCIqeu4OhDVk
         YEKS6SS9PYdAa697jh/Mv+w7uw0fDVQxw8O9mUzaTlGNIGtdeq730Mn6LPF0AfXHj+Xt
         zdvHIPmnd0PrA3bge8/keefYP2o2MlGeYltY2qulaKRfMmXMqCrNl6aGyD8ddtqKoBsH
         8XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699239802; x=1699844602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCP7tfD9mtUs06lt6q1FYXKx905mODT3EtJGsuK2N8w=;
        b=GDS3rpSV+jDZmcqYyl5MwL3RGHPtNUVqvr6YFg1sPI70jbOAiTK9QCgIiNhh2dN3sG
         d5+JkIsOBYI7kuERLTTI5RrZiWK9eaXaRateuL1L6YeF++wvB64KwxfCPJNI1wWLDArb
         CjE87GzrCPyBUFijO2i6yJ1wMB74/GLadQ9dYAubh0+MVO2xKlqnKJL4hDB3fH2/xkkL
         Z1UIJsEaETk1Gjk9iW+z3XwZOL+CPDYOkISSBZou/geDzWxWCFyF0mhqLURz0dt1ovWr
         4OK2mGwD8moK6Lk8TufVp00KXztc0WgOohWUGZOD5lQEdpWkiX6bXVvxGOti71FIhryD
         H4dQ==
X-Gm-Message-State: AOJu0Ywr6AX8Vfwbzk1oQyCFvPK7JhFeyghcF2dUxzVGbEgwTJq8tN7s
	KkM/GTFs9MKeJYx+yeDy8Uw=
X-Google-Smtp-Source: AGHT+IFCVEQeSLQHmIL26ZRUZN9j9DNJFHYPkKh0ujeWZv7m+CMMyTVSN2JPZT/DGYK6ralSWpj99w==
X-Received: by 2002:a05:6870:8a22:b0:1e9:e364:fad3 with SMTP id p34-20020a0568708a2200b001e9e364fad3mr4983967oaq.4.1699239801877;
        Sun, 05 Nov 2023 19:03:21 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z9-20020a056870e14900b001e98b1544fesm1263100oaa.9.2023.11.05.19.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 19:03:21 -0800 (PST)
Message-ID: <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>
Date: Sun, 5 Nov 2023 21:03:19 -0600
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
To: Sicelo <absicsz@gmail.com>, ofono@lists.linux.dev
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
References: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/4/23 10:58, Sicelo wrote:
> Hi
> 
> With isimodem (on Nokia N900), there are cases where the request to get
> the current operator name fails. This seems to be operator-specific,
> since it works fine with other operators for exactly the same raw
> packets.  The ISI trace looks something like:
> 
> 	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_REQ [id=0xE5 utid=0x2E len=8]:
> 	ofonod[27080]:     * 2E E5 00 3F 00 00 00 00                         : ....?....
> 	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_RESP [id=0xE6 utid=0x2E len=10]:
> 	ofonod[27080]:     * 2E E6 01 00 00 00 00 00 00 00                   : ...........
> 	ofonod[27080]: gisi: normal RESP to 0xb6c8d0e0 [res=0x0A, id=0xE6, utid=0x2E]
> 	ofonod[27080]: drivers/isimodem/network-registration.c:check_response_status() Request failed: NET_CAUSE_COMMUNICATION_ERROR
> 	ofonod[27080]: src/network.c:current_operator_callback() 0x57c940, 0
> 	ofonod[27080]: src/network.c:current_operator_callback() Error during current operator
> 

Funny, so it fails at random?

> However, there are also some frequent unsolicited NET_REG_STATUS_IND
> messages that contain the operator name (SZ 02/Eswatini Mobile in the
> snippet below):
> 
> 	ofonod[27080]: PN_NETWORK (0x0A): NET_REG_STATUS_IND [id=0xE2 utid=0x00 len=124]:
> 	ofonod[27080]:     * 00 E2 00 04 00 18 00 02 00 00 00 05 00 53 00 5A : ..............S.Z
> 	ofonod[27080]:     * 00 20 00 30 00 32 01 00 01 00 00 00 09 18 01 2D : ...0.2.........-
> 	ofonod[27080]:     * 00 64 7A 36 56 F3 20 02 00 01 02 01 01 00 00 1F : .dz6V...........
> 	ofonod[27080]:     * 01 01 01 00 E3 24 03 00 00 0F 00 45 00 73 00 77 : .....$.....E.s.w
> 	ofonod[27080]:     * 00 61 00 74 00 69 00 6E 00 69 00 20 00 4D 00 6F : .a.t.i.n.i...M.o
> 	ofonod[27080]:     * 00 62 00 69 00 6C 00 65 E3 24 02 00 00 0E 00 45 : .b.i.l.e.$.....E
> 	ofonod[27080]:     * 00 73 00 77 00 61 00 74 00 69 00 6E 00 69 00 4D : .s.w.a.t.i.n.i.M
> 	ofonod[27080]:     * 00 6F 00 62 00 69 00 6C 00 65 00 00             : .o.b.i.l.e..
> 	ofonod[27080]: gisi: No error information IND to 0xb6c8f2a0 [res=0x0A, id=0xE2, utid=0x00]
> 
> They are handled by isimodem/network-registration.c:reg_status_ind_cb,
> which currently does not extract the operator name info.

Refer to ofono_netreg_status_notify implementation here:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/src/network.c#n1347

Every time the network registration status is notified to the core, and it is 
roaming / registered, the driver current_operator method is invoked.

You can try to handle the NET_REG_STATUS_IND in the driver, cache it and invoke 
the above notify function to the core.  Then in the current_operator driver 
function, return the cached name.

> 
> Storing it in `nd->nitz_name` as in the `name_ind_cb` function,
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers/isimodem/network-registration.c#n882
> does not appear to be enough, since this does not have a related 'sync'
> to core. So I think that function is also not fully functionally yet.

Looks like the NITZ name is returned in cell_info_resp_cb().  Basically what 
this does is it runs NET_CELL_INFO_GET_REQ in order to obtain the operator 
MCC/MNC.  Then it also copies in the NITZ name if available.  Doesn't look like 
this path was well tested.

Seems your driver uses a different path, one going through create_name_get_req()?

I suppose what you can try is to return the nitz name if the name_get_resp_cb() 
fails to parse the operator name.  Just make sure to reset the nitz name to 
empty if the network registration is lost.

> 
> I would appreciate some pointers/suggestions, then I can test on device
> and submit a proper patch.
> 

Regards,
-Denis

