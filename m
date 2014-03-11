Content-Type: multipart/mixed; boundary="===============1597649108967928438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Port ofono test scripts to also work with Python3
Date: Tue, 11 Mar 2014 10:33:58 -0500
Message-ID: <531F2CE6.7080906@gmail.com>
In-Reply-To: <20140306085854.GG22397@piware.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1597649108967928438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 03/06/2014 02:58 AM, Martin Pitt wrote:
> Hello ofono developers,
>
> I already sent this last week, but apparently it never got moderated.
> I (temporarily) subscribed now [1].
>
> We are in the process of eliminating Python 2 from our images, and
> thus I ported the ofono test scripts to Python 3.

Could you submit these patches using git-send-email?  It would be way =

easier for me to reply with my comments.

>
> The first three patches keep the current behaviour and just make the
> scripts bilingual, i. e. they will work with both Python >=3D 2.6 and
> Python 3. They are rather big, but mostly mechanical (2to3 with some
> overzealous bits removed, and cleaning up some print statements).

I looked at these and I'm fine with the first 3, however there are some =

little gotchas that you need to fix.

For example,

Python 2.7.5 (default, Aug 26 2013, 23:31:36)
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
 >>> print()
()
 >>>

This is probably not what you intended.

Patches 2 and 3 seem to be just fine.  Couldn't apply because they =

depend on patch 1.

>
> Patch 4 moves the scripts from the ancient and long-unmaintained
> static gobject bindings to gobject-introspection. That's available for
> both python 2 and 3.

This seems fine with me as well.  If there are no objections I am okay =

applying it.

>
> Patch 5 does the remaining bits (unicode and raw_input, and updating
> hashbangs) and is currently *not* bilingual. If you want these scripts
> to only work with Python 3 (which should be fine these days), it can
> be applied (we already did that in the ofono-rilmodem branch[2]).
> Otherwise, if you generally agree to doing this conversion I'm
> happy to change it to a form where it works with both Python versions.
> But that's more involved and it's work that I would only do after
> getting your "yes, we'll take it" confirmation. :-)
>

I'm okay moving to Python 3, but you might want to send this as an RFC =

to garner more feedback.

Regards,
-Denis

--===============1597649108967928438==--

