Content-Type: multipart/mixed; boundary="===============7853260569268386100=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 10/23] sms: add doc about the extensions D-Bus API
 (not yet implemented)
Date: Wed, 07 Jul 2010 18:01:11 -0500
Message-ID: <4C350737.3000205@gmail.com>
In-Reply-To: <6932dfd49840bacc8ddb72e9c08395f85a840248.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7853260569268386100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +
> +
> +
> +SMS / Messaging interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Requirements:
> +
> + - provide an interface for management of text messages over cell
> +   networks
> +
> + - maintain messaging data while "in transit", meaning, while Ofono
> +   owns it since the time it is submitted for delivery until it is
> +   deemed delivered to the network or had failure (undeliverable /
> +   undelivered).
> +
> + - has to be persistent across daemon invocations (needs offline db)
> +
> + - provides methods to submit a message for delivery, query status,
> +   cancel delivery, as well as signals on status change
> +
> +
> +High level interface
> +
> +  MSGHANDLE :=3D objectpath
> +
> +      Each MSGHANDLE is a message object "in transit" (aka: owned by
> +      oFono). So it becomes a D-Bus object name that supports the
> +      org.ofono.Message interface.
> +
> +  MSGDATA :=3D struct / dict
> +
> +      Data for the message. Still TBD what exactly will come in here,
> +      other than the obvious destination and text data.
> +

Please put this type of stuff into doc/overview.txt or doc/sms.txt.  I'd
like to stick to the API conventions in doc/foo-api.txt.

> +org.ofono.SmsManager                  [interface]
> +
> +    This interface hangs off the modem object in oFono.
> +
> +    Marcel suggests in the future we could have an "any" modem that
> +    orutes routes things automatically. Dennis says that in any case,
> +    most of the times we have a single modem object dangling around.
> +
> +    MSGHANDLE SendMessage(MSGDATA)    [method]
> +
> +        Submit a message for delivery / processing. oFono owns it from
> +        now on until successful delivery, cancellation (by the user)
> +        or cancellation (by oFono). User has to keep a copy around as
> +        oFono only offers persistence to satisfy its needs.
> +
> +    PendingMessages                   [property]
> +
> +        List of MSGHANDLEs which are currently pending/in-transit
> +
> +    GetProperties()	   	      [method]
> +
> +        Get manager's properties; one of them being the list of
> +        pending messages.
> +
> +    ProperyChanged()                  [signal]
> +
> +        A property has changed.
> +
> +    IncomingMessage()                 [signal]
> +
> +        Message arrivedl; class !=3D CLASS_0 FIXME
> +
> +    ImmediateMessage()                [signal]
> +
> +        Message arrived; class =3D=3D CLASS_0 FIXME
> +
> +
> +org.ofono.Message                     [interface]
> +
> +    MSGDATA GetProperties()           [method]
> +
> +        Returns all the data associated to a message, as well as its
> +        current status.
> +
> +    Cancel()                          [method]
> +
> +        Cancel oFono's handling of the message, wether is submitting
> +        it, retrying submissions, etc.
> +
> +    PropertyChanged()                  [signal]
> +
> +        Some property in the message has changed. If status change,
> +        provide old and new status -- to ease up state machine
> +        processing.
> +

Please convert this to proper doc/sms-api.txt style and remove the old API.

> +	Dennis: subscribers can subscribe to signals from all object
> +	that support an interface, so it's easy to subscribe to get
> +	the signals from all the objects without having to subscribe
> +	to each object.

This is a task that needs to be added to the TODO for multiple
interfaces.  In particular NetworkOperator, VoiceCall, PrimaryContext, etc.

Regards,
-Denis

--===============7853260569268386100==--

