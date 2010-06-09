Content-Type: multipart/mixed; boundary="===============5373843148374200671=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: SMS status report
Date: Wed, 09 Jun 2010 16:50:34 -0700
Message-ID: <1276127434.2509.38.camel@localhost.localdomain>
In-Reply-To: <1276092115-22684-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5373843148374200671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi

On Wed, 2010-06-09 at 17:01 +0300, Pasi Miettinen wrote: =

> Hello again,
> this is the new version of SMS status report. It is implemented
> according to the latest comments which you gave about my previous
> patches. These patches include concatenated status report
> assembling and status report result printing via history plugin.
> =

> Next I am going to take a new look at the saving of the pending
> status reports to imsi file.

I found out right before going offline for last week that you were
working on status reports -- good to know I am not alone.

I'd like to coordinate with your work. I had started tackling the issue
from the infrastructure of the whole SMS code and had recently started
work on the actual status-report part. Once your code started showing
up, I've ditched part of my code and rebased on top of what you had.

Could you please take a look at the smsdbus branch in my repo and tell
me if there is anything there that will conflict with the way you are
implementing things?

git://gitorious.org/~inakypg/ofono/ofono-inakypg.git

there is a set of patches there which lay out changes in the SMS code
infrastructure to do the following:

- export of SMS messages to D-Bus

  - each message is an object in the bus

  - messages can be canceled, properties queried, etc

- in transit SMS messages get an state machine describing at which phase
they are. D-Bus signals are sent in transitions

- messages waiting for an status report are queued in a separate queue

- a unique ID is generated based on message contents and destination
nunmber to reduce the chances of collision -- need still to apply it to
received messages so it's easier to gather status reports from different
fragments

- provide an internal C API for managing messages (D-Bus's maps on top
of this)


FIXMEs/TODOs/RFCs:

  still need to cleanup some more to adapt to your code

  plenty of whatifs/FIXMEs litered around the code still

  remove the 'request-status-report' from D-Bus::SendMessage

  message id needs more uniquedness fed into it

Note the branch depends on some more commits that are still not in
mainline; those are in my master branch and pending a resubmit to
upstream.

Thanks!



--===============5373843148374200671==--

