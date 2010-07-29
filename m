Content-Type: multipart/mixed; boundary="===============3844816149455684309=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 13/20] SMS: encapsulate D-Bus specific data in 'struct
 sms_msg_dbus_data'
Date: Thu, 29 Jul 2010 16:23:07 -0700
Message-ID: <1280445787.16826.91.camel@localhost.localdomain>
In-Reply-To: <4C51FDF9.3080003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3844816149455684309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-29 at 15:17 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/29/2010 04:47 PM, Inaky Perez-Gonzalez wrote:
> > On Tue, 2010-07-27 at 10:08 -0700, Denis Kenzior wrote:
> >> Hi Inaky,
> >> =

> >>> +/* + * Encapsulate information needed to export an SMS message =

> >>> over D-Bus. + * + * @dbus_path: path of the object in the D-Bus
> >>> + * @dbus_msg: message this originated at + */ +struct =

> >>> sms_msg_dbus_data { +	char *dbus_path; +	DBusMessage *dbus_msg; =

> >>> +}; +
> >> =

> >> I don't really see a point for this structure.  When you send an =

> >> SMS, assuming the arguments and format were valid, you return =

> >> straight away. Thus SendMessage should be marked as not being
> >> ASYNC and storing of DBusMessage is unnecessary.  Rest can be
> >> handled by txq_submit and the dbus path can be easily generated
> >> based on the UUID.
> > =

> > First it serves as transitional storage -- later in the commit =

> > sequences the dbus_msg is removed as it is, as you say, unneeded
> > once all the code is made sync. If at the end only one member is
> > left (dbus_msg)
> =

> Don't get me wrong, if a structure is necessary in the end, so be it.
> However, during the review I only see a structure being introduced that
> is totally unnecessary.  You can simply pass dbus_path around as
> userdata.

Agreed -- at the end, once everything is cleaned up only dbus_path is
necessary, and I agree it could be passed instead of having the struct.
However, for all the intermediate commits not to break (and thus break
bisectability), having that there is a must. =


However, with so much reorganization in the code that has happened
during this review process, it is probably possible to do with out it.
I'll re-audit all that to see how it can be killed.

> If/when this structure does become necessary, feel free to
> introduce it.
> =

> > =

> > In our discussions to plan this stuff you said you wanted the D-Bus =

> > unique name to contain the UUID and the number of PDUs =

> > (/modemX/UUID_PDUs). That means I need to access the SMS object if I
> >  want to generate the name on the fly. I need a backpointer for
> > that.
> > =

> > Even if we remove the _PDUs requirement:
> =

> There is no such requirement.  If I gave you this idea, then I must have
> not been clear enough.  I meant that PDUs would be used to generate the
> UUID.

That simplifies things further, thanks.



--===============3844816149455684309==--

