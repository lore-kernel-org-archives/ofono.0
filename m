Content-Type: multipart/mixed; boundary="===============5980916258581018795=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] hdlc: handle wrapped buffers
Date: Sat, 17 Apr 2010 15:39:58 -0700
Message-ID: <1271543998.22838.34.camel@localhost.localdomain>
In-Reply-To: <1271528135-12337-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5980916258581018795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> ---
>  gatchat/gathdlc.c |   75 ++++++++++++++++++++++++++++-------------------=
-----
>  1 files changed, 40 insertions(+), 35 deletions(-)
> =

> diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
> index c5c02cf..13e15a1 100644
> --- a/gatchat/gathdlc.c
> +++ b/gatchat/gathdlc.c
> @@ -59,11 +59,12 @@ static void new_bytes(GAtHDLC *hdlc)
>  {
>  	unsigned int len =3D ring_buffer_len(hdlc->read_buffer);
>  	unsigned char *buf =3D ring_buffer_read_ptr(hdlc->read_buffer, 0);
> +	unsigned int wrap =3D ring_buffer_len_no_wrap(hdlc->read_buffer);
>  	unsigned char val;
>  	unsigned int pos =3D 0;
>  =

>  	while (pos < len) {
> -		if (buf[pos] =3D=3D 0x7e) {
> +		if (*buf =3D=3D 0x7e) {
>  			if (hdlc->receive_func && hdlc->decode_offset > 2 &&
>  						hdlc->decode_fcs =3D=3D 0xf0b8) {
>  				hdlc->receive_func(hdlc->decode_buffer,

please do this patch fist and send it separately. Intermixing it with
the ACCM support makes it hard to review.

So I like to see the patch series this way:

1) Handle ringbuffer wrapping in HDLC
2) Add recording support for HDLC
3) Add ACCM support to HDLC
4) Port PPP to use HDLC

Regards

Marcel



--===============5980916258581018795==--

