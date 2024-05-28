Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0E10A3E
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927031; cv=none; b=RBvzqI/NOHmpWaIMiO39B+ZP3UQ3cWx6v1W4SGJvgeOqNVSuGRJWpt/YQfD2m5rv5eAP/bC79pQaXB0NSRfyVomdkIXmeERCdX9z8dlTJu4w36ACt/xK3TkRXSgqoofaGctknO+RJVDOHFKBYUSRhvesegVfyXIMkF++5ovOauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927031; c=relaxed/simple;
	bh=Qk6pxhYoVkkNuDmlVJ+Ku9TIJAoqwAmQt2yTQ42j38s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9UdhI7xWNyZRkeryW1/TRcDPjHO+MzIa4HuSR1WCZx/LOqLPLMsLlXCyOnLrHgo/NlNqdg8K0gwAKBWUBZCj4SOW2VLPO6cG5jh4wLh1wsD6xDoUqvSxpRCt+WRLO/TooH8UKtrsn4h6Eqi/+wdiWzjabW/Of0w1/Qdw1Ft5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA9ekeCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA9ekeCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B285C32786;
	Tue, 28 May 2024 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716927031;
	bh=Qk6pxhYoVkkNuDmlVJ+Ku9TIJAoqwAmQt2yTQ42j38s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IA9ekeCJUuj1VXIUSNaYlBj3VkmGfslxOBH1v4+aT7C3JHqKWfMLAszEW+OyOXqwJ
	 iTwd46Aoaj5r4fhW/Yaa5HBU8JZosKOyhUQIRz5/UYcMNapAEhWeujc2zkoLvZpPMN
	 HQOmwsaSVGrDgEjRUezn81T0mS4FXEPU8lVPY4O6RFNwuHzJ96vwegb1yOVeW2Kx3T
	 CuS80Q6a2SGNT9rdMJPg4Cvb4sk/kHmBwxnkrNKaax4kKbsBLfIR2yE28IyJ/mf21J
	 9pb8eKE+z8FLYM6xq69iE7UzjPg8gS/zF8HHeKfzz2fZmlpjo25h1VFH84W/AUH11r
	 7rovIQ8pWEtgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BFF0C4361C;
	Tue, 28 May 2024 20:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] gobi: add / use DeviceProtocol property
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171692703143.1993.15064957838873600566.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 20:10:31 +0000
References: <20240520191722.184977-1-denkenz@gmail.com>
In-Reply-To: <20240520191722.184977-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 20 May 2024 14:17:02 -0500 you wrote:
> Instead of using the kernel driver as a hint for whether qrtr or qmi is
> being used, introduce an explicit DeviceProtocol property that should be
> set by the detection logic to tell the driver whether to use qrtr or
> qmux.
> 
> Split up QMI modem driver detection and setup logic inside udevng into
> setup_qmi_qrtr(), setup_qmi_qmux() and setup_qmi_netdev().
> setup_qmi_netdev() takes care of setting up of common networking device
> properties, while setup_qmi_qrtr() and setup_qmi_qmux() setup QRTR and
> QMUX devices, respectively.
> 
> [...]

Here is the summary with links:
  - [1/6] gobi: add / use DeviceProtocol property
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cebbc86ce7a7
  - [2/6] gobi: Rename KernelDriver to NetworkInterfaceDriver
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=df18422bafc8
  - [3/6] gobi: ensure required properties are provided
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b3ff67d78830
  - [4/6] udevng: add and use get_ifname() for netdev nodes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6d185edd5066
  - [5/6] udevng: Add mhi subsystem detection
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cdd58360140a
  - [6/6] qmi: gprs-context: support bind_mux for pcie devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cb16587e46e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


