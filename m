Content-Type: multipart/mixed; boundary="===============5416422910247176032=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] test-stkutil: add html formatted text tests
Date: Mon, 21 Jun 2010 18:25:57 -0500
Message-ID: <201006211825.58072.denkenz@gmail.com>
In-Reply-To: <1277125602-3996-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5416422910247176032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +static void do_html_test(char *text, int text_len, const unsigned char
>  *attrs, +				int attrs_len, const char *filename)
> +{
> +	int fd;
> +	char html_header[] =3D "<html><body>";
> +	char html_close[] =3D "</body></html>";
> +	char *html;
> +	ssize_t bytes_written;
> +
> +	if (filename =3D=3D NULL)
> +		return;
> +
> +	/* open output file */
> +	fd =3D open(filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR |
> +				S_IRGRP | S_IROTH);
> +	if (fd < 0) {
> +		g_print("unable to open %s\n", filename);
> +		return;
> +	}
> +
> +	bytes_written =3D write(fd, html_header, strlen(html_header));
> +	html =3D stk_text_to_html(text, text_len, attrs, attrs_len);
> +	bytes_written =3D write(fd, html, strlen(html));
> +	bytes_written =3D write(fd, html_close, strlen(html_close));
> +	close(fd);
> +	g_free(html);
> +}
> +

Please note that unit tests should not require any manual intervention for =
the =

user to detect whether the code being tested is working or not.  E.g. if yo=
u =

don't g_assert at least once, it is not a unit test.

For most of these cases it is quite easy to know the output.  So my suggest=
ion =

here is to set the expected html output as a string in the test structure a=
nd =

do a strcmp / g_assert at the end of the test.

Regards,
-Denis

--===============5416422910247176032==--

