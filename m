Content-Type: multipart/mixed; boundary="===============4612873244359509705=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: fix seg fault in case of NULL callback
Date: Mon, 01 Oct 2018 14:47:04 -0500
Message-ID: <bcab8661-784c-5b11-4ada-674ec35e5a6c@gmail.com>
In-Reply-To: <1538374753-8613-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4612873244359509705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 10/01/2018 01:19 AM, Anirudh Gargi wrote:
> In case of AT callback if callback handler is NULL, check for null
> before calling the success macro.
> =

> Logs:
> ofonod[32496]: src/network.c:current_operator_callback() 0x157ad60, (nil)
> ofonod[32496]: src/gprs.c:netreg_status_changed() 0
> ofonod[32496]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached=
: 1
> ofonod[32496]: src/gprs.c:ofono_gprs_detached_notify() /xmm7xxx_0
> ofonod[32496]: drivers/ifxmodem/gprs-context.c:ifx_gprs_detach_shutdown()
> ofonod[32496]: drivers/ifxmodem/gprs-context.c:ifx_gprs_deactivate_primar=
y() cid 0
> ofonod[32496]: src/gprs.c:ofono_gprs_detached_notify() /xmm7xxx_0
> ofonod[32496]: src/gprs.c:gprs_attach_callback() /xmm7xxx_0 error =3D 0
> ofonod[32496]: drivers/ifxmodem/gprs-context.c:deactivate_cb() ok 0
> ofonod[32496]: Aborting (signal 11) [./../src/ofonod]
> ofonod[32496]: ++++++++ backtrace ++++++++
> ofonod[32496]: +++++++++++++++++++++++++++
> ---
>   drivers/ifxmodem/gprs-context.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============4612873244359509705==--

