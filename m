Content-Type: multipart/mixed; boundary="===============1116314764033559996=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 2/3] hfp_ag_bluez5: Add watch for G_IO_HUP when connect
Date: Mon, 22 Apr 2013 03:56:02 -0500
Message-ID: <5174FB22.8070406@gmail.com>
In-Reply-To: <1366409945-31401-2-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1116314764033559996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/19/2013 05:19 PM, Paulo Borges wrote:
> A watch to G_IO_HUP is added to remove the file descriptor when the
> emulator is automatically disconnected when its GAtServer closes.
>
> We use a dupped file descriptor because the events aren't delivered to
> the file descriptor who originated them.
> ---
>   plugins/hfp_ag_bluez5.c |   23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============1116314764033559996==--

