Content-Type: multipart/mixed; boundary="===============8280681519587834500=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] gatresult: strip trailing spaces from unquoted strings
Date: Thu, 18 Jul 2019 23:45:52 -0500
Message-ID: <77766e07-445c-e7e2-de9e-d516867aa8d3@gmail.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8280681519587834500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/16/19 2:10 PM, Martin Hundeb=C3=B8ll wrote:
> Some vendors might print trailing spaces after unsolicited result codes.
> Avoid duplicating and stripping the string after calling
> g_at_result_iter_next_unquoted_string() by stripping the spaces in
> gatresult instead.
> ---
>   gatchat/gatresult.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> =


Patches 1 - 5 applied, thanks.

Regards,
-Denis


--===============8280681519587834500==--

