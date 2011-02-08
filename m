Content-Type: multipart/mixed; boundary="===============1896560992247298497=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Mon, 07 Feb 2011 20:44:28 -0600
Message-ID: <4D50AE0C.8010704@gmail.com>
In-Reply-To: <AANLkTikfzUHRWtWRzOo07FNXoJ9-53JeEen2hNTZg+_0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1896560992247298497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/07/2011 08:22 PM, Andrzej Zaborowski wrote:
> On 8 February 2011 02:25, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> Actually we should for files that are read during pre-sim but are not
>>>> important enough.  E.g. EFecc, EFli, EFpl, EFiccid, etc.
>>>
>>> But if we "restart SIM initialization procedure", we already re-read
>>> those files so there's nothing more we need to do.  The sim
>>> initialization in 51.011 includes reading those files if I remember
>>> correctly.
>>>
>>
>> I'm still fuzzy on this one.  EFpl/EFli and EFiccid are in a different
>> DF than the rest of the files, so they might not need to be initialized
>> again in practice, unless we're performing a full reset.
> =

> Maybe, although it's such a rare situation that I don't think we're
> gaining anything here by making an assumption that is not documented
> in any spec.
> =

> I'm also fuzzy on what the differences between the Refresh types are
> for us but we can't go wrong by re-reading all files.

And you might be right, but at the very least we still need to handle
simple File Change notifications that affect files critical to system
init.  Today that is e.g. EFfdn, EFbdn, etc.  There's no need to re-read
EFecc, or EFiccid, etc.

>> Honestly I think we should handle all of them, one by one.  It might
>> take a little while, but we have to anyway in the long run.  We can
>> concentrate on the important ones first, e.g. EFcsp, EFspn, EFopl,
>> EFecc, etc.  Sure, in the short term we might not handle each and every
>> file that could be sent via Refresh.  But then we just acknowledge it as
>> a bug and fix it later.  Re-initializing everything just because e.g.
>> EFmbdn or some other unimportant file changed and we're too lazy to fix
>> it is just not a good idea anyway.
> =

> So maybe we should return "Not capable" to a refresh that touches any
> of those files?  At the very least we would need to log some kind of
> warning.  (Then again these user-writable files are so unlikely to be
> changed that I don't think we're losing anything by being safe and
> re-reading everything)

A lot of times we simply don't have a choice to send a 'Not Capable'.
And sure we can add simple dummy handlers for all of the ones we don't
currently handle, so at least we know if something comes up.

>> Your guess is as good as mine right now, however we need this
>> functionality anyway for the 'SIM PIN locked out after we're in
>> sim_ready state' case anyway.  Or if lets say we get a File Changed
>> Notification with EFfdn for example.  There's no sense in re-reading
>> EFiccid, EFpl/EFli as well.
> =

> In case of EFfdn I think we should eventually have a handler which
> will do the right thing and remove or create the affected atoms as
> necessary.

We do not allow EFfdn enabled SIMs, so if this file is being changed
then likely we're going from FDN disabled to FDN enabled.

> =

> But I don't see why EFpl shouldn't change during a Refresh with Full
> file change notification.  I wouldn't call it a guess as much as being
> ready for anything :)  It's not like this is not allowed to happen, so
> there's no reason to think it can't happen.

You are probably right, but see the simple File Change notification case
above.

> =

> Any of those files can also be explicitly speciied in the changed
> files list.  Maybe the solution is to just use a different reset_level
> value when calling sim_add_file_watch for such files.
> =


Why complicate these things with reset level? Only the SIM atom has to
care, and we can take care of these things inside...

Regards,
-Denis

--===============1896560992247298497==--

