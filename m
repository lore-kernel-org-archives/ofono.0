Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBC63C8
	for <ofono@lists.linux.dev>; Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361231; cv=none; b=W98MhLGfximBguYjjnsSTLPWNc9icIhNv9vfdsI0iMnnUV0sc63U0QLBWK8m28s6JEn4dn2nD7Xniv63RMzYimE15fU4dM60GWbK0thXVyRczQtgIvfPJZDGj1DAhDz6mwXPSmS9zGN2ZMbILZVSt9VMmrVzpSgFZf4VSaM60sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361231; c=relaxed/simple;
	bh=x5c1VAlK+oMU9HTe8wg0BfKTZvtT+P77jhKIvh7lf2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u8o0n+aUD8/WaMTD13xvj5kVc+0Alts+MT212NnEK3R7nC2V8pK3CwiAuXtgyqxk1KIIj4WrOf3g1jqcVJLYTfZAnhLM0oxpJ5+fdXTj2ZI5x9LcuQ0MIoZeyesCUWG2u5JqB8ts0VmOFmrM94QPDGMtARC7oMNlixopNf31AFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF8lQKYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF8lQKYh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFF8C4AF09;
	Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719361231;
	bh=x5c1VAlK+oMU9HTe8wg0BfKTZvtT+P77jhKIvh7lf2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rF8lQKYhMQ89kDGqY8Qq+g2YcqhNfrWbbwvktq97g4rfskx93lSmZEw5X+WUYFNNq
	 bBT9EktA1dSUmX9qrsP0k8ZrUgRPglSInJd86Y2Ayl8rF7aeHUA9JCd/GERSFIPKC+
	 Phk/fdHflaRIts0eDshrq1VMIOCFX7TsoWmJG6EfXMjO+3tQPHBC/JoX+sYBB5nb8a
	 9SuRRM+I3XyJ1cMYpokl84230l7vmbGf7tGsGJ0fFcPyi/gpMPtbNO8/Svyn4n+duh
	 xvjiau4VZfTf56YV7p2Ujn3TQuAXyZVCwNdBzpPtdq5C85arjtWHWoZtq/60XsE/iz
	 yFBY1w08+d5Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41139DE8DF2;
	Wed, 26 Jun 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/14] qmi: Introduce SERVICE_VERSION macro
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171936123126.13477.15891714657674909064.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 00:20:31 +0000
References: <20240625164158.1170937-1-denkenz@gmail.com>
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 25 Jun 2024 11:41:37 -0500 you wrote:
> This will make it easier to compare service major.minor versions in a
> more readable manner.
> ---
>  drivers/qmimodem/qmi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2,01/14] qmi: Introduce SERVICE_VERSION macro
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=17c59087a559
  - [v2,02/14] qmi: Remove control_major and control_minor
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c2fca8c3ff5a
  - [v2,03/14] qmi: Move service_handle allocation to service_family
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1dada7a3caef
  - [v2,04/14] qmi: Move group id allocation out of qmi_device
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=97758fc3e797
  - [v2,05/14] qmi: Move service_info management into qrtr/qmux
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d216d9826b3a
  - [v2,06/14] qmi: Rename qmi_device to qmi_transport
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c98edde4fabb
  - [v2,07/14] qmi: Separate transport from qmux/qrtr debugging
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3287d7b5e8b6
  - [v2,08/14] gobi: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=369d68cab127
  - [v2,09/14] qmiqrtr: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=37662676bce0
  - [v2,10/14] qmi: Move release_client operation into service_family
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=015266f253ab
  - [v2,11/14] qmi: Add dedicated service for qrtr
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0e99a8932bae
  - [v2,12/14] qmi: debug print fd that QRTR data was received on
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fba357d49292
  - [v2,13/14] unit: Use _auto_ to automatically tear-down test setup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e78bb3a9338e
  - [v2,14/14] unit: Add unit test for QRTR dedicated services
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=19a0671b111e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


