Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6697868D
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088948; cv=none; b=gAsswDkZQH8HOxbsrfnMr5ysEmzSY32Z2z0TKr+yMsnYMiCGZNWa2EFmNEZ38cxn8R3s5YaF8+SGdxasvOtNLi3hFyIaOyzDdvYkedt8SyvxDEmbgc6SSqdkEBbn9TkuT9iVYK1+hDL1GSenfPD9/sUEz8RVwdqJOlPe1oXKneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088948; c=relaxed/simple;
	bh=d0U6ZAaDvAnoA0RcabF+sfL0LFTjyTQB+PY2RGW+3X8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aUbVrGRaXxolt6uVRXcDIM7VeubmCOCeEJ11bbWG4BLKq3W//rFbWj0CrwZ+3+rpAs2ecQvZUgb554xWNDMvygpVh8Z1yCnM4+g/7xFlBTonPxC5sumEd002IqCQwvgIZQolPkzq4aAzOZSWFq1tSAmpYe/rqfRc1pIvwQa9djA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc7ea.dip0.t-ipconnect.de [79.239.199.234])
	by mail.holtmann.org (Postfix) with ESMTPSA id A23C5CECC3;
	Fri, 16 Feb 2024 14:08:56 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/2] treewide: Make modem drivers builtin
From: Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <91jbcn.s8x3ha.rvm72j-qmf@smtp.gmail.com>
Date: Fri, 16 Feb 2024 14:08:46 +0100
Cc: Denis Kenzior <denkenz@gmail.com>,
 ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B2450B9-BC8E-45A4-8C39-10E3E2887279@holtmann.org>
References: <20240215193625.1140095-1-denkenz@gmail.com>
 <91jbcn.s8x3ha.rvm72j-qmf@smtp.gmail.com>
To: piggz1@gmail.com
X-Mailer: Apple Mail (2.3774.400.31)

Hi,

> Would there be any interest in keeping support for out of tree  =
drivers? Sailfish implements a ril driver out of tree, and there is some =
interest in rebasing the sailfish ofono on the current ofono and =
minimising the changes sailfish ships.

Not really. oFono is moving on and we are heading towards removing =
options from the codebase to make it maintainable and get rid of some =
old cruft that has been lingering around. External plugins was never a =
good idea in hindsight. This will be removed from ConnMan and oFono =
really soon. And we are jumping the major version as well. So oFono 3.0 =
is actually around the corner.

Regards

Marcel

