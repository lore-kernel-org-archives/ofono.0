Content-Type: multipart/mixed; boundary="===============1600923495758198840=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: handling crash in error scenario for SIM PIN query
Date: Fri, 20 Dec 2019 12:46:58 -0600
Message-ID: <01948ba6-8fab-426d-f26a-601c44542af3@gmail.com>
In-Reply-To: <1576760269-30981-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1600923495758198840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/19/19 6:57 AM, Antara Borwankar wrote:
> In case of error in sim_pin_query_cb function. pin_type is set
> to -1. This is causing segmentation fault in function
> sim_passwd_name due to invalid index pin_type =3D -1. Fixing this
> issue by handling error case before calling sim_passwd_name
> function.
> ---
>   src/sim.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1600923495758198840==--

