Content-Type: multipart/mixed; boundary="===============6600152977948734646=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: long phone numbers
Date: Fri, 08 Oct 2010 12:06:20 +0200
Message-ID: <1286532380.6145.250.camel@aeonflux>
In-Reply-To: <1286532150-27030-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6600152977948734646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  TODO |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 5589bb1..a96c187 100644
> --- a/TODO
> +++ b/TODO
> @@ -285,11 +285,18 @@ Voicecall
>    Complexity: C1
>    Owner: Pekka Pessi <pekka.pessi@nokia.com>
>  =

> +- Long phone numbers. According to 3GPP TS 24.008, the callee address
> +  can be up to 80 digits long.
> +
> +  Priority: Medium
> +  Complexity: C2
> +
>  - Dial strings. Include CLIR prefixes and 2nd stage dial strings in the
>    DialString call property. Add dialstring accessor method to C API.
>  =

>    Priority: Medium
>    Complexity: C4
> +  Owner: Pekka Pessi <pekka.pessi@nokia.com>

so either this is a typo or you meant to do this, but then the subject
is not matching what the patch does.

Regards

Marcel



--===============6600152977948734646==--

