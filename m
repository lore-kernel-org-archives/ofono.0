Content-Type: multipart/mixed; boundary="===============6077006614170297710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Always call gprs_attached_update on context
 deactivation.
Date: Thu, 15 Aug 2019 15:41:00 -0500
Message-ID: <9d49806c-3f3f-498b-5e93-bbfa9e620cf1@gmail.com>
In-Reply-To: <20190814182444.13508-2-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6077006614170297710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Since its registered context is a condition for being attached
> when running LTE, we might need to update the attached state
> when a context is deactivated. Otherwise we might remain

Well, by definition if we're on LTE then we're attached.  So I'm not =

quite sure what you mean here?

> attached, and connection managers (at least connman) start
> to hammer us to connect a context, eventhough it happens
> automatically in LTE.

What happens automatically?  Yes, it is true that you need a default =

context to attach to LTE.  So activating a context is basically a part =

of the LTE attach procedure.

But that default context does not need to be an internet context (e.g. =

Verizon uses (or used to) use an ims context for this). So ConnMan still =

might need to activate an Internet context even if we're on LTE.

I'm also not sure that the heuristic of 0 active contexts means not =

attached is a good one.  Shouldn't you be using +CREG or +CEREG status =

for this?

> ---
>   src/gprs.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 94d13f82..cb31e2d2 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2738,11 +2738,12 @@ void ofono_gprs_context_deactivated(struct ofono_=
gprs_context *gc,
>   	 * If "Attached" property was about to be signalled as TRUE but there
>   	 * were still active contexts, try again to signal "Attached" property
>   	 * to registered applications after active contexts have been released.
> +	 *
> +	 * ... or in the case of LTE where the attached state were a registered
> +	 * context is a condition for being attached
>   	 */
> -	if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
> -		gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
> -		gprs_attached_update(gc->gprs);
> -	}
> +	gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
> +	gprs_attached_update(gc->gprs);
>   }
>   =

>   int ofono_gprs_context_driver_register(
> =


Regards,
-Denis

--===============6077006614170297710==--

