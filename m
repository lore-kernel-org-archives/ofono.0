Content-Type: multipart/mixed; boundary="===============5322339957551413212=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: mms: next steps
Date: Thu, 10 May 2012 07:06:56 -0700
Message-ID: <1336658816.5970.188.camel@aeonflux>
In-Reply-To: <4FA3F35E.2070008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5322339957551413212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

> Now that mms' TODO is almost empty (I've sent a set of patches yesterday =

> that implement the last entry of the TODO).
> What should we add to release a first version of MMS ?
> =

> What's already in place :
> - MMS submission,
> - MMS reception (automatic retrieval support),
> - MMS storage with status support,
> - (Basic) error management with transaction completion on restart.
> =

> What can be added :
> - Manual retrieval support for MMS reception,

I think we should not do that. Manual has never been a good idea. Lets
try to just have proper error recovery and do this without user
interaction.

> - Delivery report support (M-Delivered.ind),

Sounds like a good thing to add now.

> - Enhance D-Bus API (DeleteMessages(), DeleteConversation() ...)

Send proposals for this. Sounds on the first look reasonable. However
the devil might be in the details.

Regards

Marcel



--===============5322339957551413212==--

