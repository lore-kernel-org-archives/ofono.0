Content-Type: multipart/mixed; boundary="===============7952136397622404638=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: APN provisioning with connman (and duplicate profiles in MBPI)
Date: Mon, 07 Aug 2017 14:07:20 -0500
Message-ID: <4e497160-bfa8-1e3f-ba22-0b7aedd61bef@gmail.com>
In-Reply-To: <20170716191047.GY10106@login.tika.stderr.nl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7952136397622404638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthijs,

On 07/16/2017 02:10 PM, Matthijs Kooijman wrote:
> Hey folks,
>
> I just tried Connman and oFono on a Debian stretch system for the first
> time, hoping to get a more robust solution for keeping a cellular and/or
> ethernet connection up. It seems the duo is quite capable of doing what
> I need, but there were a few bumps in setting this up, where I think
> things could be improved.
>
> Some of these issues might be more connman issues, but they're mostly on
> the cross-over area between the two, so I'll post them here for now.
>
> In somewhat chronological order:
>  - I could not find any documentation on how to get a cellular
>    connection up. Plugging in a dongle made the "cellular" technology
>    appear in connman, but no services, with no indication of what needed
>    to happen next.

No services means either an incomplete modem driver, missing TUN module =

or most likely that the APN hasn't been setup properly (e.g. automatic =

provisioning has failed).

>  - When provisioning in oFono fails, a single gprs context is created
>    without an APN. Setting the APN manually made the profile show up in
>    connman and (eventually) work.

oFono creates a single sentinel context when automatic provisioning =

fails.  This is an indication to the provisioning UI that the user =

should be helped/asked/guided in providing a valid context configuration =

(e.g. APN, etc)

It looks like Debian doesn't ship such a UI.

>    It might be better to cange connman to create a service for a context
>    without an APN, and show an error when trying to connect it, instead
>    of completely hiding the context.

See above.  Ideally the desktop environment should detect that the =

provisioning failed and offer the user to configure the APNs with some =

sort of helpful Wizard.

>  - There does not seem to be any official commandline interface to ofono
>    to figure out what is happening. There are "test" python scripts in
>    the source repo, but these are not shipped in the Debian package
>    (reported here: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D86=
8377)

Correct.  A C-based command line UI (similar to e.g. connmanctl) is =

something that is on our TODO list but we haven't gotten around to it yet.

>  - When mobile-broadband-provider-info provision finds multiple matches
>    for the operator (that is, multiple apns all with the same usage
>    type), provisioning fails, disregarding *all* apns found. I believe
>    this even happens when there is just one type duplicate (e.g. if
>    multiple mms profiles are available and just one internet profile,
>    the internet one is not used). Not entirely sure, though.

MBPI database could be improved to make the chances of automatic =

provisioning succeeding higher.  However, a provisioning UI is still needed.

>  - When multiple profiles match, it would not make sense for oFono to
>    just pick an arbitrary one to use. Ideally, it would just create
>    a context for each, and let the user select the right context. For
>    this to actually work, the user must be able to distinguish them, and
>    see all the relevant details for profile/context to allow choosing
>    the right one.

This was solved by using a provisioning UI.  We don't believe that =

pushing selection of the APN onto the user (even a power user) is the =

right approach.

>
>    I tried simply passing "allow_duplicates=3DTRUE" to ..., which does
>    indeed create all contexts, but seems to show only the first two as
>    aservices in connman (not sure why just these two), and there is no
>    way to really distinguish them (the service name is just the
>    currently connected network name).
>

ConnMan only manages internet contexts.

>  - When actually connecting from connman (or activating a context using
>    the ofono test/activate-context script), the reported errors are very
>    unclear. I only got a "Not implemented" error, which is very
>    non-descriptive and, looking at the code, is returned in quite some
>    different places. There's also nothing in the log to indicate what
>    went wrong.
>    The activation error in my case was due to a missing tun kernel
>    module, I submitted a separate patch for that.

Missing tun support in the kernel is reported via ofono_error inside =

drivers/atmodem/gprs-context.c.  So you most definitely should be seeing =

something in the log about it.

Regards,
-Denis

--===============7952136397622404638==--

