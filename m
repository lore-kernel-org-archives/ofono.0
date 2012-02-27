Content-Type: multipart/mixed; boundary="===============6235007603766317034=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] add some length verification to avoid reading not owned
 memory
Date: Mon, 27 Feb 2012 09:22:19 -0800
Message-ID: <1330363339.3392.52.camel@aeonflux>
In-Reply-To: <4F4B4B0B.7060606@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6235007603766317034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

> while reading mmsd sources I stumbled over missing length
> checks in src/push.c:mms_push_notify(). I didn't re-read
> the entire source to prove overall ;)

please use git format-patch and git send-email to send us inline
patches. In case your email client doesn't support inline patches
nicely. Reviewing patches that are attached is super painful and in most
cases they get ignored then.

Regards

Marcel



--===============6235007603766317034==--

