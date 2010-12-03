Content-Type: multipart/mixed; boundary="===============6061490994208608975=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] TODO: Add task for NITZ name support in netreg
Date: Fri, 03 Dec 2010 12:43:49 -0600
Message-ID: <4CF93A65.3070804@gmail.com>
In-Reply-To: <1291384929-352-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6061490994208608975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 12/03/2010 08:02 AM, Aki Niemi wrote:
> ---
>  TODO |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 6cf7202..457c9a1 100644
> --- a/TODO
> +++ b/TODO
> @@ -497,3 +497,13 @@ Miscellaneous
>    Priority: Medium
>    Complexity: C2
>    Owner: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> +
> +- Add NITZ name support to the network registration atom.  One of the ma=
ny
> +  inputs to the final display name on the UI is a name given in a NITZ
> +  indication from the network.  This task adds a notify function to the =
network
> +  registration atom, and modifies the logic in get_operator_display_name=
() to
> +  use the NITZ name if available.
> +
> +  Priority: Medium
> +  Complexity: C1
> +  Owner: Aki Niemi <aki.niemi@nokia.com>
> =


Out of curiosity, how do you plan to support this on AT modems?  I have
yet to see any AT modem report the NITZ network name via a proprietary
command.

Besides, all AT modems report the NITZ name via COPS.  So in effect
oFono already fulfills this task...

Regards,
-Denis

--===============6061490994208608975==--

