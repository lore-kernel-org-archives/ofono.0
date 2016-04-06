Content-Type: multipart/mixed; boundary="===============6819441861580496794=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/log.c: Don't crash when addr2line output contains no
 newline
Date: Wed, 06 Apr 2016 13:22:28 -0500
Message-ID: <570553E4.7050106@gmail.com>
In-Reply-To: <1459884174-66474-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6819441861580496794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 04/05/2016 02:22 PM, Holger Hans Peter Freyther wrote:
> From: Harald Welte <hwelte@sysmocom.de>
>
> Signed-off-by: Holger Hans Peter Freyther <hfreyther@sysmocom.de>

We don't use Signed-off-by.  Do you want to resend or should I edit this =

out before applying?

> ---
>   src/log.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/src/log.c b/src/log.c
> index 6331b0d..42a2ec1 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -192,6 +192,8 @@ static void print_backtrace(unsigned int offset)
>   		buf[len] =3D '\0';
>
>   		pos =3D strchr(buf, '\n');
> +		if (!pos)
> +			break;
>   		*pos++ =3D '\0';
>
>   		if (strcmp(buf, "??") =3D=3D 0) {
>

Regards,
-Denis

--===============6819441861580496794==--

