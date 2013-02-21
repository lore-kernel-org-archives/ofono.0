Content-Type: multipart/mixed; boundary="===============1454412047974775083=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Fix segfault in CIEV GAtChat callback
Date: Thu, 21 Feb 2013 17:10:25 -0600
Message-ID: <5126A961.4040504@gmail.com>
In-Reply-To: <1361485482-3235-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1454412047974775083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/21/2013 04:24 PM, Claudio Takahasi wrote:
> This  patch fixes segmentation fault when the network registration
> watch is called without being initialized. CIEV GAtChat callback can
> be called before ofono_netreg_register().
>
> =3D=3D15101=3D=3D Invalid read of size 8
> =3D=3D15101=3D=3D    at 0x492B56: ofono_netreg_register (network.c:2073)
> =3D=3D15101=3D=3D    by 0x47245E: hfp_netreg_probe (network-registration.=
c:311)
> =3D=3D15101=3D=3D    by 0x492A8D: ofono_netreg_create (network.c:1881)
> =3D=3D15101=3D=3D    by 0x4849D5: hfp_pre_sim (hfp_hf_bluez5.c:288)
> =3D=3D15101=3D=3D    by 0x48C486: ofono_modem_set_powered (modem.c:1194)
> =3D=3D15101=3D=3D    by 0x484E9D: slc_established (hfp_hf_bluez5.c:85)
> =3D=3D15101=3D=3D    by 0x4702AD: chld_cb (slc.c:147)
> =3D=3D15101=3D=3D    by 0x440457: at_chat_finish_command (gatchat.c:461)
> =3D=3D15101=3D=3D    by 0x44109F: new_bytes (gatchat.c:532)
> =3D=3D15101=3D=3D    by 0x4433B7: received_data (gatio.c:122)
> =3D=3D15101=3D=3D    by 0x3CBAA47824: g_main_context_dispatch (gmain.c:25=
39)
> =3D=3D15101=3D=3D    by 0x3CBAA47B57: g_main_context_iterate.isra.23
> (gmain.c:3146)
> =3D=3D15101=3D=3D  Address 0x18 is not stack'd, malloc'd or (recently) fr=
ee'd
> ---
>   drivers/hfpmodem/network-registration.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============1454412047974775083==--

