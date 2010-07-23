Content-Type: multipart/mixed; boundary="===============5523543927389024886=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 02/20] write_file: make transaction-safe
Date: Fri, 23 Jul 2010 16:57:31 -0500
Message-ID: <4C4A104B.2080406@gmail.com>
In-Reply-To: <21ceadbaf2b2fc2479a381c123140d27ed7c36ba.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5523543927389024886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> write_file(), as written wasn't transaction-safe; a crash bewtween a
> file being open and the buffer being written before a safe close would
> leave the file with a set of undetermined contents.
> =

> Modified to the file is written to a temporary file name; once
> completed, it is renamed to the final name. This way, a crash in the
> middle doesn't leave half-baked files.
> ---
>  src/storage.c |   42 +++++++++++++++++++++++++++++++-----------
>  1 files changed, 31 insertions(+), 11 deletions(-)
> =

> diff --git a/src/storage.c b/src/storage.c
> index cac5835..c88a8c8 100644
> --- a/src/storage.c
> +++ b/src/storage.c
> @@ -98,11 +98,21 @@ ssize_t read_file(unsigned char *buffer, size_t len,
>  	return r;
>  }
>  =

> +/*
> + * Write a buffer to a file in a transactionally safe form
> + *
> + * Given a buffer, write it to a file named after
> + * @path_fmt+args. However, to make sure the file contents are
> + * consistent (ie: a crash right after opening or during write()
> + * doesn't leave a file half baked), the contents are written to a
> + * file with a temporary name and when closed, it is renamed to the
> + * specified name (@path_fmt+args).
> + */
>  ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
>  			const char *path_fmt, ...)
>  {
>  	va_list ap;
> -	char *path;
> +	char *tmp_path, *path;
>  	ssize_t r;
>  	int fd;
>  =

> @@ -110,26 +120,36 @@ ssize_t write_file(const unsigned char *buffer, siz=
e_t len, mode_t mode,
>  	path =3D g_strdup_vprintf(path_fmt, ap);
>  	va_end(ap);
>  =

> -	if (create_dirs(path, mode | S_IXUSR) !=3D 0) {
> -		g_free(path);
> -		return -1;
> -	}
> +	tmp_path =3D g_strdup_printf("%s.XXXXXX.tmp", path);
>  =

> -	fd =3D TFR(open(path, O_WRONLY | O_CREAT | O_TRUNC, mode));
> -	if (fd =3D=3D -1) {
> -		g_free(path);
> -		return -1;
> -	}
> +	r =3D -1;
> +	if (create_dirs(path, mode | S_IXUSR) !=3D 0)
> +		goto error_create_dirs;

Please do me a favor and add an empty line here.

> +	fd =3D TFR(g_mkstemp_full(tmp_path, O_WRONLY | O_CREAT | O_TRUNC, mode)=
);
> +	if (fd =3D=3D -1)
> +		goto error_mkstemp_full;
>  =

>  	r =3D TFR(write(fd, buffer, len));
>  =

>  	TFR(close(fd));
>  =

>  	if (r !=3D (ssize_t) len) {
> -		unlink(path);
>  		r =3D -1;
> +		goto error_write;
>  	}
>  =

> +	/* Now that the file contents are written, rename to the real
> +	 * file name; this way we are uniquely sure that the whole
> +	 * thing is there. */

Please follow comment conventions per doc/coding-style.txt Section M2.

> +	unlink(path);

There should be an empty line here per doc/coding-style.txt Section M1.

> +	/* conserve @r's value from 'write' */
> +	if (link(tmp_path, path) =3D=3D -1)
> +		r =3D -1;

Another empty line here (before and after if/while/do/for blocks)

> +error_write:
> +	unlink(tmp_path);
> +error_mkstemp_full:
> +error_create_dirs:
> +	g_free(tmp_path);
>  	g_free(path);
>  	return r;
>  }

Regards,
-Denis

--===============5523543927389024886==--

