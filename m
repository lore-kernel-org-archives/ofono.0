Content-Type: multipart/mixed; boundary="===============0968605377344403013=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [mmsd] Error handling while receiving message
Date: Fri, 23 Mar 2012 11:48:40 -0700
Message-ID: <1332528520.1870.51.camel@aeonflux>
In-Reply-To: <4F6C4526.20502@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0968605377344403013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

> I'm working on handling errors while receiving an MMS (listed in TODO as =

> : "Error cases should handled and reported to the application layer." in =

> MMS Reception section).
> =

> What kind of error do you want to report to the application : generic =

> MMS reception error such as "Unable to decode message", "Unable to =

> download message" ... or more accurate error (error code, "HTTP error =

> XXX", "Communication error while downloading message"... ) ?
> =

> Since the reception is automatically performed, there is no D-Bus reply =

> msg to use to send error back to the application !
> I cannot always handle the error in 'Message' interface since the D-Bus =

> object (associated to the message) does not exist before having =

> downloaded the entire message. More generally, how to handle errors that =

> occurs before the message D-Bus object has been published ?
> Should I define a new signal ("MessageError") in 'Service' interface to =

> report errors ?
> =

> What kind of information the reported error should contain ? the sender =

> (if the notification has been decoded), the meta file path (if =

> available) ... ?

as a general statement, I would prefer that we have proper error
recovery internally. So for errors that we can deal with or just retry,
we should not tell the application anything. And just try to fix it next
time we can. For example failed download because of network outage, lets
just try again next time.

That should take care of most errors, for invalid messages, I am fine
with just printing a log message and ignoring the message. If the other
side sends us invalid data, we can not do much about it anyway. Invalid
is invalid. And for security purposes we should just drop it.

Regards

Marcel



--===============0968605377344403013==--

