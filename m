Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131382869
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407250; cv=none; b=A/vqqtBwzxOY6ChRZ67GNsmdrh01opgE+Fvgo1ht4F94me0pUDYEvuXv0khqenXM9Z5ytvg1n7BwBveMI+XSqqiwlW4+0gu6Zyee301nBGuItmwSxHrocIEBl08CQvXjcS+2npl68tRa2RaHxwsgI0IcYm2KsSiMQ22r5QbVzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407250; c=relaxed/simple;
	bh=snZtSC9tlieftJ8/oEk5f250qcFlNaaw7ouaTroWlJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXxsIDXJpyuOyeTOYfwEPxrduteBIQM0bElMBDZ5ecjNP+dYynIntiSqJrxg93wVg64wYRh9k3n/GgRkYE+n7hgPRRqMUdIt2sTjZyp7V6Ec9kygIR2P/Qn/QYrWDZOB/Y6km6aQ8MaQUiPG+XQsGAaKSKFvx+BXgbIe1SU5tWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3+tx2Ok; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3+tx2Ok"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ac90ad396dso2650818eaf.3
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407247; x=1715012047; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrEYt2rhUK7t3oFcNRqIIXjbiPkHE9bvWYdSTOr3+9k=;
        b=b3+tx2Ok+gn0V5Es/oIZNK2NsLPW7dJWvKav0oHh2wuM0PwzRGVqESJzCPYqZ1FQ/y
         lOZa8coTxgyxSGnlSZzIxzEyeDKDU/EeN6PhZCcSME2dYOHgNrz4293wJL6kCW/yQHhT
         PUlNvwrIGy1FB0Xs0yPHxlK7lYhNxMjUSay64AP8eGdEgG2yOUZn3UkLYXINB/4EbOWQ
         AAYaLJRJgB9xVJu1G1JUWuT0l+FcqN2KF/5QUavIQ0hpKCE2fdEEm+x5E3sky9AAtpGH
         +/uGe6d+qeotPFmHU7VqSJsRkiaz4E2H0pAvWujUh5erHeRVUhQGzh/r3hM2jkzVb15y
         dWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407247; x=1715012047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrEYt2rhUK7t3oFcNRqIIXjbiPkHE9bvWYdSTOr3+9k=;
        b=hyd0xWxk5VvieTRoDL1c7cUYq22OfLhuABNbNPzb+ohdM0u8WHUJRuS7IYc51MoMIW
         zmTIAya/SaHvxAkkNULAVeUQe2QmQyrks3RZdsvHVrW/KvgzzAk2wIdb2p0oW97Rz6H5
         SBOAjTOG7CzJCZ30C8oVmtwm1zAkCogqrdH3TOkj1iMPHc18BnH+pTSzKbSUYNUbKPkn
         llkZ+Wg6gcOpmY1zABb6ustmKTQ/nuQO5NJgBYO/bVq87R7JrD4XGyGT6ChjrCfco2DW
         IrC5qQ/jBuawEzXL5h3LxV2MWKqG+Q4xW5B2c50fLJ41LQtX+AfIcw8SOZ9SjL2HXa6C
         fMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+60KO5V7D5i3X4QD65HlhWZz12uXcPj4a91Jdw9QfqDe/XpIaObIylt4mBUiobkH276SzheLcIu8JGT1YzQtn8p47u4=
X-Gm-Message-State: AOJu0YzrtghNeAEFFceh9w+vwG5RDYhZEfQ3o65mp23yY2napHRzrMVc
	17qTnAIQZ8eCubROXDGdYZFq68cwLc76N3Yzdn/kI+bcaRYj/fVg6iFHTA==
X-Google-Smtp-Source: AGHT+IFaSnfZfxOaPGUqK+RB1WDvfURow71Mn97fHzZx149VYX5jKV+oeNOpDcdSyBBQu5b/mPISOw==
X-Received: by 2002:a4a:ad4b:0:b0:5ac:6891:cee7 with SMTP id s11-20020a4aad4b000000b005ac6891cee7mr12104730oon.3.1714407247438;
        Mon, 29 Apr 2024 09:14:07 -0700 (PDT)
Received: from [192.168.1.20] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cb3-20020a0568201b8300b005acee9cdcc0sm5009050oob.42.2024.04.29.09.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 09:14:07 -0700 (PDT)
Message-ID: <6df19933-f054-497e-9fff-4fd3d1625752@gmail.com>
Date: Mon, 29 Apr 2024 11:14:05 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
To: adam@piggz.co.uk, ofono@lists.linux.dev
References: <20240426212235.2627-1-adam@piggz.co.uk>
 <5571717.rdbgypaU67@adam-laptop-hp> <9691207.eNJFYEL58v@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <9691207.eNJFYEL58v@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/27/24 12:31 PM, adam@piggz.co.uk wrote:
> I thought I would include the valgrind output while removing the modem mid-
> call after sending some dtmf digits.
> 
> The leak which is identified at the end is in a patch im not upstreaming, which
> is part of the making the gobi driver work with the other patches im using to
> support sailfish.  The other thing of note is some logs relating to the SIM
> code.

Thanks for the report, this is exactly the kind of stuff I'd like to see when 
people report possible bugs.

<snip>

> ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
> tocopy: 10
> ==1888== Invalid read of size 1
> ==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
> ==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
> ==1888==    by 0x4C236F: sim_efpl_read_cb (sim.c:2456)
> ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x49B0E7: event_check (main.c:196)
> ==1888==  Address 0x5fd229a is 0 bytes after a block of size 10 alloc'd
> ==1888==    at 0x486D6C4: calloc (vg_replace_malloc.c:1328)
> ==1888==    by 0x4E24D7: sim_fs_op_read_block (simfs.c:443)
> ==1888==    by 0x4A333C3: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
> ==1888==    by 0x4A36647: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
> ==1888==    by 0x4A370AF: g_main_loop_run (in /usr/lib64/libglib-2.0.so.
> 0.7800.4)
> ==1888==    by 0x41421F: main (main.c:314)
> ==1888==
> ==1888== Invalid read of size 1
> ==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
> ==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
> ==1888==    by 0x4C23EF: sim_efpl_read_cb (sim.c:2463)
> ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x49B0E7: event_check (main.c:196)
> ==1888==  Address 0x5fcd46a is 0 bytes after a block of size 10 alloc'd
> ==1888==    at 0x48687E8: malloc (vg_replace_malloc.c:381)
> ==1888==    by 0x4A3D29F: g_malloc (in /usr/lib64/libglib-2.0.so.0.7800.4)
> ==1888==    by 0x4A5781B: g_memdup2 (in /usr/lib64/libglib-2.0.so.0.7800.4)
> ==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2381)
> ==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2372)
> ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> ==1888==    by 0x49B0E7: event_check (main.c:196)
> ==1888==

This should be fixed in ell in this commit (part of 0.64)

https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=57fcbf80bff6fdbf10b21bd4d3f3e282f14599b9

Could you upgrade ell and see if this is fixed?  Might have to rm -rf 
/var/lib/ofono/* first, to make sure the sim file cache is cleared.

Regards,
-Denis
