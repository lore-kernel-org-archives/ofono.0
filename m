Content-Type: multipart/mixed; boundary="===============3028996356898548304=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 10:05:22 +0300
Message-ID: <87iq6bkurx.fsf@potku.valot.fi>
In-Reply-To: <20100525145641.11296.52980.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3028996356898548304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kalle.valo@canonical.com> writes:

> Ofono either crashed or busy looped with my Huawei E1552 3G modem when I
> tried to deactivate GPRS context. The reason was that gcd->chat was
> unreferenced already in setup_ppp() but the chat was still accessed
> later in at_gprs_deactivate_primary().
>
> To fix the problem, change the logic instead to suspend chat session
> for PPP and resume when PPP has disconnected. Now it doesn't crash
> anymore.
>
> Also remove the CGACT=3D0 command during deactivation, it's enough to shu=
tdown
> ppp.
>
> Deactivation still doesn't work properly with Huawei E1552, and most
> probably with other Huawei modems, because the modem hangs up the chat
> line after PPP deactivation. This needs to be fixed separately. The
> workaround is to reboot the modem, for example physically unplug and plug
> it in again.

Ping? This is an important patch because it fixes a crash. Please take a
look.

-- =

Kalle Valo

--===============3028996356898548304==--

