Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E91879
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902876; cv=none; b=THmIbLK085A0rp9TsZxlBuYALL8jQeCUlhW0rHpreeea1HF9Q8ZVtZzB0inYQOsrFN2OScgFCgJG/45kZSldHhCTtHOjb4NWxI6f/dQUC0WjIVy0nxSd+iu9pCPhMqT15NDd7fVdsC72HhQc8d2ipdbBcGIpRltqapZNBPMK220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902876; c=relaxed/simple;
	bh=jUXDhJuir7lBw6syqwo7tFvx2uHnVTTGhHUaZfXgf1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pU7B9+QEHBKLJvFtNrXcGqAnVwfvtU+b1cyyVcDX1mc3opHcowe5d5AxpKr9sxbG+J5ZQ2ppkhputd6tb8MIZs5zC70hsYSdCTzDyv9QlmRpPZiftfXZDh87E/RATDTlX5duDMVjS7ilMGDEZU3zYoclB54oMkbjU+GxpNVskZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCwvQXor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCwvQXor"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C95FCC4AF07;
	Thu, 20 Jun 2024 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718902875;
	bh=jUXDhJuir7lBw6syqwo7tFvx2uHnVTTGhHUaZfXgf1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bCwvQXorjWTzgAZSaoHyve5WeZDUwuOKH1QP9ElAoTEP02rW23zI9+eRLlahL6W2b
	 q6KMl5xtYBc7nSlw1m3CTy9OQT22+KXN6CdehBjdU6LWPe5n5wZA7/SED48n9CXOx7
	 OFePB+7B6Zpw6OEDYrw7Pib+J3m+2vHGhSI7hGt/6nFRdm2gA7nCMhE3avFxBIVHD1
	 Ieeg4m907YALe8+jOCGT2EmjxcKKpy0Ub8nnIaknwsAoDI7w95RHZ2oLtUKUBVZr0o
	 fALwbLB/Zw+WKyIcl0vkDbEShQ80zOtM4d4UsqGH4QxEPtfG30WcmuFWNHGZN/sjXz
	 jlxxdgLd2YV8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC526CF3B9A;
	Thu, 20 Jun 2024 17:01:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 01/33] qmi: Remove qmi_free()
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171890287570.26157.14141814156378406916.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 17:01:15 +0000
References: <20240620145139.1135899-1-denkenz@gmail.com>
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 20 Jun 2024 09:50:48 -0500 you wrote:
> This was just a simple wrapper around l_free, get rid of it.
> ---
>  drivers/qmimodem/devinfo.c    | 8 ++++----
>  drivers/qmimodem/qmi.c        | 5 -----
>  drivers/qmimodem/qmi.h        | 2 --
>  drivers/qmimodem/sim-legacy.c | 6 +++---
>  drivers/qmimodem/sim.c        | 2 +-
>  5 files changed, 8 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [v3,01/33] qmi: Remove qmi_free()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=583e5e62a6ec
  - [v3,02/33] qmi: Rename qmi_result_func_t
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e1815f98abe0
  - [v3,03/33] qmi: Drop unused major/minor information
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=526316336d75
  - [v3,04/33] qmi: Add qmi_qrtr_node_get_service
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=dd1ddbf23341
  - [v3,05/33] plugins: Add new qrtrqmi modem driver
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8da4495519cf
  - [v3,06/33] gobi: Use correct attribute name in docs
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2d6528dbbdf5
  - [v3,07/33] udevng: Use new qrtrqmi driver for MHI and SoC modems
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7b735cb51b13
  - [v3,08/33] gobi: Remove qrtr support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=69335b285ac8
  - [v3,09/33] udevng: Do not set DeviceProtocol
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cbc3bbeb8542
  - [v3,10/33] unit: Rename device to node
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8612c1d6c9b3
  - [v3,11/33] qmi: Rename qmi_device_new_qrtr to qmi_qrtr_node_new
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0afd9e1df727
  - [v3,12/33] qmi: Rename qmi_device_new_qmux to qmi_qmux_device_new
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b55beaaa7978
  - [v3,13/33] unit: Drop use of qmi_service_create_shared
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d0e8bb9c76b6
  - [v3,14/33] qmi: qmux: Make shared service creation generic
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c047bfc9d600
  - [v3,15/33] qmi: Rename qmi_device_get_service_version
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4c70eaa29f67
  - [v3,16/33] qmi: sms: Require at WMS version 1.2+
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9d2a30df34e6
  - [v3,17/33] qmi: Rework qmi_service_get_version
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=86809d38ba1c
  - [v3,18/33] qmi: break up qmi_device_free into qrtr & qmux variants
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=bfda30d7f142
  - [v3,19/33] qmi: Convert DBG statements to __debug_device
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=416cdbd3dba9
  - [v3,20/33] qmi: introduce qmi_qrtr_node_lookup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8a645862d936
  - [v3,21/33] qmi: split qmi_device_has_service into QRTR and QMUX version
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6d45ba559524
  - [v3,22/33] qmi: split qmi_device_set_debug into QRTR and QMUX versions
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1f7adcd84a3f
  - [v3,23/33] qmi: Make qmi_qrtr_node methods take struct qmi_qrtr_node
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=674ff0810297
  - [v3,24/33] qmi: Move expected data format handling into gobi
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9dc730546f9a
  - [v3,25/33] qmi: Rename and refactor qmi_device_discover
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=217b57328473
  - [v3,26/33] qmi: Rename qmi_device_shutdown
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2e2a41ad4bf7
  - [v3,27/33] qmi: Rename qmi_device_qmux to qmi_qmux_device
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3407d0f17684
  - [v3,28/33] qmi: Make qmux methods operate on 'qmi_qmux_device'
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=828d4841ecad
  - [v3,29/33] qmi: combine service_send_data into qmi_request
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5543a8109fba
  - [v3,30/33] qmi: combine qmux_client_create_data into qmi_request
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4592bf181a41
  - [v3,31/33] gprs: Fix memory leak
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1d6b11ef2b42
  - [v3,32/33] qmi:gprs: Don't fail on unsupported INDICATION_REGISTER
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c1f4a11f1c9c
  - [v3,33/33] qmi: non-premultiplexed MHI devices
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=27c79da4946f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


