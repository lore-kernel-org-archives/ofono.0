Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339E3093BD
	for <ofono@lists.linux.dev>; Wed,  1 Oct 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331011; cv=none; b=Qfk9tw7ZGXWkc7MLK6thB+nxN3bcTSfZlng9Di+MKEB+kJAywI0AssmWimBUaN532xIkuXN6vLf/lWiaET6azvMPYDsE33QFQ9dY+0s2Izw6KdqAvsGGpJY+4NOBEzLzBjTYc44Q0377yhXHnHRMcHfemfRO9ENFN85tmuJ5cIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331011; c=relaxed/simple;
	bh=56TdIiSOkcCsP0nutLdk0BoBr5DKB4LI+H6lb9peRes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhRUvYxMeHMX2V9EF7PgG5YLEQBaWOjBDdZ5A+3myhqX503rHoA35P0s23kNohunYoqnFHcJeGu8DM0+67a9CJaihI2oAxv/BxRbTpQo1M/66w5jwR/vo+y+9Agoq9VTqON74aokbs+r5ijAByfWFn/XkQjFjFjoiUYkEM9QkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axO1FdvC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axO1FdvC"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-79f79e37c04so5251410a34.3
        for <ofono@lists.linux.dev>; Wed, 01 Oct 2025 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759331008; x=1759935808; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tt66YiQ2pfl9PFEdKJcU/VYZjJjw5u6A5Dj9x04CyPI=;
        b=axO1FdvCfmgOKG3dwiNLUXgPo/fVCrURDz+12hLxDojnCgNqF4h0iOp8z+Nol0CSVz
         Z3+MdSYsc4oRkXbes2rkRFOLLb9jLF/CChgi7xA4K6DVE+YEaOc1Nos43txjjfm0L5XR
         AEG8COMIHYkbZ1lKUhQ9Rk+hjUEBssRf2gtXnbsQgfnu3xau1WlfumA8l11IB4RgpDyw
         wYc8avUjk+JblOtIXN89yfMaG9HI7LDZmo2+AuUgFwnfh6RJAE19AhB2zwVZMDuZsnQc
         8Yl9umRjNaQ2WGa9GuFtgLk9SEuKYDHENAn2dXD9n21OBLCbfxH4NkwhdvO3Og46LYga
         Ubwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331008; x=1759935808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt66YiQ2pfl9PFEdKJcU/VYZjJjw5u6A5Dj9x04CyPI=;
        b=uMTesvB6cG9IHrzl7EnCXfyr+j140OupkGoI2t2+f8UhoRs5eq5yDJFDGGhdQNToyv
         hlpr64zYuvHV+z+77KNYLt0guKfVd9nLs07t+gb0VyNdFhBefK8iLRPH9x1dQjzDWXrx
         T7Nus+pCVzPJ4HyRrwdyAM71avyi6X6nYfPmZp6jM0W9lq22iSdSuLBRP6kIMZvbKcz3
         aQ+2gOA3yNVMty1H3k27zj2WU76y+iwBlG2Z0ToNOwCrqMwXgYn+dwnf9wQA5EKkILod
         NXWBENv9MEnJruaQsVWGs6nR7iKU19YAgNU2kBVIJAPB1wxxhKUOqOeWE5MAy+PFiTlw
         +qsg==
X-Gm-Message-State: AOJu0YyfbhIPY0q9KYdb9qI0TjpnrWmhVUb+FYJT483GxgsF18c9X2NO
	99iXZMhEcfb6B+w2/TVS+Ni3nseCepeKkjV8OU8yIDS6GmAOTxpYfFuM
