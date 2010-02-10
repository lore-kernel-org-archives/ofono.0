Content-Type: multipart/mixed; boundary="===============4529985034309072382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Add ring_buffer_read_advance for partial write
Date: Wed, 10 Feb 2010 09:36:39 -0600
Message-ID: <201002100936.40723.denkenz@gmail.com>
In-Reply-To: <1265789623-30146-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4529985034309072382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> These two patches are for server side partial write.
> =

> When server writes data into non-blocking IO, we first get the
> read pointer of write_buf and write data as much as we can. Then
> we advance the read_ptr according to the real bytes written.
> ---
>  gatchat/ringbuffer.c |    8 ++++++++
>  gatchat/ringbuffer.h |    7 +++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/ringbuffer.c b/gatchat/ringbuffer.c
> index 42d5b68..e17c1fa 100644
> --- a/gatchat/ringbuffer.c
> +++ b/gatchat/ringbuffer.c
> @@ -130,6 +130,14 @@ int ring_buffer_read(struct ring_buffer *buf, void
>  *data, unsigned int len) return len;
>  }
> =

> +int ring_buffer_read_advance(struct ring_buffer *buf, unsigned int len)
> +{
> +	len =3D MIN(len, buf->in - buf->out);
> +	buf->out +=3D len;
> +
> +	return len;
> +}
> +

ring_buffer_drain already does this, that is the one you want to use.

Regards,
-Denis

--===============4529985034309072382==--

