Content-Type: multipart/mixed; boundary="===============6968713047892280159=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Mon, 24 Sep 2018 16:25:52 -0500
Message-ID: <29b52008-59ee-d168-dc89-1e7de3b7e021@gmail.com>
In-Reply-To: <CAKSBH7HDxmrBEGDAnzDGgdQEs9LwjcBGkShn_xw47rrAU9=rbA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6968713047892280159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> Besides, several modules use the option linux driver, which blocks in =

> case the port doesn't answer.
> This single call:
> g_at_chat_unref(port);
> blocks either 30s or 1 minute, depending on the system. I might step =

> into it twice during my hardware initialization for several 3G models.
> It helps to run this line on a separate thread unblocking the rest.
> =


What system call blocks (use strace to determine this) ?  If anything =

inside the option driver blocks for 30-60 seconds, that is unacceptable =

and needs to be fixed in the kernel.

Regards,
-Denis

--===============6968713047892280159==--

