Content-Type: multipart/mixed; boundary="===============2043794082677274231=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] Add agent API to message atom
Date: Mon, 30 Aug 2010 20:06:21 -0400
Message-ID: <1283213181.6841.107.camel@localhost.localdomain>
In-Reply-To: <1283183452-3897-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2043794082677274231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

>  doc/message-api.txt |   97 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 97 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/message-api.txt b/doc/message-api.txt
> index 693a111..ce96315 100644
> --- a/doc/message-api.txt
> +++ b/doc/message-api.txt
> @@ -26,6 +26,66 @@ Methods		dict GetProperties()
>  =

>  			Send the message in text to the number in to.
>  =

> +		void RegisterTextAgent(object path, string match)
> +
> +			Registers an agent to receive messages.
> +
> +			The object path defines the path of the agent that
> +			will be called when a message is ready to be
> +			dispatched.  The match parameter takes an optional
> +			matching rule in a restricted subset of regular
> +			expression syntax.
> +
> +			TODO: accepted regexp syntax.  Perhaps only allow
> +			simple match rules for the beginning and end of a
> +			message, as well as a free text token match for the
> +			entire message.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.InUse
> +
> +		void RegisterPushAgent(object path, string id)
> +
> +			Registers an agent to receive push messages.
> +
> +			The object path defines the path of the agent that
> +			will be called when a push message is ready to be
> +			dispatched.  The id parameter takes an optional
> +			WAP application ID that is used to match incoming
> +			push messages.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.InUse
> +
> +		void RegisterApplicationAgent(object path, uint dest, uint src)
> +
> +			Registers an agent to receive application messages.
> +
> +			The object path defines the path of the agent that
> +			will be called when an application message is ready
> +			to be dispatched.
> +
> +			The dest parameter is the destination application
> +			port number, and the src parameter is the optional
> +			source application port number.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.InUse
> +
> +		void UnregisterAgent(object path)
> +
> +			Unregisters an agent.  If no agent is registered
> +			that matches the type of an arriving message, it is
> +			silently dropped.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.NotFound
> +					 [service].Error.NotAuthorized
> +

I prefer if we can do a RegisterAgent and UnregisterAgent like we have
in the STK interface. This makes it a lot more consistent throughout the
whole oFono APIs.

This of course means that we need a bit more intelligent matching of the
handled types. In general I am against the overhead of regex for this. I
prefer glob style matching with just * and ?. That should be good
enough. If you really need regex pattern matching then then I think a
specialized oFono plugin with its own APIs is the way to go.


> +MessageAgent Hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.MessageAgent
> +Object path	freely definable
> +
> +Methods		void ImmediateMessage(string message, dict info)
> +
> +			New immediate (class 0) SMS received.  Info has Sender,
> +			LocalSentTime, and SentTime information.  Sender
> +			address is given in string format.  LocalSentTime and
> +			SentTime are given in string form using ISO8601 format.

Should these really be delivered via an agent?

> +		void IncomingMessage(string message, dict info)
> +
> +			New incoming text SMS received.  Info has Sender,
> +			LocalSentTime, and SentTime information.
> +
> +		void IncomingPush(array{byte} message, dict info)
> +
> +			New incoming push message received.  Info has Sender,
> +			LocalSentTime, SentTime, and ApplicationId information.
> +
> +		void IncomingApplication(array{byte} message, dict info)
> +
> +			New incoming application message received.  Info has
> +			Sender, LocalSentTime, SentTime, DestinationPort, and
> +			SourcePort information.

Why the difference between Push and Application. The dict could be
easily used here to differentiate.

Regards

Marcel



--===============2043794082677274231==--

