Content-Type: multipart/mixed; boundary="===============6117266040726061866=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] stk: Fix sizeof on memcpy
Date: Wed, 22 May 2013 21:38:18 -0500
Message-ID: <519D811A.9050307@gmail.com>
In-Reply-To: <1369263708-19011-1-git-send-email-lucas.demarchi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6117266040726061866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 05/22/2013 06:01 PM, Lucas De Marchi wrote:
> src/stk.c: In function =E2=80=98__ofono_cbs_sim_download=E2=80=99:
> src/stk.c:283:45: error: argument to =E2=80=98sizeof=E2=80=99 in =E2=80=
=98memcpy=E2=80=99 call is the
> same expression as the source; did you mean to dereference it?
> [-Werror=3Dsizeof-pointer-memaccess]
>    memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
>                                                 ^
> ---
>   src/stk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============6117266040726061866==--

