Content-Type: multipart/mixed; boundary="===============8248430564957169669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] Gemalto contributors
Date: Thu, 11 Oct 2018 23:10:29 -0500
Message-ID: <34f7be71-7466-c388-5c5a-1cb69555ab78@gmail.com>
In-Reply-To: <20181010065454.15232-6-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8248430564957169669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/10/2018 01:54 AM, Giacinto Cifelli wrote:
> ---
>   AUTHORS | 3 +++
>   1 file changed, 3 insertions(+)
> =


Please don't send me patches to AUTHORS.  The maintainers will take care =

of it.  If I forget, send me a nudge to do so.

> diff --git a/AUTHORS b/AUTHORS
> index 2d360e6e..8f0f5893 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -138,3 +138,6 @@ Florent Beillonnet <florent.beillonnet@gmail.com>
>   Martin Hundeb=C3=B8ll <martin@geanix.com>
>   Julien Tournier <tournier.julien@gmail.com>
>   Nandini Rebello <nandini.rebello@intel.com>
> +Giacinto Cifelli <gciofono@gmail.com>
> +Martin Baschin <martin.baschin@googlemail.com>
> +Sebastian Arnd <sebastianarnd@gmail.com>
> =


If these guys have written some of the code and you're submitting a =

series of patches, then make sure their name is set as the Author of the =

particular commit they wrote.  If that is not possible, then we might =

need to look into using various git tags for this.  E.g. perhaps =

Co-authored-by tag.

Regards,
-Denis

--===============8248430564957169669==--

