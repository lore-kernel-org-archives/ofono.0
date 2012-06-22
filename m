Content-Type: multipart/mixed; boundary="===============0597878308753927058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] hardwaremanipulator: Add multi-page support for CBS
 message
Date: Fri, 22 Jun 2012 03:12:22 -0500
Message-ID: <4FE428E6.6050000@gmail.com>
In-Reply-To: <1340635083-5877-6-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0597878308753927058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/25/2012 09:38 AM, Philippe Nunes wrote:
> ---
>   src/hardwaremanipulator.cpp |   35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
> index c19b507..b746229 100644
> --- a/src/hardwaremanipulator.cpp
> +++ b/src/hardwaremanipulator.cpp
> @@ -123,13 +123,44 @@ void HardwareManipulator::constructCBMessage(const =
QString&messageCode, int geo
>       m.setPage(pag);
>       m.setText(content);
>
> +    uint nbPages, spaceLeftInLast;
> +
> +    if ( scheme =3D=3D 0&&  content.length()>  (15*93)) {
> +        warning(tr("Text too long"),
> +        tr("The maximum number of pages (15) "
> +                          "is reached - text is truncated"));
> +        m.setText(content.mid( 0, 15*93 ));
> +    } else if (content.length()>  (15*40)) {
> +        warning(tr("Text too long"),
> +        tr("The maximum number of pages (15) "
> +                           "is reached - text is truncated"));
> +        m.setText(content.mid( 0, 15*40 ));
> +    }
> +
> +    m.computeSize( nbPages, spaceLeftInLast );
> +    if ( npag<  nbPages ) {
> +	    warning(tr("Invalid number of pages"),
> +		tr("The required number of pages is "
> +	                   "higher than the given number"));
> +	    m.setNumPages(nbPages);
> +    }
> +

Since you're doing this, feel free to simply take out the 'Page' and =

'Number of pages' entries in the UI.

The current UI provides way too much detail as it was used to test the =

oFono handling of repeated pages, outdated update numbers, out-of-order =

pages, etc.  However, these can be just as easily done as a unit test now.

Regards,
-Denis

--===============0597878308753927058==--

