Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51051C286
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820229; cv=none; b=Rg12ypECz5sYM1uaty72ANIWLuQBNcnwjK8kvB7ft8Iee9v/hfaj7kTA8RxYcQqgn9oBQnea20aXM/kc4+tcmUT1GEKW1vAqogprsJF0gLHIR9+dw155oWUEwYv7nko3CXm6tcMnH6L7Vb3KZPc9pqHB+zYb+T2DnqWJmBEP8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820229; c=relaxed/simple;
	bh=cikAwPo46P0ID4czl9SjpRXqK3dFxrnuNLzipkaQyFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQvPbMMHNAOyO+v22ZsD/Wy4RWGwIzaYvzWZxQAxi96W1kz/0A8quBEAIg/5a88vCx6SZwcA3ylntNzimrdcuSNIH6ppNpMO6/gx/NyhntEp3LTg7vLiFaoGepeJGZYYbrcCe3ti7BYFgJ5O2qrdAw4BjpS3WlgeqgjwAhuSyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTLHtPdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTLHtPdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF46C3277B;
	Mon, 22 Apr 2024 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713820229;
	bh=cikAwPo46P0ID4czl9SjpRXqK3dFxrnuNLzipkaQyFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kTLHtPdJeplL+zvAJlhL9ariiVrPV3yF8PHhotZ2lE/ATfcjBjB5ilt+FXTwRXQQe
	 rOtklmd8M/2A9p3nt0l2gfS+/AhmdBBpuNiwG99yi4BHybI3GId6PrZthUywZYjiP+
	 ML5+PJASxZDHNMTbo+Ilp7I8j/ObUa3wpT/o6UVTOjycDlFD3NGc4fvcOkmkFcRDi2
	 TE221JcCErSGQw6We2EAYy7hLGvO1j0QvUkJASRhFu7pm5xUDn4ONaIxoOWPzLCM1v
	 s2ShmnJ3KQFn/Lo5Y2llrqzo+czNkOtZZjutNdrl0WSbhEwaWoFwOMuy8SxOnKwYqd
	 LXmsx3fG2NIhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DE64C43440;
	Mon, 22 Apr 2024 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] qmimodem: voicecall: Implement call dialing
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171382022931.22847.16965805203423437620.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 21:10:29 +0000
References: <20240421194926.13149-1-adam@piggz.co.uk>
In-Reply-To: <20240421194926.13149-1-adam@piggz.co.uk>
To: Adam Pigg <adam@piggz.co.uk>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sun, 21 Apr 2024 20:49:03 +0100 you wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infrastructure and setup of the QMI services
> 
> Call State Handling
> ===================
> On initialisation, register the all_call_status_ind callback to be
> called for QMI_VOICE_IND_ALL_STATUS.  This will handle notification of
> call status to the rest of the system
> 
> [...]

Here is the summary with links:
  - [1/4] qmimodem: voicecall: Implement call dialing
    (no matching commit)
  - [2/4] qmimodem: voicecall: Implement call answer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3680df684593
  - [3/4] qmimodem: voicecall: Implement active call hangup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=752d286a5ce3
  - [4/4] qmimodem: voicecall: Implement DTMF tones
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


