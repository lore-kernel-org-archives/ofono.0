Content-Type: multipart/mixed; boundary="===============5408062243600145439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Mon, 19 Mar 2018 12:10:57 -0500
Message-ID: <eb26b058-ae40-367a-6fdc-b7e341e75370@gmail.com>
In-Reply-To: <1521476808-12688-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5408062243600145439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel, Mariem,

On 03/19/2018 11:26 AM, Gabriel Lucas wrote:
> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
> =

> ---
>   plugins/gemalto.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 74 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 5573606..029e09d 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -57,6 +57,8 @@
>   #define GEMALTO_MODEL_PHS8P 	"0053"
>   #define GEMALTO_MODEL_ALS3 	"0061"
>   =

> +static void gemalto_ciev_notify(GAtResult *result, gpointer user_data);
> +

Please note doc/coding-style.txt item M17.  I silently re-structured =

this patch to avoid the need for this forward-declaration.

Patch has been applied, thanks!

Regards,
-Denis

--===============5408062243600145439==--

