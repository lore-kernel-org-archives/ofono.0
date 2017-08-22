Content-Type: multipart/mixed; boundary="===============3254490579234069290=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: APN provisioning with connman (and duplicate profiles in MBPI)
Date: Tue, 22 Aug 2017 10:37:40 -0500
Message-ID: <59183fb8-e4ef-616b-126c-4b6279383139@gmail.com>
In-Reply-To: <20170822065008.GY10106@login.tika.stderr.nl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3254490579234069290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthijs,

On 08/22/2017 01:50 AM, Matthijs Kooijman wrote:
> Hi Denis,
> =

>> oFono creates a single sentinel context when automatic provisioning fail=
s.
>> This is an indication to the provisioning UI that the user should be
>> helped/asked/guided in providing a valid context configuration (e.g. APN,
>> etc)
> I was running on a headless beagleboard, so no GUI/desktop environment
> present. I was asssuming that connman would offer the UI necessary to
> set up Ofono, but I now understand this is not the case.

The necessity of the UI depends on how good your database is.  There are =

other dbs besides mbpi, e.g. the one from Android.  Or you can roll your =

own specifically to your usecase.

> =

>> Correct.  A C-based command line UI (similar to e.g. connmanctl) is
>> something that is on our TODO list but we haven't gotten around to it ye=
t.
> Ah, that would be useful indeed.
> =

> Might I suggest that the documentation could be improved in this area?
> In particular by:
>   - noting that oFono provides a service, and can be controlled through
>     separate provisioning UIs.
>   - noting that oFono detects modems automatically, tries to set up a
>     context/APN (but might need manual provisioning) and that if it is
>     set up correctly, a service appears in connman.
>   - noting that there is no CLI tool to control oFono, but there are some
>     helpful scripts in the source tree.
> =

> Had I known this, I think my journey would have been much shorter :-)
> =

>>> - When actually connecting from connman (or activating a context using
>>>    the ofono test/activate-context script), the reported errors are very
>>>    unclear. I only got a "Not implemented" error, which is very
>>>    non-descriptive and, looking at the code, is returned in quite some
>>>    different places. There's also nothing in the log to indicate what
>>>    went wrong.
>>>    The activation error in my case was due to a missing tun kernel
>>>    module, I submitted a separate patch for that.
>>
>> Missing tun support in the kernel is reported via ofono_error inside
>> drivers/atmodem/gprs-context.c.  So you most definitely should be seeing
>> something in the log about it.
> There is indeed an error message in the source:
> =

> static int at_gprs_context_probe(struct ofono_gprs_context *gc, unsigned =
int vendor, void *data)
> ...
>                  ofono_error("Missing support for TUN/TAP devices");
> =

> However, this error message occurs during the probe, e.g. when plugging
> in the modem. At that time, it prevents context driver from being added.
> When actually trying to activate the context, it fails without any
> meaningful error message (`assign_context()` in `src/gprs.c` silently
> fails since no context driver is available).
> =

> In any case, please also see the patch I submitted, which makes sure
> that tun autoloading works (so all of this is only a problem when tun
> support is completely disabled, not just when the module is not loaded
> yet).
> =


I don't see this one in my queue, please resend.  I was away most of =

June/July, so it may have fallen through the cracks.

Regards,
-Denis

--===============3254490579234069290==--

