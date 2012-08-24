Content-Type: multipart/mixed; boundary="===============0305158006099079492=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] doc: Update STK API regarding the new argument
 immediate_response
Date: Fri, 24 Aug 2012 10:48:30 -0500
Message-ID: <5037A24E.5020804@gmail.com>
In-Reply-To: <1345818505-17175-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0305158006099079492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/24/2012 09:28 AM, Philippe Nunes wrote:
> ---
>   doc/stk-api.txt |   13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index 471e5d6..0d96246 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -170,8 +170,9 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>   					string default, byte min, byte max,
>   					boolean hide_typing)
>
> -			Same as GetInput but only digit characters (0-9, *#+)
> -			are expected.
> +			Same as RequestInput but only digit characters
> +			(0-9, *#+) are expected. In hidden entry mode, "+" is
> +			not allowed for user input.
>
>   			Possible Errors: [service].Error.SimToolkit.GoBack
>   					 [service].Error.SimToolkit.EndSession

Why is this chunk in this patch? What you're changing here does not =

match the patch description at all.

> @@ -185,10 +186,14 @@ Methods		byte RequestSelection(string title, byte i=
con_id,
>   			Possible Errors: [service].Error.SimToolkit.GoBack
>   					 [service].Error.SimToolkit.EndSession
>
> -		string RequestDigit(string alpha, byte icon_id)
> +		string RequestDigit(string alpha, byte icon_id,
> +					boolean immediate_response)
>
>   			Same as above, but only digits (0-9, *#+) are
> -			expected.
> +			expected. The parameter immediate_response indicates
> +			that the entered digit shall not be displayed and the
> +			response shall be sent immediately after the key press.
> +			"+" is not allowed for user input in this mode.
>
>   			Possible Errors: [service].Error.SimToolkit.GoBack
>   					 [service].Error.SimToolkit.EndSession

Unfortunately we cannot do it this way, the oFono API is frozen, we can =

only add new Methods, not change their arguments.  Naming is tricky =

since the immediate_response crap in the STK spec is utterly stupid. =

Name it RequestQuickDigit for now and I will think on it some more.

Regards,
-Denis

--===============0305158006099079492==--

