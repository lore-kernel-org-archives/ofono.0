Content-Type: multipart/mixed; boundary="===============1213779639853350052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC patches 07/13] write_file: make transaction-safe
Date: Fri, 28 May 2010 09:43:47 -0500
Message-ID: <201005280943.47503.denkenz@gmail.com>
In-Reply-To: <14a5ede292e3e4d82f9b25c50be3c942b02de90e.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1213779639853350052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> write_file(), as written wasn't transaction-safe; a crash bewtween a
> file being open and the buffer being written before a safe close would
> leave the file with a set of undetermined contents.
> =

> Modified to the file is written to a temporary file name; once
> completed, it is renamed to the final name. This way, a crash in the
> middle doesn't leave half-baked files.
> +	/* Now that the file contents are written, rename to the real
> +	 * file name; this way we are uniquely sure that the whole
> +	 * thing is there. */

Again, prefer multiline comments to be in a certain format

> +	unlink(path);
> +	/* conserve @r's value from 'write' */
> +	if (link(tmp_path, path) =3D=3D -1)
> +		r =3D -1;
> +error_write:
> +	unlink(tmp_path);
> +error_mkstemp_full:
> +error_create_dirs:
> +	g_free(tmp_path);
>  	g_free(path);
>  	return r;
>  }
> =


And I get trouble applying your patch:
Applying: write_file: make transaction-safe
/home/denkenz/ofono-master/.git/rebase-apply/patch:13: trailing whitespace.
/* =

/home/denkenz/ofono-master/.git/rebase-apply/patch:22: trailing whitespace.
 */ =

/home/denkenz/ofono-master/.git/rebase-apply/patch:75: trailing whitespace.


Regards,
-Denis

--===============1213779639853350052==--

