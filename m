Content-Type: multipart/mixed; boundary="===============1844238344592551995=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 08/20] sms: document the org.ofono.SMSMessage D-Bus
 interface
Date: Mon, 26 Jul 2010 10:19:18 -0700
Message-ID: <1280164758.26204.157.camel@localhost.localdomain>
In-Reply-To: <4C4A2184.1090701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1844238344592551995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 16:11 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > ---
> >  doc/sms-api.txt |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
--
> >  1 files changed, 47 insertions(+), 2 deletions(-)
> > =

> > diff --git a/doc/sms-api.txt b/doc/sms-api.txt
> > index 1fc32ac..af4baae 100644
> > --- a/doc/sms-api.txt
> > +++ b/doc/sms-api.txt
> > @@ -22,9 +22,27 @@ Methods		dict GetProperties()
> >  			Possible Errors: [service].Error.InvalidArguments
> >  					 [service].Error.DoesNotExist
> >  =

> > -		void SendMessage(string to, string text)
> > +		string SendMessage(string destination_number, string text)
> =

> Actually keep string to, I like that better.  The returned type should
> be 'object' (the object path of the new message) not 'string'.

Changed

> >  =

> > -			Send the message in text to the number in to.
> > +                        Submit a message for delivery /
> > +                        processing. oFono owns it from now on until
> > +                        successful delivery, cancellation (by the
> > +                        user) or cancellation (by oFono). User has to
> > +                        keep a copy around as oFono only offers
> > +                        persistence to satisfy its needs.
> > +
> > +                        Returns the name of the D-Bus object that
> > +                        represents said SMS Message.
> =

> Try to use tabs and not spaces for indentation.

Changed to tab (x8)

> > +
> > +			Possible Errors: [service].Error.InvalidArguments
> > +
> > +                array{string} PendingMessages()
> =

> array{object} here, and using Messages is better.

Done

> > +
> > +                        Returns a list of SMS Messages that have been
> > +                        submitted for delivery and that are still
> > +                        pending.
> > +
> > +                        FIXME: currently not implemented
> >  =

> >  Signals		PropertyChanged(string name, variant value)
> >  =

> > @@ -64,3 +82,30 @@ Properties	string ServiceCenterAddress
> >  				"ps-preferred" - Use CS if PS is unavailable
> >  =

> >  			By default oFono uses "cs-preferred" setting.
> > +
> > +
> > +SMS / Messaging interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +Service		org.ofono
> > +Interface	org.ofono.SMSMessage
> =

> oFono API is full CamelCase, so this should be SmsMessage.

I disagree. It would be like that if SMS was a word, but it is an
acronym. It makes it quite confusing, if you ask me. If that's still how
you like it, I'll change it, but I think it is wrong to capitalize an
acronym.

> > +Object path	[variable prefix]/modemX/message_id
> =

> Please follow the conventions for Object Path, e.g. see
> doc/voicecall-api.txt

Fixed

> > +
> > +Methods		dict GetProperties()
> > +
> > +			Returns a dictionary with the current
> > +			properties of a message.
> > +
> > +                void Cancel()
> > +
> > +                        Cancels a pending message's delivery.
> > +
> > +Signals		PropertyChanged(string name, variant value)
> > +
> > +			This signal indicates a changed value of the given
> > +			property.
> > +
> > +Properties	string TXState
> > +
> > +			Current transmission state.
> > +
> =

> Rename this to State and include the possible state values please.

Done



--===============1844238344592551995==--

