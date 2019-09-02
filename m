Content-Type: multipart/mixed; boundary="===============1944686669484623263=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] quectel: swap cmuxed ports
Date: Mon, 02 Sep 2019 16:27:10 -0500
Message-ID: <f9d65cf4-3d96-2bbb-27f2-0847775f8513@gmail.com>
In-Reply-To: <20190902211759.61961-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1944686669484623263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/2/19 4:17 PM, Martin Hundeb=C3=B8ll wrote:
> According to the manual, when using CMUX on the UC15, it outputs
> unsolicited indications on port 2 (i.e. /dev/gsmtty2), so the quectel
> plugin must use this when registering for such.
> ---
>   plugins/quectel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1944686669484623263==--

