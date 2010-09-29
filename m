Content-Type: multipart/mixed; boundary="===============8799856574645565183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/7] Add message agent interface documentation
Date: Tue, 28 Sep 2010 21:27:12 -0500
Message-ID: <4CA2A400.1050102@gmail.com>
In-Reply-To: <1285606459-1297-4-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8799856574645565183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 09/27/2010 11:54 AM, Aki Niemi wrote:
> ---
>  doc/message-api.txt |   51 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 51 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/message-api.txt b/doc/message-api.txt
> index 9e8d02f..5bdc98d 100644
> --- a/doc/message-api.txt
> +++ b/doc/message-api.txt
> @@ -38,6 +38,29 @@ Methods		dict GetProperties()
>  			message could be queued successfully, this method
>  			returns an object path to the created Message object.
>  =

> +		void RegisterAgent(object path)
> +
> +			Registers an agent to handle received messages.
> +
> +			The object path defines the path of the agent that
> +			will be called when either a text message, a vCard
> +			object or a vCalendar object is ready to be
> +			dispatched.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.InUse

So me and Marcel had a very long talk about this.  We are basically fine
using an Agent for text messaging (however, we agreed that it isn't
really necessary, the signals and history cover all realistic use cases).

What we did not like is being able to register multiple agents.  So
instead we decided that using explicit APIs for this is better.  Please
see the detailed proposal in doc/smartmessaging-api.txt and
doc/pushnotification-api.txt.

The SmartMessaging API will handle reception of vCalendars and vCards.
This API also covers sending of these objects.

The PushNotification API will handle WAP PUSH requests.

We'd like to do all of this from a plugin, so the last thing to figure
out is the plumbing for plugins to be able to track the lifetime of the
sms atom and register the interface appropriately.

Regards,
-Denis

--===============8799856574645565183==--

