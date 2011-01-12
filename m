Content-Type: multipart/mixed; boundary="===============8032848212319242841=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] plugins-mbm: Combining mbm_disable and reopen_callback
Date: Wed, 12 Jan 2011 08:13:26 -0800
Message-ID: <1294848806.3873.81.camel@aeonflux>
In-Reply-To: <1294839942-9071-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8032848212319242841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> Combining mbm_disable and reopen_callback into one and removing 1 second
> delay between them to avoid call to reopen_callback after modem being
> disconnected.

have you actually tested this? This will not work since you can not
reopen the TTY right away. You need that delay in between.

From my previous email, I remember saying that the right fix would be to
disarm the timer within disable. Why are we not doing that?

Regards

Marcel



--===============8032848212319242841==--

