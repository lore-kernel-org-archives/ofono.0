Content-Type: multipart/mixed; boundary="===============6840983808722169822=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] simfs: Cache flushing functions.
Date: Wed, 22 Dec 2010 20:57:49 -0600
Message-ID: <4D12BAAD.1000505@gmail.com>
In-Reply-To: <1291989564-28694-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6840983808722169822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

<snip>

> diff --git a/src/simfs.h b/src/simfs.h
> index ef962db..ace25bf 100644
> --- a/src/simfs.h
> +++ b/src/simfs.h
> @@ -47,4 +47,6 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id=
);
>  =

>  void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
>  =

> +void sim_fs_cache_flush(struct sim_fs *fs, int id);
> +
>  void sim_fs_free(struct sim_fs *fs);

So as I mentioned on IRC I think you have the right idea.  However, I'd
prefer that we separate the three types of flushes:

- Full simfs flush
- specific ef cache flush
- specific icon cache flush
- full icon cache flush

Regards,
-Denis

--===============6840983808722169822==--

