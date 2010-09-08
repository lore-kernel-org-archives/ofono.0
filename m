Content-Type: multipart/mixed; boundary="===============2714826912639174462=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFCv3] Add message agent API
Date: Wed, 08 Sep 2010 16:04:47 +0200
Message-ID: <1283954687.6640.35.camel@localhost.localdomain>
In-Reply-To: <1283949419-30222-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2714826912639174462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> +		void RegisterAgent(object path, string type)
> +
> +			Registers an agent to handle received messages.
> +
> +			The object path defines the path of the agent that
> +			will be called when a message is ready to be
> +			dispatched.  The type parameters accepts a MIME
> +			type of the messages this agent is willing to
> +			accept.  Some common types include:
> +
> +				"text/plain" - Regular text messages
> +				"text/x-vcard" - vCard objects
> +				"text/calendar" - vCalendar objects
> +				"application/vnd.oma.push" - WAP push
> +				"application/x-sms-agent" - Any datagram
> +
> +			Wildcards are not allowed as the MIME subtype, but
> +			registering an agent on a generic port is supported.
> +			For instance, to listen on port 5678, the agent
> +			would need to register using type:
> +
> +				"application/x-sms-agent;port=3D5678"

so my obvious question here is, what kind of x-sms-agent type
applications do you expect? The need for text, vcard, vcalendar and push
messages is pretty clear. I still haven't figured out what other
applications are out there that we want do support with this. Can you
please give us some concert examples. I think that everybody else has
abandoned any other SMS message types.

Regards

Marcel



--===============2714826912639174462==--

