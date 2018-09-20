Content-Type: multipart/mixed; boundary="===============2057074455591370973=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbim driver: call the release function in case MBIM OPEN
 fails
Date: Thu, 20 Sep 2018 17:01:24 -0500
Message-ID: <775b6f5d-2d8d-f54d-9c5b-b77ff337668a@gmail.com>
In-Reply-To: <CAKSBH7HYAZ5Um79jzM__=uBa_7H7fTzqQXN9a=j23do5Yam4cw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2057074455591370973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> I will check about the is_ready false, but definitely the =

> disconnect_handler is not called, I can tell you,
> because on a special condition I have received a OPEN DONE with failure, =

> and the driver remained hanging.
> However, after calling it, there is a second call to disconnect_handler, =

> but not if it is not done here.
> Maybe the code should be verified somewhere else? Any other suggestions?

Okay, I played with this a bit and indeed there was an issue.  It should =

be fixed in ell upstream now.

See commit 0294175cff974ae9aae93e3609c5f6502db410ee.

Regards,
-Denis

--===============2057074455591370973==--

