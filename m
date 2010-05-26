Content-Type: multipart/mixed; boundary="===============3940560491652131453=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 12:37:51 -0500
Message-ID: <201005261237.51310.denkenz@gmail.com>
In-Reply-To: <20100526153621.2563.89213.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3940560491652131453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Ofono either crashed or busy looped with my Huawei E1552 3G modem when I
> tried to deactivate GPRS context. The reason was that gcd->chat was
> unreferenced already in setup_ppp() but the chat was still accessed
> later in at_gprs_deactivate_primary().
> =

> To fix the problem, change the logic instead to suspend chat session
> for PPP and resume when PPP has disconnected. Now it doesn't crash
> anymore.
> =

> Deactivation still doesn't work properly with Huawei E1552, and most
> probably with other Huawei modems, because the modem hangs up the chat
> line after PPP deactivation. This needs to be fixed separately. The
> workaround is to reboot the modem, for example physically unplug and plug
> it in again.
> ---

Patch has been applied, thanks.

Regards,
-Denis

--===============3940560491652131453==--