X-Gm-Gg: ASbGncupTffqm1OA8TNZFedlzEzPOD2GKOwOqlyeJSiNPInydbUBYN6plyLFIpmJMBn
	2eBNwCd9Uqp+GUaK0rKhJFhczZlznfjoT22SUUpE2WVwpJe1BRBdeIKJAeVhbF9al6wbw30RmMP
	GyXQec7T5ebpHpG+JzrgERxZ5YKe6R7+czfoPLtUyfW1wQO2pmxNFGXdtdKgHt2ICgFkzJQx48F
	zpHFSAX33t3u2nE5vBoJVUbjqsHXvuu1EROJntiiTAWK2aLwTVmLB2Tsr4PjJvjQho3+HVdZEYl
	o17lnae8LwivI1Zc95BaIu+xfQ+iwSk4/HewsGsKmhIP0qTMAF6rwNK807sCEsvGhP64qu6goVk
	wFLP90G9/BonzuWV7o2LfZUgFJ5D9iWy4Z9XqDFiBMZzekZ0P79DIcPSsCUOYfr0C3iAP6iMNlM
	0AWEjF9oxE/b4D0qUCpGcDwpE=
X-Google-Smtp-Source: AGHT+IGssqX7Fl/X2tspX7yz9eoSOvQCkkzKiIvlYbPCn2AlgyvzjR4HHm89wP9605v4Ob3nfGJU+w==
X-Received: by 2002:a05:6830:6282:b0:7b4:116d:98c5 with SMTP id 46e09a7af769-7bddb9dddd6mr2187804a34.21.1759331007687;
        Wed, 01 Oct 2025 08:03:27 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7a23e53ce60sm4003073a34.25.2025.10.01.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:03:27 -0700 (PDT)
Message-ID: <6ca39764-c990-4505-b287-d6450aab803f@gmail.com>
Date: Wed, 1 Oct 2025 10:03:26 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel EC21 with internal GSM MUX
To: Christian Meusel <christian.meusel@posteo.de>
Cc: ofono@lists.linux.dev
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com>
 <63E4C6A3-EAFA-45F4-8D23-7500BDC45DBD@posteo.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <63E4C6A3-EAFA-45F4-8D23-7500BDC45DBD@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

> 
> We are operating this modem with a single physical serial connection between CPU and modem. Starting in AT mode and switching over to GSM 07.10 MUX-ing. If I'm getting this correctly, there are three GSM MUX channels opened: control, aux, and PPP data.

Gotcha.  You're using naming conventions of pre-multiplexed devices (e.g. 
multiple USB interfaces, 1 AT port per USB interface) and this is confusing me.

> 
> What do you mean with premultiplexed ports? The one serial port we are using starts in plain AT communication mode after powering up the device and is then put into GSM 07.10 multiplexing mode.
> 

Yeah forget I mentioned this :)

> 
>> You can invoke g_at_chat_send however you like, even one after the other in the same function.  The underlying implementation still uses a command queue, so commands will be sent only when the modem channel is idle, or after receiving a final response from the modem (ERROR, OK, etc)
> 
> Thank you for clarifying this. Last weeks debugging brought me to the point where I found the command list in g_at_chat and I got up to the point where additional instrumentation below have_line gives me the following:
> 
>      Sep 26 09:43:25 target ofonod[2502]: chat_wakeup_writer
>      Sep 26 09:43:25 target ofonod[2502]: Aux: > ATE0; &C0; +CMEE=1\r
>      Sep 26 09:43:25 target ofonod[2502]: Aux: < \r\nOK\r\n
>      Sep 26 09:43:25 target ofonod[2502]: have_line(0x5d6e78, "OK")
>      Sep 26 09:43:25 target ofonod[2502]: at_chat_handle_command_response(0x5d6e78, ..., "OK")
>      Sep 26 09:43:25 target ofonod[2502]: checking common terminators
>      Sep 26 09:43:25 target ofonod[2502]: at_chat_finish_command
>      Sep 26 09:43:25 target ofonod[2502]: command queue not empty
>      Sep 26 09:43:25 target ofonod[2502]: chat_wakeup_writer

Here's how GAtChat operates:
- When 1 or more commands are queued up via g_at_chat_send(), GAtChat checks if 
there's a command in progress.  If there is, it waits for the final response.
- If the modem is idle, it wakes up the writer.  This sets up poll to notify the 
application using POLLOUT.
- When POLLOUT arrives, the command is sent to the kernel via write().
- When POLLIN arrives, the command response is processed
- If it is a final response, go back to step 1.

What seems to be happening is that POLLOUT is somehow broken on this particular 
device.  I imagine the kernel suffers from the same problem.

Regards,
-Denis
