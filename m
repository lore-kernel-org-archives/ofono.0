Content-Type: multipart/mixed; boundary="===============4727247699739222202=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] stk-api.txt: Introduce a new API to display abortable
 information
Date: Tue, 29 Mar 2011 22:19:45 -0500
Message-ID: <4D92A151.6050806@gmail.com>
In-Reply-To: <1301329952-10152-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4727247699739222202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 03/28/2011 11:32 AM, Philippe Nunes wrote:
> ---
>  doc/stk-api.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index f8a115e..fc69bb9 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -252,6 +252,7 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
>  			Possible Errors: [service].Error.SimToolkit.EndSession
>  =

>  		void DisplayActionInformation(string text, byte icon_id)
> +						[noreply]
>  =

>  			Supplies a text string and/or icon concerning the
>  			current activity in the terminal and UICC.  The
> @@ -267,6 +268,16 @@ Methods		byte RequestSelection(string title, byte ic=
on_id,
>  			confirmation message to oFono and then should open
>  			the launch browser with the given url.
>  =

> +		void DisplayAbortableActionInfo(string text, byte icon_id)
> +

I've thought some more about this and I think we should name this method
'DisplayAction'

> +			Supplies a text string and/or icon concerning the
> +			current activity in the terminal and UICC. The
> +			text should be displayed to the user on screen
> +			until the call is canceled using Cancel() or until the
> +			user decides to end the session.
> +
> +			Possible Errors: [service].Error.SimToolkit.EndSession
> +
>  		void Cancel() [noreply]
>  =

>  			Asks the agent to cancel any ongoing operation in

Regards,
-Denis

--===============4727247699739222202==--

