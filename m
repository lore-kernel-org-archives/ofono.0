Content-Type: multipart/mixed; boundary="===============5121662084152734241=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 4/4] doc: Describe LaunchBrowser method
Date: Wed, 12 Jan 2011 16:26:40 -0600
Message-ID: <4D2E2AA0.3070707@gmail.com>
In-Reply-To: <1294652623-17287-5-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5121662084152734241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/10/2011 03:43 AM, Jeevaka Badrappan wrote:
> ---
>  doc/stk-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index 425ee23..347e39d 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -257,6 +257,14 @@ Methods		byte RequestSelection(string title, byte ic=
on_id,
>  			until the call is canceled using Cancel().  This
>  			method should not return.
>  =

> +		boolean LaunchBrowser() (string information, byte icon_id,
> +						string url)
> +
> +			Asks the agent to request user to confirm launch
> +			browser. If confirmed, then the agent should send
> +			confirmation message to oFono and then should open
> +			the launch browser with the given url.
> +

Let us call this ConfirmLaunchBrowser

>  		void Cancel() [noreply]
>  =

>  			Asks the agent to cancel any ongoing operation in

Regards,
-Denis

--===============5121662084152734241==--

